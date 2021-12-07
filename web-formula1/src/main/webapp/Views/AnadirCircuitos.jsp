<%-- 
    Document   : AnadirCircuitos.jsp
    Created on : 1 déc. 2021, 01:12:02
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Circuito"%>
<%@page import="Models.ModeloDatos"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Circuito> circuitos = (ArrayList<Circuito>) request.getSession().getAttribute("circuitos");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <%
            String path = request.getContextPath();
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Añadir Circuitos</title>
        <link rel="stylesheet" href="<%= path%>/css/custom.css">
        <link rel="stylesheet" href="<%= path%>/css/all.min.css">
        <script src="../js/app.js"></script>

    </head>
    <body>
        <div class="page-container">
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
            <!--Form para añadir circuitos-->          
            <div class="form-gp">
                <form action="/web-formula1/CircuitosServlet?accion=insertar" method="post" enctype="multipart/form-data" ">
                    <table class="form-table-gp">
                        <tr><td><label>Nombre</label></td></tr>
                        <tr>
                            <td>
                                <input type="text" name="nombre" id="nombre" maxlength="100" width="400px">
                            </td>
                        </tr>
                        <tr><td><label>Ciudad</label></td></tr>
                        <tr>
                            <td>
                                <input type="text" name="ciudad" id="ciudad" maxlength="100" width="400px">
                            </td>
                        </tr>
                        <tr><td><label>País</label></td></tr>
                        <tr>
                            <td>
                                <input type="text" name="pais" id="pais" maxlength="100" width="400px">
                            </td>
                        </tr>
                        <tr><td><label>Numero de vueltas</label></td></tr>
                        <tr>
                            <td>
                                <input type="number" name="numeroDeVueltas" id="numeroDeVueltas" maxlength="100" width="400px">
                            </td>                                                    
                        </tr>                       
                        <tr><td><label>Longitud</label></td></tr>
                        <tr>
                            <td>
                                <input type="number" name="longitud" id="longitud" maxlength="100" width="400px">
                            </td>
                        </tr>
                        <tr><td><label>Curvas Lentas</label></td></tr>
                        <tr>
                            <td>
                                <input type="number" name="curvasLentas" id="curvasLentas" maxlength="100" width="400px" >
                            </td>
                        </tr>
                        <tr><td><label>Curvas Media</label></td></tr>
                        <tr>
                            <td>
                                <input type="number" name="curvasMedia" id="curvasMedia" maxlength="100" width="400px">
                            </td>
                        </tr>
                        <tr><td><label>Curvas Rápidas</label></td></tr>
                        <tr>
                            <td>
                                <input type="number" name="curvasRapidas" id="curvasRapidas" maxlength="100" width="400px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="file" id="trazado" name="file" onchange="validarImagen(this)">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" id="adicionar_circuito" value="Adicionar" class="btn">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <!--Footer-->
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
