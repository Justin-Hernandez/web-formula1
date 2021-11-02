function validarNoticias() {
    var titulo_noticia = document.getElementById('titulo_noticia').value;
    var noticia = document.getElementById('noticia').value;

    if (titulo_noticia === "" || titulo_noticia === null) {
        alert("Ingrese el título de la noticia");
        return false;
    } else {
        if (noticia === "" || noticia === null) {
            alert("Ingrese la noticia");
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