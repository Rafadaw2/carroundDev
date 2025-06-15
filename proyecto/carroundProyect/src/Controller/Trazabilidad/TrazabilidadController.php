<?php

namespace App\Controller\Trazabilidad;

use EasyCorp\Bundle\EasyAdminBundle\Event\AfterEntityPersistedEvent;
use EasyCorp\Bundle\EasyAdminBundle\Event\AfterEntityUpdatedEvent;
use EasyCorp\Bundle\EasyAdminBundle\Event\AfterEntityDeletedEvent;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;
use Psr\Log\LoggerInterface;
use Symfony\Component\Security\Http\Event\LoginSuccessEvent;
use Symfony\Component\Security\Http\Event\LogoutEvent;

class TrazabilidadController 
{
    private LoggerInterface $tracabilityLogger;
    private TokenStorageInterface $tokenStorage;

    public function __construct(LoggerInterface $tracabilityLogger, TokenStorageInterface $tokenStorage)
    {
        $this->tracabilityLogger = $tracabilityLogger;
        $this->tokenStorage = $tokenStorage;
    }

    public function registroAccionPersistencia(AfterEntityPersistedEvent $event): void
    {
        $this->registroAccionAdmin($event, 'CREAR');
    }

    public function registroAccionActualizacion(AfterEntityUpdatedEvent $event): void
    {
        $this->registroAccionAdmin($event, 'ACTUALIZAR');
    }

    public function registroAccionEliminacion(AfterEntityDeletedEvent $event): void
    {
        $this->registroAccionAdmin($event, 'ELIMINAR');
    }

    private function registroAccionAdmin(object $event, string $accion): void
    {
        dump("Evento de acción detectado: {$accion}");
        $usuario = $this->getUser();
        $entity = $event->getEntityInstance();
        $fecha = date('Y-m-d H:i:s');

        if (!$usuario || !$entity) {
            return;
        }

        $this->tracabilityLogger->info("Administrador '{$usuario->getUserIdentifier()}' realizó una acción '{$accion}' en entidad " . get_class($entity) . ", Fecha: {$fecha}", [
            'usuario' => $usuario->getUserIdentifier(),
            'accion' => $accion,
            'entidad' => get_class($entity),
            'fecha' => $fecha,
        ]);
    }

    public function registroLogin(LoginSuccessEvent $event): void
    {
        $usuario = $event->getUser();
        $fecha = date('Y-m-d H:i:s');

        if (!$usuario) {
            return;
        }

        $this->tracabilityLogger->info("Inicio de sesión de {$usuario->getUserIdentifier()}, Fecha: {$fecha}", [
            'usuario' => $usuario->getUserIdentifier(),
            'fecha' => $fecha,
        ]);
    }

    public function registroLogout(LogoutEvent $event): void
    {
        $usuario = $event->getToken()?->getUser();
        $fecha = date('Y-m-d H:i:s');

        if (!$usuario) {
            return;
        }

        $this->tracabilityLogger->info("El usuario {$usuario->getUserIdentifier()} ha cerrado sesión, Fecha: {$fecha}", [
            'usuario' => $usuario->getUserIdentifier(),
            'fecha' => $fecha,
        ]);
    }

    private function getUser()
    {
        return $this->tokenStorage->getToken()?->getUser();
    }
}
