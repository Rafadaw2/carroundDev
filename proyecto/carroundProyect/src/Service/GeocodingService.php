<?php
namespace App\Service;
use Symfony\Contracts\HttpClient\HttpClientInterface;

//ATACA LA API DE GOOGLE GEOCODINGAPI PARA OBTENER COORDENADAS
class GeocodingService 
{
    private string $apiKey;
    private HttpClientInterface $client;
    public function __construct(HttpClientInterface $client,string $googleApiKey) {
        $this->client=$client;
        $this->apiKey=$googleApiKey;//Le pasamos la clave desde service.yaml
    }
    public function obtenerCoordenadas(string $direccion):?array {
        $url="https://maps.googleapis.com/maps/api/geocode/json";
        $respuesta=$this->client->request("GET",$url,[
            'query'=>[
                'address'=>$direccion,
                'key'=>$this->apiKey,
            ],
        ]);
        //Esta llamada nos devuelve la respuesta en objeto responseinterface y lo pasanos a array
        $datos=$respuesta->toArray();
        /*El array contiene información sobre la dirección*/
        if($datos['status']=='OK'){
            $coordenadas=$datos['results'][0]['geometry']['location'];
            return[
                'latitud'=>$coordenadas['lat'],
                'longitud'=>$coordenadas['lng'],
            ];
        }else{
            return null;
        }
    }
}