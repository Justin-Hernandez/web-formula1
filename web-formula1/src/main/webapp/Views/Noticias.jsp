<%-- 
    Document   : index
    Created on : Oct 28, 2021, 6:37:14 PM
    Author     : Justin Hernández
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.News"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.ModeloDatos"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<News> news = (ArrayList<News>) request.getSession().getAttribute("news");
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
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Noticias</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Equipos</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Votaciones</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Calendario</a></li>
                </ul>   
                <ul class="nav-menu">
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="InicioSesion.jsp">Iniciar sesión</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="CrearCuenta.jsp">Crear cuenta</a></li>    
                </u>
            </nav>
        </header>
        
        <!--News Section-->
        <div class="section_title">Noticias</div>
        <hr> 
        <section class="cards">
            <% for(News n: news) {%>
            <a href="" class="card">
                <!--<div class="card_image" style="background-image: url('data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(n.getImg())%>')"></div>-->
                <div class="card_image" style="background-image: url('../img/img2.jpg')"></div>
                <div class="card_content">
                    <div class="card_title"><%=n.getTitulo()%></div>
                    <div class="card_article">
                        <%=n.getTexto()%>
                    </div>
                </div>
            </a>
            <%}%>
        </section>

        <footer class="footer">
            <br>
            Encuentra nuestro proyecto en <a  href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i>
            <p>2021 ©</p>          
        </footer>
        
    </body>
</html>

