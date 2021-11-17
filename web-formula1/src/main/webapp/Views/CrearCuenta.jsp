<%-- 
    Document   : CrearCuenta
    Created on : 29/10/2021, 09:37:34 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%
            String path = request.getContextPath();
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear cuenta de usuario</title>

        <link rel="stylesheet" href="<%= path%>/css/custom.css">
        <link rel="stylesheet" href="<%= path%>/css/all.min.css">
        <link rel="stylesheet" href="<%= path%>/css/bootstrap.min.css">
        <script src="<%= path%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%= path%>/js/bootstrap.min.js"></script>
        <script src="<%= path%>/js/validaciones.js"></script>
    </head>
    <body>
        <div class="page-container">


            <div class="login-box">
                <h1>Crear una cuenta</h1>
                <%
                    String existe_correo = (String) request.getAttribute("existe_correo");
                    String existe_usuario = (String) request.getAttribute("existe_usuario");
                    String conformacion = (String) request.getAttribute("confirmacion");

                    if (existe_correo != null) {%>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <%=existe_correo%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%}
                if (existe_usuario != null) {%>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <%=existe_usuario%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%}
                if (conformacion != null) {%>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%=conformacion%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <%}
                %>
                <form action="/web-formula1/RegistroUsuarioServlet" method="post" onsubmit="return(validarFormularioCrearCuenta());">
                    <input type="text" placeholder="Nombre completo" name="name" id="name">
                    <input type="text" placeholder="Nombre de usuario" name="user" id="user">
                    <input type="email" placeholder="Correo electrónico" name="email" id="email">
                    <input type="password" placeholder="Contraseña" name="password" id="password">
                    <input type="submit" id="crear_cuenta" value="Crear cuenta">
                    <p>¿Ya tienes cuenta? <a href="<%= path%>/Views/InicioSesion.jsp">Iniciar sesión</a></p>
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
        </div>
    </body>
</html>
