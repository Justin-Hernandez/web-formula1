<%-- 
    Document   : GestionEquipos
    Created on : 14-nov-2021, 18:20:14
    Author     : laura
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.ModeloDatos"%>
<%@page import="Models.Equipo"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Equipo> equipos = (ArrayList<Equipo>) request.getSession().getAttribute("equipos");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Equipos</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
        <style>
            .info-button {
                    border-style: none;
                    background-color: rgb(236, 235, 235);
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


                <%
                if(session.getAttribute("name") != null){%>
                    <img class="avatar" src="../img/Diez.png" alt="Avatar">
                    <% String nombre = (String) session.getAttribute("name"); %>
                    <a href="AdminPanel.jsp" class="nav-menu-item"><%=nombre%></a><a class="down" href="Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
                    <%if(request.getParameter("logout")!= null){
                        session.removeAttribute("name");
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
                <%
                    if (session.getAttribute("rol") != null && ("Responsable de Equipo").equals((String) session.getAttribute("rol"))) {%>
                        <form action="/web-formula1/EquiposServlet?accion=insertar" method="post" enctype="multipart/form-data" onsubmit="return validarEquipos();">
                            <table>
                                <tr><td><label>Nombre</label></td></tr>
                                <tr><td><input type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                                <tr><td><label>Twitter</label></td></tr>
                                <tr><td><input type="text" name="twitter" id="twitter" maxlength="50" width="400px"></td></tr>
                                <tr>
                                    <td><input type="file" id="logo" name="logo" onchange="validarImagen(this)"></td>
                                </tr>
                                <tr>
                                    <td><input type="submit" id="add_equipo" value="Añadir"></td>
                                </tr>
                            </table>
                        </form>

                <%}%> 
        <!--View/Delete-->
        <table>
            <% for (Equipo e : equipos) {%>
            <tr>
                <td class="td-noticias"><%=e.getNombre()%></td>
                <td class="td-icons"><button class="info-button"><i class="fas fa-info-circle"></i></button></td>
                <td class="td-icons"><button class="trash-button"><i class="fas fa-trash"></i></a></button></td>
            </tr>
            <%}%>
        </table>

        <footer class="footer">
            <br>
            Encuentra nuestro proyecto en <a  href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i>
            <p>2021 ©</p>

        </footer>
</body>
</html>
