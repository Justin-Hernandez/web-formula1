<%-- 
    Document   : CrearCuenta
    Created on : 29/10/2021, 09:37:34 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear cuenta de usuario</title>

        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <script src="../js/jquery-3.6.0.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/validaciones.js"></script>
    </head>
    <body>

            <%
            String existe_correo = (String) request.getSession().getAttribute("existe_correo");
            if(existe_correo != null){%>
                <div class="alert alert-warning" role="alert">
                    A simple warning alert—check it out!
                </div>
            <%}%>
         
       <div class="login-box">
            <h1>Crear una cuenta</h1>
            <form action="/web-formula1/RegistroUsuarioServlet" method="post" onsubmit="return validarFormularioCrearCuenta();">
                <input type="text" placeholder="Nombre completo" name="name" >
                <input type="text" placeholder="Nombre de usuario" name="user" >
                <input type="email" placeholder="Correo electrónico" name="email">
                <input type="password" placeholder="Contraseña" name="password">
                <input type="submit" value="Crear cuenta">
                <p>¿Ya tienes cuenta? <a href="InicioSesion.jsp">Iniciar sesión</a></p>
            </form>
        </div>


        <footer class="footer">
            <br>
            Encuentra nuestro proyecto en <a  href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i>
            <p>2021 ©</p>

        </footer>
    </body>
</html>
