<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class EstadisticasController extends AbstractController
{
    #[Route('/manager/estadisticas', name: 'app_estadisticas')]
    public function index(): Response
    {
        return $this->render('estadisticas/index.html.twig', [
            'controller_name' => 'EstadisticasController',
        ]);
    }
}
