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

function validarFormularioCrearCuenta() {
    var name = document.getElementById("name").value;
    var user = document.getElementById("user").value;
    var email = document.getElementById("email").value;
    var contrsenha = document.getElementById("password").value;
    
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
        alert('El navegador no soporta la lectura de archivos');
        return false;
    }

    if (!(/\.(jpg|jpeg|png|gif)$/i).test(uploadFile.name)) {
        document.getElementById('imagen_noticia').value = null;
        alert('El archivo a seleccionado no es una imagen');
    } else {
        var img = new Image();
        img.onload = function () {
            if (uploadFile.size > 3145728)
            {
                alert('El peso de la imagen no puede exceder los 3MB')
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