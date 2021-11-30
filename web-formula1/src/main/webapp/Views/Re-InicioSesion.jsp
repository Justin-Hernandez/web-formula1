<%-- 
    Document   : Re-InicioSesion
    Created on : 29 nov. 2021, 02:45:13
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        User usuario = (User) session.getAttribute("usuario");
    %>
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
                <input type="text" placeholder="Nombre de usuario" name="user" required>
                <input type="password" placeholder="Contraseña" name="password" required>
                <input type="submit" value="Entrar">
                <p>¿Eres de nuestros usuarios? <a href="CrearCuenta.jsp">Crear cuenta</a></p>
            </form>
            <br>
            <div class="err-msg">
                <%if (usuario == null) {%>
                <p>Nombre de usuario o Contraseña son incorrectos</p>
                <%}%>
            </div>
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
