<%-- 
    Document   : AnadirCoches
    Created on : 1 déc. 2021, 18:38:37
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page import="Models.Coche"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@page import="Models.ModeloDatos"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Coche> coches = (ArrayList<Coche>) request.getSession().getAttribute("coches");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <title>Añadir Coches</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/app.js"></script>
    </head>
    <body>
        <!--Header-->
        <div class="topnav" id="myTopnav">
            <a class="logo" href="/web-formula1/Views/ResponsableEquipoPanel.jsp" style="padding: 10px">                   
                <img class="image" src="../img/f1_logo.png" alt="logo">
            </a>  
            <div class="nav-element">
                <a href="/web-formula1/NoticiasServlet?accion=listar">Noticias</a>                    
                <a href="/web-formula1/EquiposServlet?accion=listar">Equipos</a>
                <a href="/web-formula1/VotacionesServlet?accion=listar">Votaciones</a>
                <a href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a>
            </div>
            <%if (usuario != null) {%>
            <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="avatar-name">
                <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
            </a>

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
        <!--Añadir coches-->
        <div class="form-gp">
            <form action="/web-formula1/CochesServlet?accion=insertar" method="post" enctype="multipart/form-data" ">
                <table class="form-table-gp">
                    <tr><td><label>Nombre</label></td></tr>
                    <tr><td><input type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>Código</label></td></tr>
                    <tr><td><input type="text" name="codigo" id="codigo" maxlength="100" width="400px"></td></tr>          
                    <tr><td><label>ERS-Curva Lenta</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="ersCL" id="ersCL" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>ERS-Curva Media</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="ersCM" id="ersCM" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>ERS-Curva Rápida</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="ersCR" id="ersCR" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>Consumo</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="consumo" id="consumo" maxlength="100" width="400px"></td></tr>
                    <tr>
                        <td><input type="submit" id="adicionar_coche" value="Adicionar" class="btn"></td>
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
