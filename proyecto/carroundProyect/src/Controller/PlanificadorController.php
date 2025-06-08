<?php

namespace App\Controller;

use App\Repository\ServicioRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\UsuarioRepository;
use App\Service\JsonPlanificacionService;
use DateTime;

use function Symfony\Component\DependencyInjection\Loader\Configurator\service;

final class PlanificadorController extends AbstractController
{
    #[Route('/planificador/{fecha}', name: 'app_planificador')]
    public function datosPlanficacion(
        UsuarioRepository $conductoresRepository, 
        string $fecha, 
        ServicioRepository $servicioRepository,
        JsonPlanificacionService $jsonPlanificacion
        
        ): Response
    {

        $rolBuscado='ROLE_CONDUCTOR';
        $conductores = [];
        $conductores= $conductoresRepository->createQueryBuilder('c')
            ->where('JSON_CONTAINS(c.rol, :rol)')
            ->setParameter('rol', json_encode($rolBuscado))
            ->getQuery()
            ->getResult();
        
        $fechaFiltro= $fecha ? \DateTime::createFromFormat('Y-m-d',$fecha):new \DateTime();
        $fechaFiltro->setTime(0, 0, 0);
        $servicios= $servicioRepository->findBy(['fecha'=>$fechaFiltro]);

        $jsonDatos=$jsonPlanificacion->obtenerJsonPlanificacion($conductores,$servicios);

        $rutajson=$jsonDatos['ruta'];

        $procesoScript= new \Symfony\Component\Process\Process([
            __DIR__ . '/../../moduloPython/env/bin/python',
            __DIR__ . '/../../moduloPython/obtenerPlanificacion.py',
            $rutajson
        ]);
        $procesoScript->run();

        if(!$procesoScript->isSuccessful()){
            return new Response("Error en la ejecución del script de Python: " . $procesoScript->getErrorOutput(), 500);
        }
        $planificacion= json_encode($procesoScript->getOutput(),true);


        return $this->render('planificador/index.html.twig', [
            'conductores' => $conductores,
            'servicios'=>$servicios,
            'fecha'=>$fechaFiltro->format('d-m-Y'),
            'planficacion'=>$planificacion
        ]);
    }
}
