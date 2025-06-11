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

final class ServicioController extends AbstractController
{
    #[Route('/servicio/new', name: 'app_servicio')]
    public function newService(Request $request, EntityManagerInterface $entityManager, GeocodingService $geocoding): Response
    {
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
            $entityManager->persist($servicio);
            $entityManager->flush();
            return $this->redirectToRoute('app_servicio');
        }
        return $this->render('servicio/newServicioForm.html.twig', [
            'newServiceForm' => $form->createView(),
            'google_api_key'=> $this->getParameter('google_api_key')
        ]);
    }
    #[Route('/servicio/{id}/edit', name: 'app_editServicio')]
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
    #[Route('/servicio/show', name: 'app_show_servicio')]
    public function showServicesByDate(ServicioRepository $servicioRepository, Request $request): Response
    {
        $fecha = $request->query->get('fecha');
        $fechaFiltro= $fecha ? \DateTime::createFromFormat('Y-m-d',$fecha):new \DateTime();
        $fechaFiltro->setTime(0, 0, 0);
        $servicios= $servicioRepository->findBy(['fecha'=>$fechaFiltro]);

        return $this->render('servicio/servicioView.html.twig', [
            'servicios' => $servicios,
            'fecha'=>$fechaFiltro->format('d-m-Y'),
            'titulo'=>'Servicios del '
        ]);
    }
    #[Route('/servicio/show/{matricula}', name: 'app_show_serviciosMatricula')]
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
    #[Route('/servicio/plan', name: 'app_show_plan')]
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
}
