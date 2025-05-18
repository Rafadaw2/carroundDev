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
            return $this->redirectToRoute('app_show_servicio');
        }
        return $this->render('servicio/planServiceForm.html.twig', [
            'PlanServiceForm' => $form->createView(),
        ]);
    }
    #[Route('/servicio/show/{fecha?}', name: 'app_show_servicio')]
    public function showServicesByDate(ServicioRepository $servicioRepository, ?string $fecha): Response
    {
        $fechaFiltro= $fecha ? \DateTime::createFromFormat('Y-m-d',$fecha):new \DateTime();
        $servicios= $servicioRepository->findBy(['fecha'=>$fechaFiltro]);


        return $this->render('servicio/servicioView.html.twig', [
            'servicios' => $servicios,
            'fecha'=>$fechaFiltro->format('d-m-Y')
        ]);
    }
}
