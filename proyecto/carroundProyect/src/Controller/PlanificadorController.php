<?php

namespace App\Controller;

use App\Repository\ServicioRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\UsuarioRepository;
use DateTime;

final class PlanificadorController extends AbstractController
{
    #[Route('/planificador/{fecha}', name: 'app_planificador')]
    public function datosPlanficacion(UsuarioRepository $conductoresRepository, string $fecha, ServicioRepository $servicioRepository): Response
    {

        $rolBuscado='ROLE_CONDUCTOR';
        $conductores = [];
        $conductores= $conductoresRepository->createQueryBuilder('c')
            ->where('JSON_CONTAINS(c.rol, :rol)')
            ->setParameter('rol', json_encode($rolBuscado))
            ->getQuery()
            ->getResult();
        
        $fechaFiltro= $fecha ? \DateTime::createFromFormat('Y-m-d',$fecha):new \DateTime();
        $fechaFiltro->setTime(0, 0, 0);
        $servicios= $servicioRepository->findBy(['fecha'=>$fechaFiltro]);

        return $this->render('usuario/index.html.twig', [
            'conductores' => $conductores,
            'servicios'=>$servicios,
            'fecha'=>$fechaFiltro->format('d-m-Y')
        ]);
    }
}
