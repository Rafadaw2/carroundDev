const contenedor=document.getElementById('contenido')
if(!localStorage.getItem('jornadaIniciada')){


let divCentrado=document.createElement('div')
divCentrado.className='d-flex justify-content-center my-3'
let btnInicio=document.createElement('button')
btnInicio.className='btn btn-caround'
btnInicio.innerText='Iniciar Jornada'
btnInicio.addEventListener('click',obtenerServicios)
divCentrado.append(btnInicio)
contenedor.append(divCentrado)
btnInicio.addEventListener('click',()=>{
  localStorage.setItem('jornadaIniciada',1)
})
}else{
  obtenerServicios()
}
let servicios=[]
function obtenerServicios(){
    fetch(`http://localhost:8000/conductor/servicio/conductor`)
  .then(response => response.json())
  .then(data => {
    servicios=data.servicios
    console.log(servicios)
    imprimirServicios(servicios)
})
  .catch(error => console.error('Error:', error));
}
let disabled=""
let completado=""
function imprimirServicios(servicios){

    
    let acordeonDiv=document.createElement('div')
    acordeonDiv.className='accordion'
    acordeonDiv.id='accordionServicios'

    servicios.forEach((servicio, indice) => {
        const desplegableId=`collapse${indice}`
        const cabeceraId=`heading${indice}`
        const inputId = `kmInicial_${servicio.id}`;
        const elemento= document.createElement('div')
        elemento.className='accordion-item'

        if(servicio.horaEntregaReal!=null && servicio.horaRecogidaReal!=null){
          disabled="disabled"
          completado=`<div class="alert alert-success m-2" role="alert">
                        Servicio completado
                      </div>
                      `
        }


        elemento.innerHTML = `
            <h2 class="accordion-header" id="${cabeceraId}">
                <button class="accordion-button ${indice !== 0 ? 'collapsed' : ''}" type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#${desplegableId}"
                        aria-expanded="${indice === 0 ? 'true' : 'false'}"
                        aria-controls="${desplegableId}">
                    ${servicio.horaRecogidaPrevista} - ${servicio.direccionRecogida}
                </button>
            </h2>
            <div id="${desplegableId}" class="accordion-collapse collapse ${indice === 0 ? 'show' : ''}"
                 aria-labelledby="${cabeceraId}" data-bs-parent="#accordionServicios">
                <div class="accordion-body">
                    <strong>Matrícula:</strong> ${servicio.vehiculo.matricula}<br>
                    <strong>Receptor:</strong> ${servicio.receptor.nombre}
                    <div class="mb-3">
                        <label for="${inputId}" class="form-label">KM Iniciales:</label>
                        <input type="number" class="form-control" id="${inputId}" placeholder="Introduce los kilómetros">
                    </div>
                    <div class="d-flex justify-content-center gap-2 mt-2">
                    <button id="iniciarServicio${servicio.id}" class="btn btn-caround" onclick="iniciarServicio(${servicio.id}, document.getElementById('${inputId}').value)" ${disabled}>Iniciar</button>     
                    <button id="finalizarServicio${servicio.id}" class="btn btn-caround" onclick="finalizarServicio(${servicio.id}, document.getElementById('${inputId}').value)" disabled>Finalizar</button>
                    <a href="${servicio.ruta}">📍</a>
                    </div>
                    ${completado}     
                </div>
            </div>
        `;

        acordeonDiv.appendChild(elemento);
    });
    contenedor.innerHTML=""
    contenedor.append(acordeonDiv)
    let btnFinalizarJornada=document.createElement('button')
    btnFinalizarJornada.className='btn btn-caround'
    btnFinalizarJornada.innerText="Finalizar jornada"
    btnFinalizarJornada.addEventListener('click',()=>{
      localStorage.removeItem('jornadaIniciada')
      contenedor.innerHTML=""
      despedida=`<div class="alert alert-success m-2" role="alert">
                        ¡Hasta mañana!
                      </div>
                      `
      contenedor.innerHTML=despedida
    })
    let divBtnFin=document.createElement('div')
    divBtnFin.className='d-flex justify-content-center gap-2 mt-2'
    divBtnFin.append(btnFinalizarJornada)
    contenedor.append(divBtnFin)



}
function iniciarServicio( id_servicio, kmInicial){

  btnIniciarServicio=document.getElementById(`iniciarServicio${id_servicio}`)
  btnFinalizarServicio=document.getElementById(`finalizarServicio${id_servicio}`)
  if(btnIniciarServicio){
    btnIniciarServicio.disabled=true;
    btnFinalizarServicio.disabled=false;
  }
    
fetch('http://localhost:8000/conductor/servicio/iniciar/'+id_servicio, {
  method: 'PUT',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    kmInicial: kmInicial,
  })
})
  .then(response => response.json())
  .then(data => {
    console.log(data)
    alert("Servicio iniciado")

    const label = document.querySelector(`label[for="kmInicial_${id_servicio}"]`);
    if (label) {
      label.textContent = 'KM Finales:';
    }
    const btnFinalizar = document.getElementById(`finalizarServicio${id_servicio}`);
    if (btnFinalizar) {
        btnFinalizar.style.display = 'inline-block';
    }
})
  .catch(error => console.error('Error:', error));


}
function finalizarServicio( id_servicio, kmFinal){

  btnFinalizarServicio=document.getElementById(`finalizarServicio${id_servicio}`)
  if(btnFinalizarServicio){
    btnFinalizarServicio.disabled=true;
    completado=`<div class="alert alert-success" role="alert">
                  A simple success alert—check it out!
                </div>
                `
  }
    
fetch('http://localhost:8000/conductor/servicio/finalizar/'+id_servicio, {
  method: 'PUT',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    kmFinal: kmFinal,
  })
})
  .then(response => response.json())
  .then(data => {
    console.log(data)
    alert("Servicio finalizado")

    /*const label = document.querySelector(`label[for="kmInicial_${id_servicio}"]`);
    if (label) {
      label.textContent = 'KM Finales:';
    }
    const btnFinalizar = document.getElementById(`finalizarServicio${id_servicio}`);
    if (btnFinalizar) {
        btnFinalizar.style.display = 'inline-block';
    }*/
})
  .catch(error => console.error('Error:', error));


}