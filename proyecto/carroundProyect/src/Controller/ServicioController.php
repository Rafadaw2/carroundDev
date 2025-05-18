<?php

namespace App\Controller;

use App\Entity\Servicio;
use App\Form\NewServiceFormType;
use App\Form\PlanServiceFormType;
use App\Repository\ServicioRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;

final class ServicioController extends AbstractController
{
    #[Route('/servicio/new', name: 'app_servicio')]
    public function newService(Request $request, EntityManagerInterface $entityManager): Response
    {
        $servicio= new Servicio();
        $form=$this->createForm(NewServiceFormType::class, $servicio);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            $entityManager->persist($servicio);
            $entityManager->flush();
            return $this->redirectToRoute('app_servicio');
        }
        return $this->render('servicio/newServicioForm.html.twig', [
            'newServiceForm' => $form->createView(),
        ]);
    }
    #[Route('/servicio/{id}/edit', name: 'app_editServicio')]
    public function editService(Request $request, EntityManagerInterface $entityManager, Servicio $servicio): Response
    {
        $form=$this->createForm(PlanServiceFormType::class, $servicio);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            $entityManager->persist($servicio);
            $entityManager->flush();
            return $this->redirectToRoute('app_show_servicio',['fecha'=>$servicio->getFecha()->format('Y-m-d')]);
        }
        return $this->render('servicio/planServiceForm.html.twig', [
            'PlanServiceForm' => $form->createView(),
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
            'fecha'=>$fechaFiltro->format('d-m-Y')
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
