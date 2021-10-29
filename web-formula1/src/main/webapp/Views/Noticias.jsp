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
            </nav>
        </header>
        
        <% for(News n: news) {%>
        <h1><%=n.getTitulo()%></h1>
        <textarea name="textarea" rows="20" cols="50" readonly="true"><%=n.getTexto()%></textarea>
        <img src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(n.getImg())%>" />
        <%}%>
        
        
        <footer class="footer">
            <br>
            Encuentra nuestro proyecto en <a  href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i>
            <p>2021 ©</p>
            
        </footer>
        
    </body>
</html>

