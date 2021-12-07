<%-- 
    Document   : AnadirPilotos
    Created on : 30 nov. 2021, 22:27:43
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page import="Models.Piloto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@page import="Models.ModeloDatos"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Piloto> pilotos = (ArrayList<Piloto>) request.getSession().getAttribute("pilotos");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <title>Añadir Pilotos</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/app.js"></script>
    </head>
    <body>
        <!--Header-->
        <div class="topnav" id="myTopnav">
            <%if (usuario != null) {%>
            <%if (("Administrador").equals(usuario.getRol())) {%>
            <a href="/web-formula1/Views/AdminPanel.jsp" style="padding: 10px">
                <img class="image" src="../img/f1_logo.png" alt="logo">
            </a>
            <%} else {%>
            <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" style="padding: 10px">
                <img class="image" src="../img/f1_logo.png" alt="logo">
            </a>
            <%}%>
            <%} else {%>
            <a href="/web-formula1/Views/Noticias.jsp" style="padding: 10px">
                <img class="image" src="../img/f1_logo.png" alt="logo">
            </a>
            <%}%> 
            <div class="nav-element">
                <a href="/web-formula1/NoticiasServlet?accion=listar">Noticias</a>                    
                <a href="/web-formula1/EquiposServlet?accion=listar">Equipos</a>
                <a href="/web-formula1/VotacionesServlet?accion=listar">Votaciones</a>
                <a href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a>
            </div>
            <%if (usuario != null) {%>
            <%if (("Administrador").equals(usuario.getRol())) {%>
            <a href="/web-formula1/Views/AdminPanel.jsp" class="avatar-name">
                <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
            </a>
            <%} else {%>
            <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="avatar-name">
                <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
            </a>
            <%}%>
            <a class="down" href="Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
                <%if (request.getParameter("logout") != null) {
                        session.removeAttribute("usuario");
                        response.sendRedirect("Noticias.jsp");
                    }
                } else {%>

            <ul class="nav-menu">
                <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="InicioSesion.jsp">Iniciar sesión</a></li>
                <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="CrearCuenta.jsp">Crear cuenta</a></li>    
            </ul> 
            <%}%>
            <!--responsive-->
            <a href="javascript:void(0);" class="icon" onclick="myFunction()">
                <i class="fa fa-bars"></i>
            </a>
        </div>

        <!--Form-->
        <div class="form-gp">
            <form action="/web-formula1/PilotosServlet?accion=insertar" method="post" enctype="multipart/form-data" ">
                <table class="form-table-gp">
                    <tr><td><label>Nombre</label></td></tr>
                    <tr><td><input type="text" name="nombre" id="nombre" maxlength="100"></td></tr>
                    <tr><td><label>Apellidos</label></td></tr>
                    <tr><td><input type="text" name="apellidos" id="apellidos" maxlength="100" width="400px"></td></tr>          
                    <tr><td><label>Siglas</label></td></tr>
                    <tr><td><input type="text" name="siglas" id="siglas" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>Dorsal</label></td></tr>
                    <tr><td><input type="text" name="dorsal" id="dorsal" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>País</label></td></tr>
                    <tr><td><input type="text" name="pais" id="pais" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>Equipo</label></td></tr>
                    <tr><td><input type="text" name="equipoV" id="equipoV" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>Twitter</label></td></tr>
                    <tr><td><input type="text" name="twitter" id="twitter" maxlength="100" width="400px"></td></tr>
                    <tr>
                        <td><input type="file" id="foto" name="file" onchange="validarImagen(this)"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" id="adicionar_piloto" value="Adicionar" class="btn"></td>
                    </tr>
                </table>
            </form>
        </div>
        <!--Footer-->
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
