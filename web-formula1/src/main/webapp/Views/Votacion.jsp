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

        <!--Header-->
        <div class="topnav" id="myTopnav">
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
            <div class="nav-element">
                <a href="/web-formula1/NoticiasServlet?accion=listar">Noticias</a>                    
                <a href="/web-formula1/EquiposServlet?accion=listar">Equipos</a>
                <a href="/web-formula1/VotacionesServlet?accion=listar">Votaciones</a>
                <a href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a>
            </div>
            <%if (usuario != null) {%>
            <%if (("Administrador").equals(usuario.getRol())) {%>
            <a href="/web-formula1/Views/AdminPanel.jsp" class="avatar-name">
                <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
            </a>
            <%} else {%>
            <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="avatar-name">
                <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
            </a>
            <%}%>
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

        <div>
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

                            </tr>
                            <%}%>
                        </table>
                    </div>

                    <div style="text-align: center">
                        <input class="btn" type="submit" value="Votar">
                    </div>
                </div>
            </form>
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
