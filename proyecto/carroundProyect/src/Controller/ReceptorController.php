<?php

namespace App\Controller;

use App\Entity\Receptor;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Form\NewReceptorFormType;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;

final class ReceptorController extends AbstractController
{
    #[Route('/receptor/new', name: 'app_receptor')]
    public function newReceptor(Request $request, EntityManagerInterface $entityManager): Response
    {
        $receptor= new Receptor();
        $form=$this->createForm(NewReceptorFormType::class, $receptor);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            $entityManager->persist($receptor);
            $entityManager->flush();
            return $this->redirectToRoute('app_receptor');
        }
        return $this->render('receptor/index.html.twig', [
            'newReceptorForm' => $form->createView(),
        ]);
    }
}
