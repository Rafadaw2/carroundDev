<?php

namespace App\Controller;

use App\Repository\ServicioRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\UsuarioRepository;
use App\Service\JsonPlanificacionService;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use phpDocumentor\Reflection\Types\Null_;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Serializer\Encoder\JsonDecode;

use function PHPUnit\Framework\fileExists;
use function PHPUnit\Framework\isNull;
use function Symfony\Component\DependencyInjection\Loader\Configurator\service;
use Symfony\Component\HttpFoundation\Request;

final class PlanificadorController extends AbstractController
{


    //OBTIENE LA PLANIFICACION DE UNA FECHA Y LA MUESTRA
    #[Route('/planficador/show', name: 'app_show_planificacion')]
    public function mostrarPlanficacion(ServicioRepository $servicioRepository, Request $request): Response
    {
        
        $fecha = $request->query->get('fecha');
        $fechaFiltro= $fecha ? \DateTime::createFromFormat('Y-m-d',$fecha):new \DateTime();
        $fechaFiltro->setTime(0, 0, 0);
        //Obtengo los servicios planificados
        $servicios = $servicioRepository->createQueryBuilder('s')
            ->where('s.fecha = :fecha')
            ->andWhere('s.conductor IS NOT NULL AND s.anulado = 0 OR s.anulado IS NULL')
            ->setParameter('fecha', $fechaFiltro)
            ->orderBy('s.horaRecogidaPrevista', 'ASC')
            ->getQuery()
            ->getResult();
        //Me saco los conductores de esos servicios
        /*$conductores=[];
        $ids=[];
        foreach($servicios as $servicio){
            $conductor=$servicio->getConductor();
                if ($conductor && !in_array($conductor->getId(), $ids)) {
                    $conductores[] = $conductor;
                    $ids[] = $conductor->getId();
                }
        }
        */
        return $this->render('planificador/planificadorView.html.twig', [
            'servicios' => $servicios,
            'fecha'=>$fechaFiltro->format('d-m-Y'),
            'titulo'=>'Planificación del '
        ]);
    }


    //CALCULA LA PLANFICACION DEL DIA DE HOY
    #[Route('/planificador', name: 'app_planificador')]
    public function planificarHoy(
        UsuarioRepository $conductoresRepository,
        ServicioRepository $servicioRepository,
        JsonPlanificacionService $jsonPlanificacion

    ): Response {

        $rolBuscado = 'ROLE_CONDUCTOR';
        $conductores = [];
        $todos = $conductoresRepository->findAll();
        $conductores = array_filter($todos, function ($u) {
            return in_array('ROLE_CONDUCTOR', $u->getRoles());
        });
        $conductores = array_values($conductores);

        $fechaFiltro = new \DateTime();
        $fechaFiltro->setTime(0, 0, 0);
        $servicios = $servicioRepository->findBy(['fecha' => $fechaFiltro]);

        $jsonDatos = $jsonPlanificacion->obtenerJsonPlanificacion($servicios, $conductores);

        $rutajson = $jsonDatos['ruta'];

        $procesoScript = new \Symfony\Component\Process\Process([
            __DIR__ . '/../../moduloPython/env/bin/python',
            __DIR__ . '/../../moduloPython/obtenerPlanificacion.py',
            $rutajson
        ]);
        $procesoScript->setTimeout(300);
        $procesoScript->run();

        if (!$procesoScript->isSuccessful()) {
            return new Response(
                "Error en la ejecución del script de Python:\n" .
                    $procesoScript->getErrorOutput() . "\n" .
                    $procesoScript->getOutput(), // esto muestra stdout también
                500
            );
        }

        $asignaciones = json_decode($procesoScript->getOutput(), true);

        $planificacionJson = json_encode($asignaciones, JSON_PRETTY_PRINT);
        $ruta = __DIR__ . '/../../planificacionEficiente';

        $archivoPlanficacion = new Filesystem();
        if (!fileExists($ruta)) {
            $archivoPlanficacion->mkdir($ruta);
        }
        $fecha = (new \DateTime())->format('Y-m-d');
        $nombre = "planficacionEficiente_$fecha.json";
        $destino = $ruta . '/' . $nombre;

        $archivoPlanficacion->dumpFile($destino, $planificacionJson);


        return $this->render('planificador/index.html.twig', [
            'conductores' => $conductores,
            'servicios' => $servicios,
            'fecha' => $fechaFiltro->format('d-m-Y'),
            'asignaciones' => $asignaciones
        ]);
    }


