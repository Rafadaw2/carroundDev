<?php

namespace App\Form;

use App\Entity\Receptor;
use App\Entity\Servicio;
use App\Entity\Usuario;
use App\Entity\Vehiculo;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;

class PlanServiceFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('direccionRecogida')
            ->add('direccionEntrega')
            ->add('fecha', null, [
                'widget' => 'single_text',
            ])
            ->add('horaEntregaPrevista')
            ->add('horaRecogidaPrevista')
            ->add('horaRecogidaReal')
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
            ->add('conductor', EntityType::class, [
                'class' => Usuario::class,
                //'choice_label' => 'nombre', al suprimirlo utiliza el toString 
            ])
            ->add('receptor', EntityType::class, [
                'class' => Receptor::class,
                'choice_label' => 'NIF',
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
