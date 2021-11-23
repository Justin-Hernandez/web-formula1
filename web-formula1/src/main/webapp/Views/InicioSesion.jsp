<%-- 
    Document   : InicioSesionServlet
    Created on : 29/10/2021, 09:32:32 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Iniciar sesión</title>

        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
    </head>
    <body>

        <div class="login-box">
            <h1>Inicio de sesión</h1>
            <form action="/web-formula1/LoginServlet" method="post">
                <input type="text" placeholder="Nombre de usuario" name="user" >
                <input type="password" placeholder="Contraseña" name="password">
                <input type="submit" value="Entrar">
                <p>¿Eres de nuestros usuarios? <a href="CrearCuenta.jsp">Crear cuenta</a></p>
            </form>
        </div>

        <footer class="footer">
            <div class="footer_div">
                <div>
                    Encuentra nuestro proyecto en <a href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i><br>
                </div>
                <p>2021 &copy</p>
            </div>
        </footer>

    </body>
</html>
