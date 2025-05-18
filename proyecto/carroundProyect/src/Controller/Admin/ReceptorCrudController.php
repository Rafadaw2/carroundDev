<?php

namespace App\Controller\Admin;

use App\Entity\Receptor;
use App\Entity\Vehiculo;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\CollectionField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;

class ReceptorCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Receptor::class;
    }

    
    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('email'),
            TextField::new('nombre'),
            TextField::new('apellido1'),
            TextField::new('apellido2')->setRequired(false),
            TextField::new('NIF'),
            IntegerField::new('telefono'),
            AssociationField::new('vehiculos')->setFormTypeOption('by_reference', false),
        ];
    }
    
}
