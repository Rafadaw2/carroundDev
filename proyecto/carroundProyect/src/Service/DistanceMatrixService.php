<?php
namespace App\Service;

use App\Entity\Servicio;
use App\Entity\Usuario;
use Symfony\Contracts\HttpClient\HttpClientInterface;

//ATACA LA API DE GOOGLE GEOCODINGAPI PARA OBTENER COORDENADAS
class DistanceMatrixService 
{
    private string $apiKey;
    private HttpClientInterface $client;
    public function __construct(HttpClientInterface $client,string $googleApiKey) {
        $this->client=$client;
        $this->apiKey=$googleApiKey;//Le pasamos la clave desde service.yaml
    }
    public function obtenerCoordenadas(Servicio $servicios, Usuario $conductores):?array {
        $conductoresArray= array_map(fn($c)=>$c->getLatitudDomicilio().','.$c->getLongitudDomicilio(),$conductores);
        $serviciosArray=array_map(fn($s)=>$s->get)





        /*$entregas=[];
        $recogidas=[];
        foreach ($servicios as $servicio) {
            $entregas[]=$servicio->getLatitudEntrega().','.$servicio->getLongitudEntrega();
            $recogidas[]=$servicio->getLatitudRecogida().','.$servicio->getLongitudRecogida();
        }
        $cadenaEntregas=implode('|',$entregas);
        $cadenaRecogidas=implode('|',$recogidas);

        $url="https://maps.googleapis.com/maps/api/distancematrix/json";
        //La api necesita que le pasen los origenes y destinos en cadena separa por |
        $respuesta=$this->client->request("GET",$url,[
            'query'=>[
                'origins'=>$cadenaRecogidas,
                'destinations'=>$cadenaEntregas,
                'mode'=>'transit',//calculo en base a trasporte publico
                'departure_time'=>strtotime('2025-06-02 08:00:00'),//Para que haga el calculo tomando las 8am
                'key'=> $this->apiKey
            ],
        ]);
        //Esta llamada nos devuelve la respuesta en objeto responseinterface y lo pasanos a array
        $datos=$respuesta->toArray();*/
        /*El array contiene información sobre la dirección*/
        /*$matrizDistancias=[];
        if($datos['status']=='OK'){

            foreach($datos['rows'] as $i => $row){
                foreach($row['elements'] as $j=>$element){
                    $matrizDistancias[$i][$j]=$element['duration']['value'];

                }
            }
            return $matrizDistancias;
        }else{
            return null;
        }*/
    }
}