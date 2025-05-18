<?php

namespace App\Entity;

use App\Repository\ClienteRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ClienteRepository::class)]
class Cliente
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $NIF = null;

    #[ORM\Column(length: 255)]
    private ?string $razonSocial = null;

    #[ORM\Column(length: 255)]
    private ?string $direccion = null;

    /**
     * @var Collection<int, Centro>
     */
    #[ORM\OneToMany(targetEntity: Centro::class, mappedBy: 'cliente')]
    private Collection $centros;

    public function __construct()
    {
        $this->centros = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
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

    public function getRazonSocial(): ?string
    {
        return $this->razonSocial;
    }

    public function setRazonSocial(string $razonSocial): static
    {
        $this->razonSocial = $razonSocial;

        return $this;
    }

    public function getDireccion(): ?string
    {
        return $this->direccion;
    }

    public function setDireccion(string $direccion): static
    {
        $this->direccion = $direccion;

        return $this;
    }

    /**
     * @return Collection<int, Centro>
     */
    public function getCentros(): Collection
    {
        return $this->centros;
    }

    public function addCentro(Centro $centro): static
    {
        if (!$this->centros->contains($centro)) {
            $this->centros->add($centro);
            $centro->setCliente($this);
        }

        return $this;
    }

    public function removeCentro(Centro $centro): static
    {
        if ($this->centros->removeElement($centro)) {
            // set the owning side to null (unless already changed)
            if ($centro->getCliente() === $this) {
                $centro->setCliente(null);
            }
        }

        return $this;
    }
    public function __toString(): string
    {
        return $this->razonSocial;
    }
}
