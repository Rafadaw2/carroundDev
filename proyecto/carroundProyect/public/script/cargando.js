document.addEventListener('DOMContentLoaded',function(){
    const boton=document.getElementById('btnPlanificar');
    if(boton){
        boton.addEventListener('click',function(e){
            document.getElementById('carga').style.display='flex';
        })
    }
})

