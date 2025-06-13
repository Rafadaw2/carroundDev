<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use App\Form\RegisterFormType;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Usuario;
use App\Service\GeocodingService;

final class RegistrationController extends AbstractController
{
    #[Route('/manager/registro', name: 'app_registration')]
    public function register(
        Request $request,
        UserPasswordHasherInterface $passwordHasher,
        EntityManagerInterface $entityManager,
        GeocodingService $geocoding
    ): Response
    {
        $user = new Usuario();
        $form = $this->createForm(RegisterFormType::class, $user);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            // Hash the plain password
            $direccionDomicilio=$user->getDomicilio();
            
            $coordenadasDomicilio=$geocoding->obtenerCoordenadas($direccionDomicilio);
            $user->setLatitudDomicilio($coordenadasDomicilio['latitud']);
            $user->setLongitudDomicilio($coordenadasDomicilio['longitud']);
            $user->setPassword(
                $passwordHasher->hashPassword(
                    $user,
                    $form->get('password')->getData()
                )
            );
            
            $user->setRoles($form->get('roles')->getData());
            $entityManager->persist($user);
            $entityManager->flush();
            return $this->redirectToRoute('app_registration');
        }
        return $this->render('registration/index.html.twig', [
            'registrationForm' => $form->createView(),
            'google_api_key'=> $this->getParameter('google_api_key')
        ]);
    }
}
