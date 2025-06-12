<?php

namespace App\Controller;

use App\Entity\Receptor;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;
use App\Form\NewClienteFormType;
use App\Entity\Cliente;

final class ClienteController extends AbstractController
{
    #[Route('/cliente/new', name: 'app_cliente')]
    public function newCliente(Request $request, EntityManagerInterface $entityManager): Response
    {
        $cliente= new Cliente();
        $form=$this->createForm(NewClienteFormType::class, $cliente);
        $form->handleRequest($request);
        if($form->isSubmitted()&& $form->isValid()){
            $entityManager->persist($cliente);
            $entityManager->flush();
            return $this->redirectToRoute('app_cliente');
        }
        return $this->render('cliente/index.html.twig', [
            'newClienteForm' => $form->createView(),
        ]);
    }
}
