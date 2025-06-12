const contenedor=document.getElementById('contenido')
let btnInicio=document.createElement('button')
btnInicio.className='btn btn-caround'
btnInicio.innerText='Iniciar Jornada'
btnInicio.addEventListener('click',()=>obtenerServicios)
contenedor.append(btnInicio)
let servicios=[]
function obtenerServicios(){
    fetch(`http://127.0.0.1/servicio/conductor`)
  .then(response => response.json())
  .then(data => servicios.pop(data) )
  .catch(error => console.error('Error:', error));
}

function imprimirServicios(){

    contenedor.innerHTML=""
    for (let servicio of servicios) {

    }

}
function inciarServicio( id_servicio, kmInicial){
    
fetch('http://127.0.0.1/servicio/'+id_servicio, {
  method: 'PUT',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    kmInicial: kmInicial,
  })
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
}