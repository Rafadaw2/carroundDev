<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\UsuarioRepository;

final class UsuarioController extends AbstractController
{

    #[Route('/manager/usuario/conductor', name: 'app_usuario')]
    public function conductores(UsuarioRepository $conductoresRepository): Response
    {
            $conductores = $conductoresRepository->createQueryBuilder('u')
                ->where('u.roles LIKE :rol')
                ->setParameter('rol', '%"ROLE_CONDUCTOR"%')
                ->getQuery()
                ->getResult();


        
        return $this->render('usuario/index.html.twig', [
            'conductores' => $conductores,
            'titulo'=>'Conductores disponibles'
        ]);
    }

}
