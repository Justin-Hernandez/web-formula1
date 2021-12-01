<%-- 
    Document   : AnadirCircuitos.jsp
    Created on : 1 déc. 2021, 01:12:02
    Author     : macbook
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
        <script src="<%= path%>/js/validaciones.js"></script>

    </head>
    <body>
        <div class="page-container">
            <!--Header-->
            <header class="header">
                <nav class="nav">
                    <a href="/web-formula1/Views/AdminPanel.jsp">                   
                        <img class="image" src="../img/f1_logo.png" alt="logo">
                    </a>    
                    <ul class="nav-menu">
                        <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                        <li class="nav-menu-item"><a href="/web-formula1/EquiposServlet?accion=listar" class="nav-menu-link nav-link">Equipos</a></li>
                        <li class="nav-menu-item"><a href="/web-formula1/VotacionesServlet?accion=listar" class="nav-menu-link nav-link">Votaciones</a></li>
                        <li class="nav-menu-item"><a href="/web-formula1/CalendarioServlet?accion=listar_eventos" class="nav-menu-link nav-link">Calendario</a></li>
                    </ul>
                    <di class="admin">
                        <%if (usuario != null) {%>
                        <img class="avatar" src="../img/Diez.png" alt="Avatar">
                        <a href="/web-formula1/Views/AdminPanel.jsp" class="nav-menu-item"><%=usuario.getName()%></a>
                    </di>
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
                </nav>
            </header>

            <!--Añadir circuitos-->          
            <div class="form-gp">
                <form action="/web-formula1/CircuitosServlet?accion=insertar" method="post" enctype="multipart/form-data" ">
                    <table class="form-table-gp">
                        <!--<tr><td><label>Nombre</label></td></tr>-->
                        <tr><td><input type="text" name="nombre" id="nombre" maxlength="100" width="400px" placeholder="Nombre"></td></tr>
                        <!--<tr><td><label>Ciudad</label></td></tr>-->
                        <tr><td><input type="text" name="ciudad" id="ciudad" maxlength="100" width="400px" placeholder="Ciudad"></td></tr>
                        <!--<tr><td><label>País</label></td></tr>-->
                        <tr><td><input type="text" name="pais" id="pais" maxlength="100" width="400px" placeholder="País"></td></tr>
                        <!--<tr><td><label>Numero de vueltas</label></td></tr>-->
                        <tr>
                            <td>
                                <input type="number" name="numeroDeVueltas" id="numeroDeVueltas" maxlength="100" width="400px" placeholder="Numero de vueltas">
                            </td>                                                    
                        </tr>                       
                        <!--<tr><td><label>Longitud</label></td></tr>-->
                        <tr><td><input type="number" name="longitud" id="longitud" maxlength="100" width="400px" placeholder="Longitud"></td></tr>
                        <!--<tr><td><label>Curvas Lentas</label></td></tr>-->
                        <tr><td><input type="number" name="curvasLentas" id="curvasLentas" maxlength="100" width="400px" placeholder="Curvas Lentas"></td></tr>
                        <!--<tr><td><label>Curvas Media</label></td></tr>-->
                        <tr><td><input type="number" name="curvasMedia" id="curvasMedia" maxlength="100" width="400px" placeholder="Curvas Media"></td></tr>
                        <!--<tr><td><label>Curvas Rápidas</label></td></tr>-->
                        <tr><td><input type="number" name="curvasRapidas" id="curvasRapidas" maxlength="100" width="400px" placeholder="Curvas Rápidas"></td></tr>
                        <tr>
                            <td><input type="file" id="trazado" name="file" onchange="validarImagen(this)"></td>
                        </tr>
                        <tr>
                            <td><input type="submit" id="adicionar_circuito" value="Adicionar" class="btn"></td>
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
