<%-- 
    Document   : Votacion
    Created on : 23/11/2021, 12:25:38 PM
    Author     : DELL
--%>

<%@page import="Models.User"%>
<%@page import="Models.Piloto"%>
<%@page import="Models.Votacion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%

        Votacion votacion = (Votacion) request.getSession().getAttribute("votacion");
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
                <img class="image" src="../img/f1_logo.png">
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
        <form  action="/web-formula1/VotarServlet?votacion=<%=votacion%>" method="POST" onsubmit="return validarAlVotar()">
            <div>
                <h2 style="text-align: center"><%=votacion.getTitulo()%></h2>

                <%
                    String existe_votacion = (String) session.getAttribute("existe_votacion");
                    String votacion_creada = (String) session.getAttribute("votacion_creada");

                    if (existe_votacion != null) {%>
                <p style="color: red; text-align: center; margin-top: 2px"><%=existe_votacion%></p>
                <%
                        session.removeAttribute("existe_votacion");
                    }
                    if (votacion_creada != null) {%>
                <p style="color: green; text-align: center; margin-top: 2px"><%=votacion_creada%></p>
                <%
                        session.removeAttribute("votacion_creada");
                    }
                %>


                <div style="text-align: center; margin-top: 1%">
                    <label>Nombre:</label>
                    <input id="nombre" name="nombre" style="margin-right: 100px" type="text">
                    <label>Correo:</label>
                    <input id="correo" name="correo" type="email">
                </div>

                <div style="text-align: center">
                    <table   cellpadding="20" style="margin: auto">
                        <%for (Piloto piloto : votacion.getListaPilotos()) {%>
                        <tr>
                            <td>
                                <input style="float: left" type="radio" name="piloto" value="<%=piloto.getId()%>" style="margin-bottom: 5px; width: 92px; height: 59px">
                            </td>
                            <td>
                                <img style="float: left" src="../img/Diez.png" >
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

                        </tr>
                        <%}%>
                    </table>
                </div>

                <div style="text-align: center">
                    <input class="boton-rojo" type="submit" value="Votar">
                </div>
            </div>
        </form>

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
