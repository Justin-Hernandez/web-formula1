<%-- 
    Document   : Votaciones
    Created on : 23 nov. 2021, 16:35:07
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page import="Models.Votacion"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Votacion> votaciones = (ArrayList<Votacion>) request.getSession().getAttribute("votaciones");
        User usuario = (User) session.getAttribute("usuario");
        ArrayList<Integer> idP = (ArrayList<Integer>) request.getSession().getAttribute("idP");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Votaciones</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
    </head>
    <body>
        <div class="page-container">
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
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="InicioSesion.jsp">Iniciar sesi??n</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="CrearCuenta.jsp">Crear cuenta</a></li>    
                </ul> 
                <%}%>
                <!--responsive-->
                <a href="javascript:void(0);" class="icon" onclick="myFunction()">
                    <i class="fa fa-bars"></i>
                </a>
            </div>
            <!--Votations Section-->
            <div class="section_title">Votaciones</div>
            <hr> 
            <section class="cards">
                <% for (Votacion v : votaciones) {%>
                <a href="<%=v.getPermalink()%>" target="_blank" class="card">
                    <div class="card_content">
                        <div  class="card_image" style='background-image: url("../img/votacion.jpg")'></div>
                        <div style="margin-top: 10px" class="card_title"><%=v.getTitulo()%></div>
                        <div style="text-align: center" class="card_article"><%=v.getDescripcion()%></div>
                        <div  style="text-align: center" class="card_article">Fecha Limite: <%=v.getFechaLimite()%></div>
                    </div>
                </a>
                <%}%>
            </section>

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
