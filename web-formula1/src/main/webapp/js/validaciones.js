/*window.onload = function () {
    validarFechaVotaciones();
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


/*
function validarFechaVotaciones() {
    fecha = document.getElementById("date");

    var tzoffset = (new Date()).getTimezoneOffset() * 60000; //offset in milliseconds
    var localISOTime = (new Date(Date.now() - tzoffset)).toISOString().slice(0, -1);

    //var iso = new Date().toISOString();
    //var minDate = iso.substring(0, iso.length - 1);
    fecha.value = localISOTime;
    fecha.min = localISOTime;
}*/

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

    if (nombre === null || nombre === "") {
        alert("Ingrese el nombre del equipo");
        return false;
    } else if (nombre.length > 100) {
        alert("El nombre debe contener menos de 100 caracteres");
        return false;
    }
    if (twitter === null || twitter === "") {
        alert("Ingrese el nombre de usuario de Twitter");
        return false;
    } else if (twitter.length > 50) {
        alert("El contenido nombre de usuario de Twitter debe contener menos de 50 caracteres");
        return false;
    }
}


function validarAlVotar() {
    var nombreVotante = document.getElementById("nombre").value;
    var correoVotante = document.getElementById("correo").value;
    var radios = document.getElementsByName("piloto");

    if (nombreVotante === null || nombreVotante === "") {
        alert("Ingrese su nombre");
        return false;
    }
    if (correoVotante === null || correoVotante === "") {
        alert("Ingrese su correo");
        return false;
    }
    if (radios.length === checkedRadio(radios)) {
        alert("Debe seleccionar al menos un piloto");
        return false;
    }
}


function checkedRadio(radios) {
    var marcados = 0;
    for (var i = 0, len = radios.length; i < len; i++) {
        if (!radios[i].checked) {
            marcados++;
        }
    }
    return marcados;
}

function validarCrearVotacion() {
    var titulo = document.getElementById("titulo").value;
    var descripcion = document.getElementById("descripcion").value;
    var fecha_limite = document.getElementById("date").value;
    var checkboxs = document.getElementsByName("siglas");

    if (titulo === null || titulo === "") {
        alert("Ingrese el título de la votación");
        return false;
    } else {
        if (titulo.length > 100) {
            alert("El título de la votación debe ser máximo 100 caracteres");
            return false;
        }
    }
    if (descripcion === null || descripcion === "") {
        alert("Ingrese la descripción de la votación");
        return false;
    } else {
        if (descripcion.length > 500) {
            alert("La descripción de la votación debe ser máximo 500 caracteres");
            return false;
        }
    }
    if (fecha_limite == null || fecha_limite === "") {
        alert("Debe seleccionar una fecha límite para la votación");
        return false;
    }
    if (checkboxs.length === checkedCheckBox(checkboxs)) {
        alert("Debe seleccionar al menos un piloto para poder crear la votación");
        return false;
    }

}

function checkedCheckBox(checkboxs) {
    var marcados = 0;
    for (var i = 0, len = checkboxs.length; i < len; i++) {
        if (!checkboxs[i].checked) {
            marcados++;
        }
    }
    return marcados;
}

function validarFechaEvento() {
    var fecha_evento = document.getElementById("dateEvent");
    if (fecha_evento == null || fecha_evento === "") {
        alert("Debe seleccionar una fecha para crear el evento en el calendario");
        return false;
    }
}