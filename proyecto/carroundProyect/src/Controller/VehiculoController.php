<?php

namespace App\Controller;

use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Form\NewVehiculoFormType;
use App\Entity\Vehiculo;

final class VehiculoController extends AbstractController
{
    #[Route('/vehiculo/new', name: 'app_vehiculo')]
    public function newVehiculo(Request $request, EntityManagerInterface $entityManager): Response
    {
        $vehiculo= new Vehiculo();
        $form=$this->createForm(NewVehiculoFormType::class, $vehiculo);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            $entityManager->persist($vehiculo);
            $entityManager->flush();
            return $this->redirectToRoute('app_vehiculo');
        }
        return $this->render('vehiculo/index.html.twig', [
            'newVehiculoForm' => $form->createView(),
        ]);
    }
}