    //CONFIRMA O PERSISTE LA PLANIFICACION DE UNA FECHA
    #[Route('/planificador/confirmar/{fecha}', name: 'app_confirmarPlanficacion')]
    public function confirmarPlanficacion(
        UsuarioRepository $conductoresRepository,
        string $fecha,
        ServicioRepository $servicioRepository,
        EntityManagerInterface $entity_manager,
        UsuarioRepository $usuarioRepository

    ): Response {

        $ruta = __DIR__ . '/../../planificacionEficiente';
        $nombre = "planficacionEficiente_$fecha.json";
        $destino = $ruta . '/' . $nombre;

        $jsonDatos = file_get_contents($destino);
        $datosPlan = json_decode($jsonDatos,true);
        foreach ($datosPlan as $asignacion) {
            //Nos traemos al conductor
            $idCondcutor = $asignacion['id'];
            $conductor = $usuarioRepository->findOneBy(['id' => $idCondcutor]);
            $rutas = $asignacion['ruta'];
            //recorremos sus rutas
            foreach ($rutas as $ruta) {
                //Para cada servicio
                $idServicio = $ruta['servicio_id'];
                $servicio = $servicioRepository->findOneBy(['id' => $idServicio]);
                //Le asignamos su conductor
                $servicio->setConductor($conductor);
                $fechaBase = \DateTime::createFromFormat('Y-m-d', $fecha);
                $horaEstim=$ruta['hora_estim'];
                $hora = (new \DateTime())->setTime(0, 0)->modify("+{$horaEstim} seconds");
                $horaFormateada = $hora->format('H:i:s');

                if($ruta['tipo']=='recogida'){

                    $servicio->setHoraRecogidaPrevista($horaFormateada);
                }else{
                    $servicio->setHoraEntregaPrevista($horaFormateada);
                }
                
                $entity_manager->persist($servicio);
                $entity_manager->flush();
            }
        }


        return $this->render('mensajes/index.html.twig', [
            'mensaje' => 'La acción se ha completado con éxito'
         
        ]);
    }


    //CALCULA LA PLANFICACION DEL DIA DE HOY

    #[Route('/planificador/{fecha}', name: 'app_planificadorFecha')]
    public function planificarPorFecha(
        UsuarioRepository $conductoresRepository,
        string $fecha,
        ServicioRepository $servicioRepository,
        JsonPlanificacionService $jsonPlanificacion

    ): Response {

        $conductores = [];
        $todos = $conductoresRepository->findAll();
        $conductores = array_filter($todos, function ($u) {
            return in_array('ROLE_CONDUCTOR', $u->getRoles());
        });
        $conductores = array_values($conductores);

        $fechaFiltro = \DateTime::createFromFormat('Y-m-d', $fecha);
        $fechaFiltrada=$fechaFiltro->setTime(0, 0, 0);
        $servicios = $servicioRepository->createQueryBuilder('s')
            ->where('s.fecha = :fecha')
            ->andWhere('s.activo = 0 OR s.activo IS NULL')
            ->setParameter('fecha', $fecha)
            ->getQuery()
            ->getResult();

        $jsonDatos = $jsonPlanificacion->obtenerJsonPlanificacion($servicios, $conductores);

        $rutajson = $jsonDatos['ruta'];

        $procesoScript = new \Symfony\Component\Process\Process([
            __DIR__ . '/../../moduloPython/env/bin/python',
            __DIR__ . '/../../moduloPython/obtenerPlanificacion.py',
            $rutajson
        ]);
        $procesoScript->setTimeout(300);
        $procesoScript->run();

        if (!$procesoScript->isSuccessful()) {
            return new Response(
                "Error en la ejecución del script de Python:\n" .
                    $procesoScript->getErrorOutput() . "\n" .
                    $procesoScript->getOutput(), // esto muestra stdout también
                500
            );
        }

        $asignaciones = json_decode($procesoScript->getOutput(), true);

        $planificacionJson = json_encode($asignaciones, JSON_PRETTY_PRINT);
        $ruta = __DIR__ . '/../../planificacionEficiente';

        $archivoPlanficacion = new Filesystem();
        if (!fileExists($ruta)) {
            $archivoPlanficacion->mkdir($ruta);
        }
        $fechaformat=$fechaFiltro->format('d-m-Y');
        $nombre = "planficacionEficiente_$fechaformat.json";
        $destino = $ruta . '/' . $nombre;

        $archivoPlanficacion->dumpFile($destino, $planificacionJson);


        return $this->render('planificador/index.html.twig', [
            'conductores' => $conductores,
            'servicios' => $servicios,
            'fecha' => $fechaformat,
            'asignaciones' => $asignaciones,
            'titulo'=>'Planficación del '
        ]);
    }

     #[Route('/prueba', name: 'app_planificadorPrueba')]
    public function prueba(
   

    ): Response {

        return $this->render('planificador/index.html.twig', [
            'conductores' => $conductores,
            'servicios' => $servicios,
            'fecha' => $fechaformat,
            'asignaciones' => $asignaciones,
            'titulo'=>'Planficación del '
        ]);
    }
}
