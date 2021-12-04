<%-- 
    Document   : GestionNoticias
    Created on : 30/10/2021, 10:23:38 AM
    Author     : DELL
--%>

<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.News"%>
<%@page import="Models.ModeloDatos"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<News> news = (ArrayList<News>) request.getSession().getAttribute("news");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Noticias</title>
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


        <h1 style="margin-bottom: 20px; margin-left:20px">Crear Noticias</h1>

        <form action="/web-formula1/NoticiasServlet?accion=insertar" method="post" enctype="multipart/form-data" onsubmit="return validarNoticias();">
            <table style="margin-left: 20px">
                <tr><td><label>Título:</label></td></tr>
                <tr><td><input type="text" name="title" id="titulo_noticia" maxlength="100" width="400px"></td></tr>
                <tr><td><label>Artículo</label></td></tr>
                <tr><td><textarea name="textarea" rows="10" cols="79" id="noticia" minlength="500" maxlength="2000"></textarea></td></tr>
                <tr>
                    <td>
                        <input type="file" id="imagen_noticia" name="file" onchange="validarImagen(this)">

                        <input class="btn" type="submit" id="adicionar_noticia" value="Adicionar">
                    </td>
                </tr>

            </table>
        </form>
        <!--Edit/Delete-->

        <h3 style="margin-bottom: 10px; margin-top: 20px; margin-left:20px">Listado de Noticias</h1>
        <table class="table-gp" style="margin-left: 20px">
            <tr class="table-header tr-gp">
                <th>Noticia</th>
                <th>Borrar</th>                            
            </tr>
            <% for (News n : news) {%>
            <tr class="tr-gp">
                <td class="td-noticias"><%=n.getTitulo()%></td>
                <td class="td-icons" style="text-align: center"><a class="trash-button" href="/web-formula1/NoticiasServlet?accion=eliminar&titulo=<%=n.getTitulo()%>"><i class="fas fa-trash"></i></a></td>
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
