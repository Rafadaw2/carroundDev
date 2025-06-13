<?php

namespace App\Entity;

use App\Repository\ServicioRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ServicioRepository::class)]
class Servicio
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $direccionRecogida = null;

    #[ORM\Column(length: 255)]
    private ?string $direccionEntrega = null;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    private ?\DateTimeInterface $fecha = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $horaEntregaPrevista = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $horaEntregaReal = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $horaRecogidaPrevista = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $horaRecogidaReal = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $franjaDisponibilidad = null;


    #[ORM\Column(nullable: true)]
    private ?int $kmInicial = null;

    #[ORM\Column(nullable: true)]
    private ?int $kmFinal = null;

    #[ORM\ManyToOne(inversedBy: 'servicios')]
    private ?Vehiculo $vehiculo = null;

    #[ORM\ManyToOne(inversedBy: 'serviciosCreados')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Usuario $creador = null;

    #[ORM\ManyToOne(inversedBy: 'conductor')]
    private ?Usuario $conductor = null;

    #[ORM\ManyToOne(inversedBy: 'servicios')]
    private ?Receptor $receptor = null;

    #[ORM\Column(nullable: true)]
    private ?float $latitudRecogida = null;

    #[ORM\Column(nullable: true)]
    private ?float $longitudRecogida = null;

    #[ORM\Column(nullable: true)]
    private ?float $latitudEntrega = null;

    #[ORM\Column(nullable: true)]
    private ?float $longitudEntrega = null;

    #[ORM\Column(nullable: true)]
    private ?int $anulado = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDireccionRecogida(): ?string
    {
        return $this->direccionRecogida;
    }

    public function setDireccionRecogida(string $direccionRecogida): static
    {
        $this->direccionRecogida = $direccionRecogida;

        return $this;
    }

    public function getDireccionEntrega(): ?string
    {
        return $this->direccionEntrega;
    }

    public function setDireccionEntrega(string $direccionEntrega): static
    {
        $this->direccionEntrega = $direccionEntrega;

        return $this;
    }

    public function getFecha(): ?\DateTimeInterface
    {
        return $this->fecha;
    }

    public function setFecha(\DateTimeInterface $fecha): static
    {
        $this->fecha = $fecha;

        return $this;
    }

    public function getHoraEntregaPrevista(): ?string
    {
        return $this->horaEntregaPrevista;
    }

    public function setHoraEntregaPrevista(?string $horaEntregaPrevista): static
    {
        $this->horaEntregaPrevista = $horaEntregaPrevista;

        return $this;
    }

    public function getHoraEntregaReal(): ?string
    {
        return $this->horaEntregaReal;
    }

    public function setHoraEntregaReal(?string $horaEntregaReal): static
    {
        $this->horaEntregaReal = $horaEntregaReal;

        return $this;
    }

    public function getHoraRecogidaPrevista(): ?string
    {
        return $this->horaRecogidaPrevista;
    }

    public function setHoraRecogidaPrevista(?string $horaRecogidaPrevista): static
    {
        $this->horaRecogidaPrevista = $horaRecogidaPrevista;

        return $this;
    }

    public function getHoraRecogidaReal(): ?string
    {
        return $this->horaRecogidaReal;
    }

    public function setHoraRecogidaReal(?string $horaRecogidaReal): static
    {
        $this->horaRecogidaReal = $horaRecogidaReal;

        return $this;
    }

    public function getFranjaDisponibilidad(): ?string
    {
        return $this->franjaDisponibilidad;
    }

    public function setFranjaDisponibilidad(?string $franjaDisponibilidad): static
    {
        $this->franjaDisponibilidad = $franjaDisponibilidad;

        return $this;
    }

    public function getKmInicial(): ?int
    {
        return $this->kmInicial;
    }

    public function setKmInicial(?int $kmInicial): static
    {
        $this->kmInicial = $kmInicial;

        return $this;
    }

    public function getKmFinal(): ?int
    {
        return $this->kmFinal;
    }

    public function setKmFinal(?int $kmFinal): static
    {
        $this->kmFinal = $kmFinal;

        return $this;
    }

    public function getVehiculo(): ?Vehiculo
    {
        return $this->vehiculo;
    }

    public function setVehiculo(?Vehiculo $vehiculo): static
    {
        $this->vehiculo = $vehiculo;

        return $this;
    }

    public function getCreador(): ?Usuario
    {
        return $this->creador;
    }

    public function setCreador(?Usuario $creador): static
    {
        $this->creador = $creador;

        return $this;
    }

    public function getConductor(): ?Usuario
    {
        return $this->conductor;
    }

    public function setConductor(?Usuario $conductor): static
    {
        $this->conductor = $conductor;

        return $this;
    }
    public function __toString(): string
    {
        return $this->id;
    }

    public function getReceptor(): ?Receptor
    {
        return $this->receptor;
    }

    public function setReceptor(?Receptor $receptor): static
    {
        $this->receptor = $receptor;

        return $this;
    }

    public function getLatitudRecogida(): ?float
    {
        return $this->latitudRecogida;
    }

    public function setLatitudRecogida(?float $latitud): static
    {
        $this->latitudRecogida = $latitud;

        return $this;
    }

    public function getLongitudRecogida(): ?float
    {
        return $this->longitudRecogida;
    }

    public function setLongitudRecogida(?float $longitud): static
    {
        $this->longitudRecogida = $longitud;

        return $this;
    }

    public function getLatitudEntrega(): ?float
    {
        return $this->latitudEntrega;
    }

    public function setLatitudEntrega(?float $latitudEntrega): static
    {
        $this->latitudEntrega = $latitudEntrega;

        return $this;
    }

    public function getLongitudEntrega(): ?float
    {
        return $this->longitudEntrega;
    }

    public function setLongitudEntrega(?float $longitudEntrega): static
    {
        $this->longitudEntrega = $longitudEntrega;

        return $this;
    }

    public function getAnulado(): ?int
    {
        return $this->anulado;
    }

    public function setAnulado(?int $anulado): static
    {
        $this->anulado = $anulado;

        return $this;
    }
}
