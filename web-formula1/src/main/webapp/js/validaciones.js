/*window.onload = function () {
    validateDateEvent();
};*/

function validarNoticias() {
    var titulo_noticia = document.getElementById('titulo_noticia').value;
    var noticia = document.getElementById('noticia').value;

    if (titulo_noticia === "" || titulo_noticia === null) {
        alert("Ingrese el título de la noticia");
        return false;
    } else {
        if (titulo_noticia.length > 100) {
            alert("El título de la noticia debe contener menos de 100 caracteres");
            return false;
        }
    }
    if (noticia === "" || noticia === null) {
        alert("Ingrese la noticia");
        return false;
    } else {
        if (noticia.length < 500 || noticia.length > 2000) {
            alert("El contenido de la noticia debe estar entre 500 y 2000 caracteres");
            return false;
        }
    }
}

function validarFechaVacia(){
    if(fecha === ""){
        alert("Debe seleccionar una fecha para crear el evento en el calendario");
        return false;
    }
    /*else{
       if(){
            alert("La fecha seleccionada no puede ser inferior a la fecha de HOY");
            return false;
       } 
    }*/
}


function addDate() {
    date = new Date();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var year = date.getFullYear();
    var fecha = document.getElementById('date').value;
    if (fecha === "") {
        document.getElementById('date').value = day + '/' + month + '/' + year;
    }
}

function validateDateEvent() {
    var dateInput = document.getElementById('date');
    if(dateInput === ""){
        
    }
    var str = new Date().toISOString();
    str = str.substring(0, str.length - 1);
    dateInput.setAttribute('min', str);
}

function getDate() {

    /*    var today = new Date();
     var dd = today.getDate();
     var mm = today.getMonth() + 1; //January is 0!
     var yyyy = today.getFullYear();
     
     if (dd < 10) {
     dd = '0' + dd;
     }
     
     if (mm < 10) {
     mm = '0' + mm;
     }
     
     today = dd + '/' + mm + '/' + yyyy;
     document.getElementById("date").value = today;*/
    const timeElapsed = Date.now();
    const today = new Date(timeElapsed);
    var dateControl = document.querySelector('input[type="datetime-local"]');

    dateControl.value = '2017-06-01T08:30';
    //today.toISOString()

}


function addDate2() {
    $('#date').val(new Date().toJSON().slice(0, 10));
}

function validarFormularioCrearCuenta() {
    var name = document.getElementById('name').value;
    var user = document.getElementById('user').value;
    var email = document.getElementById('email').value;
    var contrsenha = document.getElementById('password').value;

    if (name === "" || name === null) {
        alert("Ingrese el nombre completo");
        return false;
    }
    if (user === "" || user === null) {
        alert("Ingrese el nombre de usuario");
        return false;
    }
    if (email === "" || email === null) {
        alert("Ingrese el correo electrónico");
        return false;
    }
    if (contrsenha === "" || contrsenha === null) {
        alert("Ingrese la contraseña");
        return false;
    } else {
        if (contrsenha.length < 5) {
            alert("La contraseña debe tener mínimo 5 caracteres");
            return false;
        }
    }
}

function validarImagen(obj) {
    var uploadFile = obj.files[0];

    if (!window.FileReader) {
        alert("El navegador no soporta la lectura de archivos");
        return false;
    }
    
    if (!(/\.(jpg|jpeg|png|gif)$/i).test(uploadFile.name)) {
        alert("El archivo a seleccionado no es una imagen");
        document.getElementById('imagen_noticia').value = null;
    } else {
        var img = new Image();
        img.onload = function () {
            if (uploadFile.size > 3145728)
            {
                alert("El peso de la imagen no puede exceder los 3MB");
            }
        };
        img.src = URL.createObjectURL(uploadFile);
    }
}

/*
 const btnEnviar = document.getElementById('btn-enviar');
 
 const validación = (e) => {
 e.preventDefault();
 const nombreDeUsuario = document.getElementById('usuario');
 const direcciónEmail = document.getElementById('email');
 if (usuario.value === "") {
 alert("Por favor, escribe tu nombre de usuario.");
 usuario.focus();
 return false;
 }
 if (email.value === "") {
 alert("Por favor, escribe tu correo electrónico");
 email.focus();
 return false;
 }
 
 return true;
 }
 
 submitBtn.addEventListener('click', validate);*/

function validarCircuitos() {
    var nombre = document.getElementById('nombre').value;
    var ciudad = document.getElementById('ciudad').value;

    if (nombre === "" || nombre === null) {
        alert("Ingrese el título del circuito");
        return false;
    } else {
        if (ciudad === "" || ciudad === null) {
            alert("Ingrese la ciudad del circuito");
            return false;
        }
    }

}


function validarEquipo() {
    var nombre = document.getElementById('nombre').value;
    var twitter = document.getElementById('twitter').value;
    
    if (nombre===null || nombre==="") {
        alert("Ingrese el nombre del equipo");
        return false;
    } else if (nombre.length > 100) {
            alert("El nombre debe contener menos de 100 caracteres");
            return false;
    }
    if (twitter===null || twitter==="") {
        alert("Ingrese el nombre de usuario de Twitter");
        return false;
    } else if (noticia.length > 50) {
            alert("El contenido nombre de usuario de Twitter debe contener menos de 50 caracteres");
            return false;
    }
}