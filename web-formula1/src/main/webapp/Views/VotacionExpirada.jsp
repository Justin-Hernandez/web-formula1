<%-- 
    Document   : VotacionExpirada
    Created on : 26/11/2021, 07:24:53 PM
    Author     : DELL
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Models.Piloto"%>
<%@page import="Models.User"%>
<%@page import="Models.Votacion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        Votacion votacion = (Votacion) request.getSession().getAttribute("votacion");
        ArrayList<Integer> votos = (ArrayList<Integer>) request.getSession().getAttribute("votos");  
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Votación</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
    </head>
    <body>
        <header class="header">
            <nav class="nav">
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
                <ul class="nav-menu">
                    <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Equipos</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Votaciones</a></li>
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

        <div>
            <h2 style="color: red; text-align: center">Esta votación ya excedió su fecha límite</h2>

            <div style="text-align: center">
                <table   cellpadding="20" style="margin: auto">
                    <%int i = 0;
                        for (Piloto piloto : votacion.getListaPilotos()) {%>
                    <tr>
                        <td>
                            <img style="float: left; width: 100px; height: 100px" src="<%=piloto.getFoto()%>" >
                        </td>
                        <td>
                            <p><strong><%= piloto.getSiglas()%></strong></p>
                        </td>
                        <td>
                            <p><strong><%= piloto.getNombre() + " " + piloto.getApellidos()%></strong></p>
                        </td>
                        <td>
                            <p><strong><%= piloto.getPais()%></strong></p>
                        </td>
                        <td>
                            <p><strong><%=piloto.getEquipoV()%></strong></p>
                        </td>
                        <td>
                            <p style="color: green"><strong>Tiene <%= votos.get(i)%> votos</strong></p>
                        </td>

                    </tr>
                    <%i++;}%>
                </table>
            </div>

        </div>


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
