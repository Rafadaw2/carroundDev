<?php

namespace App\Form;

use App\Entity\Servicio;
use App\Entity\Usuario;
use App\Entity\Vehiculo;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;

class NewServiceFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        //$creador=$this->getUser(); Por defecto colocar como creador el usuario logeado
        $builder
            ->add('direccionRecogida',null,[
                'attr' => ['class' => 'autocomplete-address', 'autocomplete' => 'off'],
            ])
            ->add('direccionEntrega', null, [
                'attr' => ['class' => 'autocomplete-address', 'autocomplete' => 'off'],
            ])
            ->add('fecha', null, [
                'widget' => 'single_text',
            ])
            ->add('horaRecogidaPrevista')
            ->add('franjaDisponibilidad')
            ->add('franjaDisponibilidad', ChoiceType::class, [
                'choices' => [
                'mañana' => 'mañana',
                'tarde' => 'tarde',
                ],
                'multiple' => false, // Permitir múltiples opciones
                'expanded' => true, ]) // Renderiza como checkboxes
            ->add('vehiculo', EntityType::class, [
                'class' => Vehiculo::class,
                'choice_label' => 'matricula',
            ])
            ->add('creador', EntityType::class, [
                'class' => Usuario::class,
                'choice_label' => 'id',
            ])

        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Servicio::class,
        ]);
    }
}
