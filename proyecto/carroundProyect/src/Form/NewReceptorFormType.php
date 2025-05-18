<?php

namespace App\Form;

use App\Entity\Receptor;
use App\Entity\Vehiculo;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class NewReceptorFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('email')
            ->add('nombre')
            ->add('apellido1')
            ->add('apellido2')
            ->add('NIF')
            ->add('telefono')
            ->add('vehiculos', EntityType::class, [
                'class' => Vehiculo::class,
                'choice_label' => 'matricula',
                'placeholder' => 'Selecciona un centro (opcional)',
                'required' => false,
                'multiple' => true,
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Receptor::class,
        ]);
    }
}
