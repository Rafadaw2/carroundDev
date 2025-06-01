<?php

namespace App\Entity;

use App\Repository\UsuarioRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity(repositoryClass: UsuarioRepository::class)]
#[ORM\UniqueConstraint(name: 'UNIQ_IDENTIFIER_EMAIL', fields: ['email'])]
class Usuario implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 180)]
    private ?string $email = null;

    /**
     * @var list<string> The user roles
     */
    #[ORM\Column]
    private array $roles = [];

    /**
     * @var string The hashed password
     */
    #[ORM\Column]
    private ?string $password = null;

    #[ORM\Column(length: 255)]
    private ?string $nombre = null;

    #[ORM\Column(length: 255)]
    private ?string $apellido1 = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $apellido2 = null;

    /**
     * @var Collection<int, Servicio>
     */
    #[ORM\OneToMany(targetEntity: Servicio::class, mappedBy: 'creador')]
    private Collection $serviciosCreados;

    /**
     * @var Collection<int, Servicio>
     */
    #[ORM\OneToMany(targetEntity: Servicio::class, mappedBy: 'conductor')]
    private Collection $serviciosRealizados;

    #[ORM\ManyToOne(inversedBy: 'trabajadores')]
    private ?Centro $centro = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $domicilio = null;

    #[ORM\Column(nullable: true)]
    private ?float $latitudDomicilio = null;

    #[ORM\Column(nullable: true)]
    private ?float $longitudDomicilio = null;



    public function __construct()
    {
        $this->serviciosCreados = new ArrayCollection();
        $this->serviciosRealizados = new ArrayCollection();
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

    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function getUserIdentifier(): string
    {
        return (string) $this->email;
    }

    /**
     * @see UserInterface
     *
     * @return list<string>
     */
    public function getRoles(): array
    {
        $roles = $this->roles;
        // guarantee every user at least has ROLE_USER

        return array_unique($roles);
    }

    /**
     * @param list<string> $roles
     */
    public function setRoles(array $roles): static
    {
        $this->roles = $roles;

        return $this;
    }

    /**
     * @see PasswordAuthenticatedUserInterface
     */
    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(string $password): static
    {
        $this->password = $password;

        return $this;
    }

    /**
     * @see UserInterface
     */
    public function eraseCredentials(): void
    {
        // If you store any temporary, sensitive data on the user, clear it here
        // $this->plainPassword = null;
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

    /**
     * @return Collection<int, Servicio>
     */
    public function getServiciosCreados(): Collection
    {
        return $this->serviciosCreados;
    }

    public function addServiciosCreado(Servicio $serviciosCreado): static
    {
        if (!$this->serviciosCreados->contains($serviciosCreado)) {
            $this->serviciosCreados->add($serviciosCreado);
            $serviciosCreado->setCreador($this);
        }

        return $this;
    }

    public function removeServiciosCreado(Servicio $serviciosCreado): static
    {
        if ($this->serviciosCreados->removeElement($serviciosCreado)) {
            // set the owning side to null (unless already changed)
            if ($serviciosCreado->getCreador() === $this) {
                $serviciosCreado->setCreador(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Servicio>
     */
    public function getServiciosRealizados(): Collection
    {
        return $this->serviciosRealizados;
    }

    public function addServicioRealizado(Servicio $servicio): static
    {
        if (!$this->serviciosRealizados->contains($servicio)) {
            $this->serviciosRealizados->add($servicio);
            $servicio->setConductor($this);
        }

        return $this;
    }

    public function removeServicioRealizado(Servicio $servicio): static
    {
        if ($this->serviciosRealizados->removeElement($servicio)) {
            // set the owning side to null (unless already changed)
            if ($servicio->getConductor() === $this) {
                $servicio->setConductor(null);
            }
        }

        return $this;
    }

    public function getCentro(): ?Centro
    {
        return $this->centro;
    }

    public function setCentro(?Centro $centro): static
    {
        $this->centro = $centro;

        return $this;
    }
    public function __toString(): string
    {
        return $this->nombre.' '.$this->apellido1.' '.$this->apellido2;;
    }

    public function getDomicilio(): ?string
    {
        return $this->domicilio;
    }

    public function setDomicilio(?string $domicilio): static
    {
        $this->domicilio = $domicilio;

        return $this;
    }

    public function getLatitudDomicilio(): ?float
    {
        return $this->latitudDomicilio;
    }

    public function setLatitudDomicilio(?float $latitudDomicilio): static
    {
        $this->latitudDomicilio = $latitudDomicilio;

        return $this;
    }

    public function getLongitudDomicilio(): ?float
    {
        return $this->longitudDomicilio;
    }

    public function setLongitudDomicilio(?float $longitudDomicilio): static
    {
        $this->longitudDomicilio = $longitudDomicilio;

        return $this;
    }


}
