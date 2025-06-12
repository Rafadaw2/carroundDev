<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Doctrine\ORM\EntityManagerInterface;
use App\Form\NewCentroFormType;
use App\Entity\Centro;


final class CentroController extends AbstractController
{
    #[Route('/centro/new', name: 'app_centro')]
    public function newCentro(Request $request, EntityManagerInterface $entityManager): Response
    {
        $centro= new Centro();
        $form=$this->createForm(NewCentroFormType::class, $centro);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            $entityManager->persist($centro);
            $entityManager->flush();
            return $this->redirectToRoute('app_centro');
        }
        return $this->render('centro/index.html.twig', [
            'newCentroForm' => $form->createView(),
        ]);
    }
}
