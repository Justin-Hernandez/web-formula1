<%-- 
    Document   : GestionNoticias
    Created on : 30/10/2021, 10:23:38 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.News"%>
<%@page import="Models.ModeloDatos"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<News> news = (ArrayList<News>) request.getSession().getAttribute("news");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Noticias</title>
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

                <img class="avatar rounded-corners" src="../img/Diez.png" alt="User Image">
                <a class="nav-menu-item">Juan Gómez</a>

            </nav>
        </header>

        <div class="article">
            <label>Título:</label>
            <input type="text" name="title">
            <label>Artículo</label>
            <textarea name="title" rows="20" cols="50">hola mundo</textarea>
        </div>
        
        <!--Edit/Delete-->
        <table>
            <% for(News n: news) {%>
            <tr>
                <td class="td-noticias"><%=n.getTitulo()%></td>
                <td class="td-icons"><button class="edit-button"><i class="fas fa-edit"></i></button></td>
                <td class="td-icons"><button class="trash-button"><i class="fas fa-trash"></i></button></td>
            </tr>
            <%}%>
        </table>

        <footer class="footer">
            <br>
            Encuentra nuestro proyecto en <a  href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i>
            <p>2021 ©</p>

        </footer>
    </body>
</html>
