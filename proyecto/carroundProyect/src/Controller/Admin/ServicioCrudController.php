<?php

namespace App\Controller\Admin;

use App\Entity\Servicio;
use App\Entity\Vehiculo;
use App\Entity\Usuario;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;

class ServicioCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Servicio::class;
    }

    
    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('direccionRecogida'),
            TextField::new('direccionEntrega'),
            DateField::new('fecha'),
            TextField::new('horaEntregaPrevista'),
            TextField::new('horaEntregaReal'),
            TextField::new('horaRecogidaPrevista'),
            TextField::new('horaRecogidaReal'),
            TextField::new('franjaDisponibilidad'),
            IntegerField::new('kmInicial'),
            IntegerField::new('kmFinal'),
            AssociationField::new('vehiculo','Vehiculo'),
            AssociationField::new('creador','Creador'),
        ];
    }
    
}
