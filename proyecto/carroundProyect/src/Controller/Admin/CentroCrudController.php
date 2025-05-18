<?php

namespace App\Controller\Admin;

use App\Entity\Centro;
use App\Entity\Usuario;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\CollectionField;

class CentroCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Centro::class;
    }

    
    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('nombre'),
            TextField::new('direccion'),
            IntegerField::new('telefono'),
            CollectionField::new('trabajadores', 'Trabajadores'),
            AssociationField::new('cliente','Cliente') ->setRequired(false),

        ];
    }
    
}
