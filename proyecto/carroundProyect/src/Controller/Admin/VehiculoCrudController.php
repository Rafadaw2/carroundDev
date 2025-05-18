<?php

namespace App\Controller\Admin;

use App\Entity\Vehiculo;
use App\Entity\Receptor;
use App\Entity\Servicio;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\CollectionField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;

class VehiculoCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Vehiculo::class;
    }

    
    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('marca'),
            TextField::new('modelo'),
            TextField::new('matricula'),
            //CollectionField::new('receptor', 'Receptor')->useEntryCrudForm(ReceptorCrudController::class),
            //CollectionField::new('servicios', 'Servicios')->useEntryCrudForm(ServicioCrudController::class),
            AssociationField::new('servicios')->setFormTypeOption('by_reference', false),
            AssociationField::new('receptor')->setFormTypeOption('by_reference', false),
        ];
    }
    
}
