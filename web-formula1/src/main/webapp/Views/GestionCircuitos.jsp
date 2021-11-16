<%-- 
    Document   : GestionCircuitos
    Created on : 10 nov. 2021, 00:58:05
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de circuitos</title>
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
        <!--Añadir circuitos-->
        <form action="/web-formula1/CircuitosServlet?accion=insertar" method="post" enctype="multipart/form-data" ">
            <table>
                <tr><td><label>Nombre</label></td></tr>
                <tr><td><input type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Ciudad</label></td></tr>
                <tr><td><input type="text" name="ciudad" id="ciudad" maxlength="100" width="400px"></td></tr>
                <tr><td><label>País</label></td></tr>
                <tr><td><input type="text" name="pais" id="pais" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Numero de vueltas</label></td></tr>
                <tr><td><input type="number" name="numeroDeVueltas" id="numeroDeVueltas" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Longitud</label></td></tr>
                <tr><td><input type="number" name="longitud" id="longitud" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Curvas Lentas</label></td></tr>
                <tr><td><input type="number" name="curvasLentas" id="curvasLentas" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Curvas Media</label></td></tr>
                <tr><td><input type="number" name="curvasMedia" id="curvasMedia" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Curvas Rápidas</label></td></tr>
                <tr><td><input type="number" name="curvasRapidas" id="curvasRapidas" maxlength="100" width="400px"></td></tr>
                <tr>
                    <td><input type="file" id="trazado" name="file" onchange="validarImagen(this)"></td>
                </tr>
                <tr>
                    <td><input type="submit" id="adicionar_circuito" value="Adicionar"></td>
                </tr>
            </table>
        </form>
        <!--Edit/Delete-->
        <table>
            <% for (Circuito c : circuitos) {%>
            <tr>
                <td class="td-noticias"><%=c.getNombre()%></td>
                <td class="td-icons"><button class="edit-button"><i class="fas fa-edit"></i></button></td>
                <td class="td-icons">
                    <button class="trash-button">
                        <a href="/web-formula1/CircuitosServlet?accion=eliminar&nombre=<%=c.getNombre()%>">
                            <i class="fas fa-trash"></i>
                        </a>
                    </button>
                </td>
            </tr>
            <%}%>
        </table>

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