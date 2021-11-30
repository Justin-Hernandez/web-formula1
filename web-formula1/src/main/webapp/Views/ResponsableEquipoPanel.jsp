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

        <section class="section">
            <ul>
                <%if (!usuario.getEquipo().equals("null")) {%>
                <li class="section-item"><a href="/web-formula1/GestionResponsables"><i class="fas fa-vote-yea"></i> Gestión de Responsables</a></li>
                <li class="section-item"><a href="/web-formula1/CochesServlet?accion=listar"><i class="fas fa-car"></i> Gestión de coches</li>
                <li class="section-item"><a href="/web-formula1/PilotosServlet?accion=listar"><i class="fas fa-vote-yea"></i> Gestión de Pilotos</li></a>
                    <%}%>        
                <li class="section-item"><a href="/web-formula1/EquipoServlet"><i class="fas fa-vote-yea"></i> Gestión de Equipo</a></li>
                <li class="section-item"><a href="/web-formula1/SimulacionesServlet"><i class="fas fa-vote-yea"></i> Simulaciones</a></li>
                
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
    </body>
</html>
