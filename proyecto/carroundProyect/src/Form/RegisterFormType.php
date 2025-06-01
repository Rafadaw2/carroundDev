<?php

namespace App\Form;

use App\Entity\Centro;
use App\Entity\Usuario;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;

class RegisterFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        //Aqui solo puede entrar el manager
        $builder
            ->add('email')
            ->add('roles')
            ->add('password', RepeatedType::class, [
                'type' => PasswordType::class,
                'first_options' => ['label' => 'Password'],
                'second_options' => ['label' => 'Repeat Password'],
            ])
            ->add('nombre')
            ->add('apellido1')
            ->add('apellido2')
            ->add('domicilio',null,[
                'attr' => ['class' => 'autocomplete-address', 'autocomplete' => 'off'],
            ])
            ->add('centro', EntityType::class, [
                'class' => Centro::class,
                'choice_label' => 'nombre',
                'placeholder' => 'Selecciona un centro (opcional)',
                'required' => false,
            ])
            ->add('roles', ChoiceType::class, [
                'choices' => [
                'Admin' => 'ROLE_ADMIN',
                'Cliente' => 'ROLE_CLIENTE',
                'Manager' => 'ROLE_MANAGER',
                'Planificador'=>'ROLE_PLANIFICADOR',
                'Conductor'=>'ROLE_CONDUCTOR',
                ],
                'multiple' => true, // Permitir múltiples opciones
                'expanded' => true, ]) // Renderiza como checkboxes
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Usuario::class,
        ]);
    }
}
