<%-- 
    Document   : GestionPilotos
    Created on : 17 nov. 2021, 01:25:44
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page import="Models.Piloto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Piloto> pilotos = (ArrayList<Piloto>) request.getSession().getAttribute("pilotos");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <title>Gestion de pilotos</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
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
                <di class="admin">
                    <%if (usuario != null) {%>
                    <img class="avatar" src="../img/Diez.png" alt="Avatar">
                    <a class="nav-menu-item"><%=usuario.getName()%></a><a class="down" href="Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
                        <%if (request.getParameter("logout") != null) {
                                session.removeAttribute("usuario");
                                response.sendRedirect("Noticias.jsp");
                            }
                        } else {%>
                </di>
                <ul class="nav-menu">
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="InicioSesion.jsp">Iniciar sesión</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="CrearCuenta.jsp">Crear cuenta</a></li>    
                </ul> 
                <%}%>
            </nav>
        </header>

        <!--Añadir pilotos-->
        <form action="/web-formula1/PilotosServlet?accion=insertar" method="post" enctype="multipart/form-data" ">
            <table>
                <tr><td><label>Nombre</label></td></tr>
                <tr><td><input type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Apellidos</label></td></tr>
                <tr><td><input type="text" name="apellidos" id="apellidos" maxlength="100" width="400px"></td></tr>          
                <tr><td><label>Siglas</label></td></tr>
                <tr><td><input type="text" name="siglas" id="siglas" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Dorsal</label></td></tr>
                <tr><td><input type="text" name="dorsal" id="dorsal" maxlength="100" width="400px"></td></tr>
                <tr><td><label>País</label></td></tr>
                <tr><td><input type="text" name="pais" id="pais" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Twitter</label></td></tr>
                <tr><td><input type="text" name="twitter" id="twitter" maxlength="100" width="400px"></td></tr>
                <tr>
                    <td><input type="file" id="foto" name="file" onchange="validarImagen(this)"></td>
                </tr>
                <tr>
                    <td><input type="submit" id="adicionar_piloto" value="Adicionar"></td>
                </tr>
            </table>
        </form>
        <!--Edit/Delete-->
        <table>
            <% for (Piloto p : pilotos) {%>
            <tr>
                <td class="td-noticias"><%=p.getSiglas()%></td>
                <td class="td-icons"><button class="edit-button"><i class="fas fa-edit"></i></button></td>
                <td class="td-icons">
                    <button class="trash-button">
                        <a href="/web-formula1/PilotosServlet?accion=eliminar&siglas=<%=p.getSiglas()%>">
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
    </body>
</html>