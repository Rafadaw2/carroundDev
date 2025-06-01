<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\UsuarioRepository;

final class UsuarioController extends AbstractController
{
    #[Route('/usuario', name: 'app_usuario')]
    public function index(): Response
    {
        return $this->render('usuario/index.html.twig', [
            'controller_name' => 'UsuarioController',
        ]);
    }
    #[Route('/usuario/conductor', name: 'app_usuario')]
    public function conductores(UsuarioRepository $conductoresRepository): Response
    {
        $rolBuscado='ROLE_CONDUCTOR';
        $conductores = [];
        $conductores= $conductoresRepository->createQueryBuilder('c')
            ->where('JSON_CONTAINS(c.rol, :rol)')
            ->setParameter('rol', json_encode($rolBuscado))
            ->getQuery()
            ->getResult();
        
        return $this->render('usuario/index.html.twig', [
            'conductores' => $conductores,
        ]);
    }

}
