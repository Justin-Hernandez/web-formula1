<%-- 
    Document   : AdminPanel
    Created on : 28/10/2021, 08:16:07 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel de Administración</title>
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
              
                <img class="avatar" src="../img/Diez.png" alt="Avatar">
                <% String nombre = (String) session.getAttribute("name"); %>
                <a class="nav-menu-item"><%=nombre%></a>
                
            </nav>
        </header>
        
        <section class="section">
            <ul>
                <li class="section-item"><a href="GestionNoticias.jsp"><i class="fas fa-newspaper"></i> Gestión de noticias</a></li>
                <li class="section-item"><i class="fas fa-road"></i> Gestión de circuitos</li>
                <li class="section-item"><i class="fas fa-vote-yea"></i> Gestión de votaciones</li>
                <li class="section-item"><i class="fas fa-users"></i> Gestión de equipos</li>
                <li class="section-item"><i class="fas fa-user"></i> Gestión de usuarios</li>
            </ul>
        </section>
        
        
        <footer class="footer">
            <br>
            Encuentra nuestro proyecto en <a  href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i>
            <p>2021 ©</p>
            
        </footer>
        
    </body>
</html>
