<%-- 
    Document   : index
    Created on : Oct 28, 2021, 6:37:14 PM
    Author     : Justin Hernández
--%>

<%@page import="java.io.File"%>
<%@page import="Models.User"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.News"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.ModeloDatos"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        ArrayList<News> news = (ArrayList<News>) request.getSession().getAttribute("news");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>Noticias</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/app.js"></script>
    </head>
    <body>    
        <div class="page-container">
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



            <!--News Section-->
            <div class="section_title">Noticias</div>
            <hr> 
            <section class="cards">
                <% for (News n : news) {%>
                <a href="<%=n.getPermalink()%>" class="card">
                    <div class="card_image" style='background-image: url("<%=n.getImg()%>")'></div>
                    <div class="card_content">
                        <div class="card_title"><%=n.getTitulo()%></div>
                        <!--<div class="card_article_noticias"><%=n.getTexto()%></div>-->
                        <div class="card_article_noticias">Haz clic aquí para leer más</div>
                    </div>
                </a>
                <%}%>
            </section>

            <footer class="footer-gp">
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

