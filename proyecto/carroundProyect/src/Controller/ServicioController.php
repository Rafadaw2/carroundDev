<?php

namespace App\Controller;

use App\Entity\Servicio;
use App\Form\NewServiceFormType;
use App\Form\PlanServiceFormType;
use App\Repository\ServicioRepository;
use App\Repository\VehiculoRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;
use App\Service\GeocodingService;
use DateTime;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Serializer\SerializerInterface;



final class ServicioController extends AbstractController
{
    #[Route('/servicio/new', name: 'app_servicio')]
    public function newService(Request $request, EntityManagerInterface $entityManager, GeocodingService $geocoding): Response
    {
        //Solo pueden crear servicios los planificadores y clientes
        if (!$this->isGranted('ROLE_PLANIFICADOR') && !$this->isGranted('ROLE_CLIENTE')) {
            throw $this->createAccessDeniedException();
        }
        $servicio= new Servicio();
        $form=$this->createForm(NewServiceFormType::class, $servicio);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            
            $direccionRecogida=$servicio->getDireccionRecogida();
            $direccionEntrega=$servicio->getDireccionEntrega();

            $coordenadasRecogida=$geocoding->obtenerCoordenadas($direccionRecogida);
            $coordenadasEntrega=$geocoding->obtenerCoordenadas($direccionEntrega);

            if($coordenadasRecogida && $coordenadasEntrega){
                $latitudRecogida=$coordenadasRecogida['latitud'];
                $longitudRecogida=$coordenadasRecogida['longitud'];
                $latitudEntrega=$coordenadasEntrega['latitud'];
                $longitudEntrega=$coordenadasEntrega['longitud'];

                $servicio->setLatitudRecogida($latitudRecogida);
                $servicio->setLongitudRecogida($longitudRecogida);

                $servicio->setLatitudEntrega($latitudEntrega);
                $servicio->setLongitudEntrega($longitudEntrega);


            }else{
                echo 'Error';
            }
            $creador=$this->getUser();
            $servicio->setCreador($creador);
            $servicio->setAnulado(0);
            $entityManager->persist($servicio);
            $entityManager->flush();
            return $this->redirectToRoute('app_servicio');
        }
        return $this->render('servicio/newServicioForm.html.twig', [
            'newServiceForm' => $form->createView(),
            'google_api_key'=> $this->getParameter('google_api_key')
        ]);
    }
    //EDITA UN SERVICIO
    #[Route('/planificador/servicio/{id}/edit', name: 'app_editServicio')]
    public function editService(Request $request, EntityManagerInterface $entityManager, Servicio $servicio,GeocodingService $geocoding): Response
    {
        $form=$this->createForm(PlanServiceFormType::class, $servicio);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            $direccionRecogida=$servicio->getDireccionRecogida();
            $direccionEntrega=$servicio->getDireccionEntrega();

            $coordenadasRecogida=$geocoding->obtenerCoordenadas($direccionRecogida);
            $coordenadasEntrega=$geocoding->obtenerCoordenadas($direccionEntrega);
            $latitudRecogida=$coordenadasRecogida['latitud'];
            $longitudRecogida=$coordenadasRecogida['longitud'];
            $latitudEntrega=$coordenadasEntrega['latitud'];
            $longitudEntrega=$coordenadasEntrega['longitud'];

            $servicio->setLatitudRecogida($latitudRecogida);
            $servicio->setLongitudRecogida($longitudRecogida);

            $servicio->setLatitudEntrega($latitudEntrega);
            $servicio->setLongitudEntrega($longitudEntrega);
            $entityManager->persist($servicio);
            $entityManager->flush();
            return $this->redirectToRoute('app_show_servicio',['fecha'=>$servicio->getFecha()->format('Y-m-d')]);
        }
        return $this->render('servicio/editServiceForm.html.twig', [
            'PlanServiceForm' => $form->createView(),
            'google_api_key'=> $this->getParameter('google_api_key')
        ]);
    }
    //INICA UN SERVICIO
    #[Route('/conductor/servicio/iniciar/{id}', name: 'app_iniciarServicio')]
    public function inicarServicio(int $id, EntityManagerInterface $entityManager, ServicioRepository $servicioRepository, Request $request): Response
    {
        $hora=new DateTime();
        $servicio=$servicioRepository->findOneBy(['id'=>$id]);
        $datos=json_decode($request->getContent(),true);
        $km=$datos['kmInicial'];
        $servicio->setKmInicial($km);
        $servicio->setHoraRecogidaReal((new \DateTime())->format('H:i:s'));
        $entityManager->persist($servicio);
        $entityManager->flush();
        return new JsonResponse([
            'mensaje' => 'Actualizado'
        ]);
    }
    //FINALIZA UN SERVICIO
        #[Route('/conductor/servicio/finalizar/{id}', name: 'app_finalizarServicio')]
    public function finalizarServicio(int $id, EntityManagerInterface $entityManager, ServicioRepository $servicioRepository, Request $request): Response
    {
        $hora=new DateTime();
        $servicio=$servicioRepository->findOneBy(['id'=>$id]);
        $datos=json_decode($request->getContent(),true);
        $km=$datos['kmFinal'];
        $servicio->setKmFinal($km);
        $servicio->setHoraEntregaReal((new \DateTime())->format('H:i:s'));
        $entityManager->persist($servicio);
        $entityManager->flush();
        return new JsonResponse([
            'mensaje' => 'Actualizado'
        ]);
    }
    //VISUALIZA LOS SERVICIOS DEL DIA O UNA FECHA ESPECIFICA
    #[Route('planificador/servicio/show', name: 'app_show_servicio')]
    public function showServicesByDate(ServicioRepository $servicioRepository, Request $request): Response
    {
        
        $fecha = $request->query->get('fecha');
        $fechaFiltro= $fecha ? \DateTime::createFromFormat('Y-m-d',$fecha):new \DateTime();
        $fechaFiltro->setTime(0, 0, 0);
        $qb = $servicioRepository->createQueryBuilder('s')
            ->where('s.fecha = :fecha')
            ->andWhere('s.anulado IS NULL OR s.anulado = 0')
            ->andWhere('s.horaEntregaPrevista IS NULL ')
            ->andWhere('s.horaRecogidaPrevista IS NULL ')
            ->setParameter('fecha', $fechaFiltro);

        $servicios = $qb->getQuery()->getResult();

        return $this->render('servicio/servicioView.html.twig', [
            'servicios' => $servicios,
            'fecha'=>$fechaFiltro->format('Y-m-d'),
            'titulo'=>'Servicios del '
        ]);
    }
    #[Route('/planificador/servicio/show/{matricula}', name: 'app_show_serviciosMatricula')]
    public function showServicesPorMatricula(ServicioRepository $servicioRepository, Request $request, VehiculoRepository $vehiculoRepository): Response
    {
        $matricula = $request->query->get('matricula');
        $vehiculo= $vehiculoRepository->findOneBy(['matricula'=>$matricula]);
        $servicios= $servicioRepository->findBy(['vehiculo'=>$vehiculo->getId()]);//El nombre es el del atributo de la clase



        return $this->render('servicio/servicioViewMatricula.html.twig', [
            'servicios' => $servicios,
            'matricula'=>$matricula,
            'titulo'=>'Servicios del vehiculo '
        ]);
    }
    //BUSCA POR MATRICULA PARA CLIENTE
    #[Route('/cliente/servicio/show/{matricula}', name: 'app_show_serviciosMatricula_cliente')]
    public function showServicesPorMatriculaCliente(ServicioRepository $servicioRepository, Request $request, VehiculoRepository $vehiculoRepository): Response
    {
        $matricula = $request->query->get('matricula');
        $vehiculo= $vehiculoRepository->findOneBy(['matricula'=>$matricula]);
        /** @var \App\Entity\Usuario $user */
        $user = $this->getUser();
        $centro = $user->getCentro();

        $qb = $servicioRepository->createQueryBuilder('s')
            ->join('s.creador', 'c')
            ->join('s.vehiculo', 'v')
            ->where('v.matricula = :matricula')
            ->andWhere('s.anulado IS NULL OR s.anulado = 0')
            ->andWhere('c.centro = :centro')
            ->setParameter('centro', $centro)
            ->setParameter('matricula', $matricula);

        $servicios = $qb->getQuery()->getResult();



        return $this->render('servicio/servicioViewMatricula.html.twig', [
            'servicios' => $servicios,
            'matricula'=>$matricula,
            'titulo'=>'Servicios del vehiculo '
        ]);
    }
   

    //OBTIENE LOS SERIVIOS QUE TIENE ASIGNADOS CADA CONDUCTOR
    #[Route('/planificador/servicio/plan', name: 'app_show_plan')]
    public function showPlanByDate(ServicioRepository $servicioRepository, Request $request): Response
    {
        $fecha = $request->query->get('fecha');
        $fechaFiltro= $fecha ? \DateTime::createFromFormat('Y-m-d',$fecha):new \DateTime();
        $fechaFiltro->setTime(0, 0, 0);
        $servicios= $servicioRepository->findBy(['fecha'=>$fechaFiltro]);

        $serviciosPorConductor=[];

        foreach($servicios as $servicio){
            $conductor=$servicio->getConductor();
            if(!$conductor){
                continue;//por si no estuviera planificado
            }
            $id=$conductor->getId();
            if(!isset($serviciosPorConductor[$id])){
                $serviciosPorConductor[$id]=[
                    'conductor'=>$conductor,
                    'servicios'=>[]
                ];
            }
            $serviciosPorConductor[$id]['servicios'][]=$servicio;
        }
        return $this->render('servicio/newServicePlan.html.twig', [
            'servicios' => $serviciosPorConductor,
            'fecha'=>$fechaFiltro->format('d-m-Y')
        ]);
    }

    //Retorna los datos en json para el front del conductor
    #[Route('/conductor/servicio/conductor', name: 'app_show_servicioConductor')]
    public function showServicesDriver(ServicioRepository $servicioRepository, SerializerInterface $serializer): Response
    {
        $user=$this->getUser();
        $fechaFiltro= new \DateTime();
        $fechaFiltro->setTime(0,0,0);
        $servicios= $servicioRepository->findBy(['fecha'=>$fechaFiltro, 'conductor'=>$user]);
        $datos=[];
        foreach ($servicios as $servicio) {
            $lat=$servicio->getLatitudEntrega();
            $lng=$servicio->getLongitudEntrega();
            $enlace="https://www.google.com/maps?q={$lat},{$lng}";
            $datos[] = [
                'id' => $servicio->getId(),
                'horaRecogidaPrevista' => $servicio->getHoraRecogidaPrevista(),
                'horaEntregaReal' => $servicio->getHoraEntregaReal(),
                'horaRecogidaReal' => $servicio->getHoraRecogidaReal(),
                'direccionRecogida' => $servicio->getDireccionRecogida(),
                'ruta'=>$enlace,
                'vehiculo' => [
                    'matricula' => $servicio->getVehiculo()?->getMatricula(),
                    'marca' => $servicio->getVehiculo()?->getMarca(),
                    'modelo' => $servicio->getVehiculo()?->getModelo(),

                ],
                'receptor' => [
                    'nombre' => $servicio->getReceptor()?->getNombre(),
                    'apellido1' => $servicio->getReceptor()?->getApellido1(),
                    'apellido2' => $servicio->getReceptor()?->getApellido2(),
                    'telefono' => $servicio->getReceptor()?->getTelefono(),
                    'NIF' => $servicio->getReceptor()?->getNIF(),
                ]
            ];
        }
        return new JsonResponse([
            'servicios' => $datos,
            'fecha'=>$fechaFiltro->format('Y-m-d'),
            'titulo'=>'Tu ruta del '
        ]);
        
    }
#[Route('/cliente/servicio/show', name: 'app_show_servicio_cliente')]
public function showServicesByDateCliente(ServicioRepository $servicioRepository, Request $request): Response
{
    $fecha = $request->query->get('fecha');
    $fechaFiltro = $fecha ? \DateTime::createFromFormat('Y-m-d', $fecha) : new \DateTime();
    $fechaFiltro->setTime(0, 0, 0);

    /** @var \App\Entity\Usuario $user */
    $user = $this->getUser();
    $centro = $user->getCentro();

    $qb = $servicioRepository->createQueryBuilder('s')
        ->join('s.creador', 'c')
        ->where('s.fecha = :fecha')
        ->andWhere('s.anulado IS NULL OR s.anulado = 0')
        ->andWhere('c.centro = :centro')
        ->setParameter('fecha', $fechaFiltro)
        ->setParameter('centro', $centro);

    $servicios = $qb->getQuery()->getResult();

    return $this->render('servicio/servicioView.html.twig', [
        'servicios' => $servicios,
        'fecha' => $fechaFiltro->format('Y-m-d'),
        'titulo' => 'Servicios del '
    ]);
}
}
