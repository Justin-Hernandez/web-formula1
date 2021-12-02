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
        String path = request.getContextPath();
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>Noticias</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
    </head>
    <body>    
        <header class="header">
            <nav class="nav">
                <img class="image" src="../img/f1_logo.png">
                <ul class="nav-menu">
                    <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/EquiposServlet?accion=listar" class="nav-menu-link nav-link">Equipos</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/VotacionesServlet?accion=listar" class="nav-menu-link nav-link">Votaciones</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/CalendarioServlet?accion=listar_eventos" class="nav-menu-link nav-link">Calendario</a></li>
                </ul>
                <%if (usuario != null) {%>
                <img class="avatar" src="../img/Diez.png" alt="Avatar">
                <a class="nav-menu-item"><%=usuario.getName()%></a><a class="down" href="Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
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
            </nav>
        </header>

        <!--News Section-->
        <div class="section_title">Noticias</div>
        <hr> 
        <section class="cards">
            <% for (News n : news) {%>
            <a href="<%=n.getPermalink()%>" target="_blank" class="card">
                <div class="card_image" style='background-image: url("<%=n.getImg()%>")'></div>
                <div class="card_content">
                    <div class="card_title"><%=n.getTitulo()%></div>
                    <div class="card_article"><%=n.getTexto()%></div>
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

    </body>
</html>

