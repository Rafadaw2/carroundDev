<?php

namespace App\Entity;

use App\Repository\ReceptorRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ReceptorRepository::class)]
class Receptor
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $email = null;

    #[ORM\Column(length: 255)]
    private ?string $nombre = null;

    #[ORM\Column(length: 255)]
    private ?string $apellido1 = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $apellido2 = null;

    #[ORM\Column(length: 255)]
    private ?string $NIF = null;

    #[ORM\Column]
    private ?int $telefono = null;

    /**
     * @var Collection<int, Vehiculo>
     */
    #[ORM\ManyToMany(targetEntity: Vehiculo::class, mappedBy: 'receptor')]
    private Collection $vehiculos;

    /**
     * @var Collection<int, Servicio>
     */
    #[ORM\OneToMany(targetEntity: Servicio::class, mappedBy: 'receptor')]
    private Collection $servicios;

    public function __construct()
    {
        $this->vehiculos = new ArrayCollection();
        $this->servicios = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): static
    {
        $this->email = $email;

        return $this;
    }

    public function getNombre(): ?string
    {
        return $this->nombre;
    }

    public function setNombre(string $nombre): static
    {
        $this->nombre = $nombre;

        return $this;
    }

    public function getApellido1(): ?string
    {
        return $this->apellido1;
    }

    public function setApellido1(string $apellido1): static
    {
        $this->apellido1 = $apellido1;

        return $this;
    }

    public function getApellido2(): ?string
    {
        return $this->apellido2;
    }

    public function setApellido2(?string $apellido2): static
    {
        $this->apellido2 = $apellido2;

        return $this;
    }

    public function getNIF(): ?string
    {
        return $this->NIF;
    }

    public function setNIF(string $NIF): static
    {
        $this->NIF = $NIF;

        return $this;
    }

    public function getTelefono(): ?int
    {
        return $this->telefono;
    }

    public function setTelefono(int $telefono): static
    {
        $this->telefono = $telefono;

        return $this;
    }

    /**
     * @return Collection<int, Vehiculo>
     */
    public function getVehiculos(): Collection
    {
        return $this->vehiculos;
    }

    public function addVehiculo(Vehiculo $vehiculo): static
    {
        if (!$this->vehiculos->contains($vehiculo)) {
            $this->vehiculos->add($vehiculo);
            $vehiculo->addReceptor($this);
        }

        return $this;
    }

    public function removeVehiculo(Vehiculo $vehiculo): static
    {
        if ($this->vehiculos->removeElement($vehiculo)) {
            $vehiculo->removeReceptor($this);
        }

        return $this;
    }
    public function __toString(): string
    {
        return $this->nombre;
    }

    /**
     * @return Collection<int, Servicio>
     */
    public function getServicios(): Collection
    {
        return $this->servicios;
    }

    public function addServicio(Servicio $servicio): static
    {
        if (!$this->servicios->contains($servicio)) {
            $this->servicios->add($servicio);
            $servicio->setReceptor($this);
        }

        return $this;
    }

    public function removeServicio(Servicio $servicio): static
    {
        if ($this->servicios->removeElement($servicio)) {
            // set the owning side to null (unless already changed)
            if ($servicio->getReceptor() === $this) {
                $servicio->setReceptor(null);
            }
        }

        return $this;
    }
}
