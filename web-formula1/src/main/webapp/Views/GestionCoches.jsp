<%-- 
    Document   : GestionCoches
    Created on : 15 nov. 2021, 15:05:32
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page import="Models.Coche"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Coche> coches = (ArrayList<Coche>) request.getSession().getAttribute("coches");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de coches</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
    </head>
    <body>
        <div class="page-container">
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

            <!--Añadir coches-->
            <form action="/web-formula1/CochesServlet?accion=insertar" method="post" enctype="multipart/form-data" ">
                <table>
                    <tr><td><label>Nombre</label></td></tr>
                    <tr><td><input type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>Código</label></td></tr>
                    <tr><td><input type="text" name="codigo" id="codigo" maxlength="100" width="400px"></td></tr>          
                    <tr><td><label>ERS-Curva Lenta</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="ersCL" id="ersCL" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>ERS-Curva Media</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="ersCM" id="ersCM" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>ERS-Curva Rápida</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="ersCR" id="ersCR" maxlength="100" width="400px"></td></tr>
                    <tr><td><label>Consumo</label></td></tr>
                    <tr><td><input type="number" step="0.1" name="consumo" id="consumo" maxlength="100" width="400px"></td></tr>
                    <tr>

                        <td><input type="submit" id="adicionar_coche" value="Adicionar"></td>
                    </tr>
                </table>
            </form>
            <!--Edit/Delete-->
            <table>
                <% for (Coche c : coches) {%>
                <tr>
                    <td class="td-noticias"><%=c.getNombre()%></td>
                    <td class="td-icons">
                        <button class="trash-button">
                            <a href="/web-formula1/CochesServlet?accion=eliminar&codigo=<%=c.getCodigo()%>">
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