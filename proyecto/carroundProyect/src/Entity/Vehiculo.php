<?php

namespace App\Entity;

use App\Repository\VehiculoRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: VehiculoRepository::class)]
class Vehiculo
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $marca = null;

    #[ORM\Column(length: 255)]
    private ?string $modelo = null;

    #[ORM\Column(length: 255)]
    private ?string $matricula = null;

    /**
     * @var Collection<int, Receptor>
     */
    #[ORM\ManyToMany(targetEntity: Receptor::class, inversedBy: 'vehiculos')]
    private Collection $receptor;

    /**
     * @var Collection<int, Servicio>
     */
    #[ORM\OneToMany(targetEntity: Servicio::class, mappedBy: 'vehiculo')]
    private Collection $servicios;

    public function __construct()
    {
        $this->receptor = new ArrayCollection();
        $this->servicios = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getMarca(): ?string
    {
        return $this->marca;
    }

    public function setMarca(string $marca): static
    {
        $this->marca = $marca;

        return $this;
    }

    public function getModelo(): ?string
    {
        return $this->modelo;
    }

    public function setModelo(string $modelo): static
    {
        $this->modelo = $modelo;

        return $this;
    }

    public function getMatricula(): ?string
    {
        return $this->matricula;
    }

    public function setMatricula(string $matricula): static
    {
        $this->matricula = $matricula;

        return $this;
    }

    /**
     * @return Collection<int, Receptor>
     */
    public function getReceptor(): Collection
    {
        return $this->receptor;
    }

    public function addReceptor(Receptor $receptor): static
    {
        if (!$this->receptor->contains($receptor)) {
            $this->receptor->add($receptor);
        }

        return $this;
    }

    public function removeReceptor(Receptor $receptor): static
    {
        $this->receptor->removeElement($receptor);

        return $this;
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
            $servicio->setVehiculo($this);
        }

        return $this;
    }

    public function removeServicio(Servicio $servicio): static
    {
        if ($this->servicios->removeElement($servicio)) {
            // set the owning side to null (unless already changed)
            if ($servicio->getVehiculo() === $this) {
                $servicio->setVehiculo(null);
            }
        }

        return $this;
    }
    public function __toString(): string
    {
        return $this->matricula;
    }
}
