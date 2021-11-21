<%-- 
    Document   : GestionEquipos
    Created on : 14-nov-2021, 18:20:14
    Author     : laura
--%>


<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.ModeloDatos"%>
<%@page import="Models.Equipo"%>
<!DOCTYPE html>
<html>
    <%
        Equipo equipoUser = (Equipo) request.getSession().getAttribute("equipoUser");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión Equipo</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
        <style>
            .info-button {
                    border-style: none;
                    background-color: rgb(236, 235, 235);
            }
            .titulo {
                margin-left: 30px;
            }
            .datos{
                margin: 20px;
                margin-left: 40px;
            }
            .label{
                margin-top: 10px;
                margin-bottom: 5px;
            }
            .input{
                margin-top: 5px;
                margin-bottom: 5px;
            }
            
        </style>
    </head>
    <body>
        <header class="header">
            <nav class="nav">
                <img class="image" src="../img/f1_logo.png">
                <ul class="nav-menu">
                    <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Equipos</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Votaciones</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Calendario</a></li>
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
            <div style="width: 50%; float:left">
                <%if (equipoUser == null) {%>
                <h1 class="titulo">Añadir Equipo</h1>
                <form class="datos" action="/web-formula1/EquipoServlet?accion=insertar" method="post" enctype="multipart/form-data" onsubmit="return validarEquipo();">
                    <table>
                        <tr><td><label class="label">Nombre</label></td></tr>
                        <tr><td><input class="input" type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                        <tr><td><label class="label">Twitter</label></td></tr>
                        <tr><td><input class="input" type="text" name="twitter" id="twitter" maxlength="50" width="400px"></td></tr>
                        <tr><td><label class="label">Logo</label></td></tr>
                        <tr>
                            <td><input class="input" type="file" id="imagen_noticia" name="file" onchange="validarImagen(this)"></td>
                        </tr>
                        <tr>
                            <td><input class="label" type="submit" id="add_equipo" value="Añadir"></td>
                        </tr>
                    </table>
                </form>
                    <%
                    String mensaje = (String) request.getSession().getAttribute("mensaje");

                    if (mensaje != null) {%>
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <%=mensaje%>
                        </div>
                    <%}%> 
                <%} else {%> 
                <h1 class="titulo">Detalles Equipo</h1>
                <form class="datos">
                    <table>
                        <tr><td><label class="label">Nombre</label></td></tr>
                        <tr><td><input class="input" type="text" name="nombre" id="nombre" maxlength="100" width="400px" value="<%=equipoUser.getNombre()%>" disabled></td></tr>
                        <tr><td><label class="label">Twitter</label></td></tr>
                        <tr><td><input class="input" type="text" name="twitter" id="twitter" maxlength="50" width="400px" value="<%=equipoUser.getTwitter()%>" disabled ></td></tr>
                        <%if (equipoUser.getLogo() != null && !equipoUser.getLogo().isEmpty()) {%>
                            <tr><td><label class="label" >Logo</label></td></tr>
                            <tr><td><img class="imageEquipo" src="<%=equipoUser.getLogo()%>" width="400"></td></tr>
                        <%}%> 
                    </table>
                </form>
            </div>
            <div style="width: 50%; float:right">
                <br/>
                <h3 class="titulo">Pilotos del Equipo</h3>
                <br/>
                <h3 class="titulo">Coches del Equipo</h3>
                <br/>
            </div>

            <%}%> 
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
