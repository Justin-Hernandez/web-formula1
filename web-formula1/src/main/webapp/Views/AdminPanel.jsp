<%-- 
    Document   : AdminPanel
    Created on : 28/10/2021, 08:16:07 PM
    Author     : DELL
--%>

<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        User usuario = (User) session.getAttribute("usuario");
    %>    
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
                    <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/EquiposServlet?accion=listar" class="nav-menu-link nav-link">Equipos</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/VotacionesServlet?accion=listar" class="nav-menu-link nav-link">Votaciones</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/CalendarioServlet?accion=listar_eventos" class="nav-menu-link nav-link">Calendario</a></li>
                </ul>
                
                <%if(usuario != null){%>
                    <img class="avatar" src="../img/Diez.png" alt="Avatar">
                    <a class="nav-menu-item"><%=usuario.getName()%></a><a class="down" href="NoticiasSevlet?logout=1"><i class="fas fa-door-open"></i></a>
                    <%if(request.getParameter("logout")!= null){
                        session.removeAttribute("usuario");
                        response.sendRedirect("Noticias.jsp");
                    }
                }else{%>
                   <ul class="nav-menu">
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="InicioSesion.jsp">Iniciar sesión</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="CrearCuenta.jsp">Crear cuenta</a></li>    
                   </ul> 
                <%}%>  
            </nav>
        </header>
        
        <section class="section">
            <ul>
                <li class="section-item"><a href="/web-formula1/NoticiasServlet?accion=gestion-noticias"><i class="fas fa-newspaper"></i> Gestión de noticias</a></li>
                    <li class="section-item"><a href="/web-formula1/CircuitosServlet?accion=listar"><i class="fas fa-road"></i> Gestión de circuitos</a></li>
                    <li class="section-item"><a href="/web-formula1/VotacionesServlet?accion=votaciones"><i class="fas fa-vote-yea"></i> Gestión de votaciones</a></li>
                    <li class="section-item"><a href="/web-formula1/GestionEquiposServlet?accion=listar"><i class="fas fa-users"></i>Gestión de equipos</li>
                    <li class="section-item"><a href="/web-formula1/GestionUsuarios"><i class="fas fa-user"></i> Gestión de usuarios</li>
                </ul>
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