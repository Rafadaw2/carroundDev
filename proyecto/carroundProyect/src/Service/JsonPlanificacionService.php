<?php

namespace App\Service;

use App\Entity\Servicio;
use App\Entity\Usuario;
use DateTime;
use Symfony\Component\Filesystem\Filesystem;
use function PHPUnit\Framework\fileExists;

//Permite perparar los datos a planficar en un JSON para surtir el script
class JsonPlanificacionService
{

    public function obtenerJsonPlanificacion(array $servicios, array $conductores): ?array
    {
        $archivoPlanficacion = new Filesystem();

        $ruta = __DIR__ . '/../../planificacion';

        if (!fileExists($ruta)) {
            $archivoPlanficacion->mkdir($ruta);
        }

        $fechaHora = (new \DateTime())->format('Y-m-d_Hi');
        $nombre = "planficacion_$fechaHora.json";
        $destino = $ruta . '/' . $nombre;

       /* $arrayCondcutores = array_values(array_map(function (Usuario $c) {
            return [
                'latitud' => $c->getLatitudDomicilio(),
                'longitud' => $c->getLongitudDomicilio(),
            ];
        }, $conductores));*/
        // En JsonPlanificacionService
        $arrayCondcutores = array_values(array_map(function (Usuario $c) {
            return [
                'latitud' => $c->getLatitudDomicilio(),
                'longitud' => $c->getLongitudDomicilio(),
            ];
        }, array_filter($conductores, function (Usuario $c) {
            return $c->getLatitudDomicilio() !== null && $c->getLongitudDomicilio() !== null;
        })));
        


        $arrayServicios = array_map(function (Servicio $s) {
            return [
                'id' => $s->getId(),
                'recogida' => [
                    'latitud' => $s->getLatitudRecogida(),
                    'longitud' => $s->getLongitudRecogida(),
                ],
                'entrega' => [
                    'latitud' => $s->getLatitudEntrega(),
                    'longitud' => $s->getLongitudEntrega(),
                ]
            ];
        }, $servicios);

        $json = json_encode([
            'conductores' => $arrayCondcutores,
            'servicios' => $arrayServicios
        ], JSON_PRETTY_PRINT); //Para que sea más legible

        $archivoPlanficacion->dumpFile($destino, $json); //Lo guardamos en su destino

        return [
            'json' => $json,
            'archivo' => $nombre,
            'conductores' => $conductores,
            'servicios' => $servicios,
            'ruta' => $destino
        ];
    }
}
