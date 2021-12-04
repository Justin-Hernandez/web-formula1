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
        ArrayList<Equipo> equipos = (ArrayList<Equipo>) request.getSession().getAttribute("equipos");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Equipos</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
        <style>
            
            .table{
                border-spacing: 25px;
                border-collapse: collapse;
                margin-left: auto;
                margin-right: auto;
                width:400px;
                height: 400px;
            }
            .th{
                border: 2px solid #dddddd;
            }

            .td {
                text-align:center;
                padding: 10px 0;
                border: 2px solid #dddddd;
            }
            .container-table-gp{
                margin-top: 10px;
            }

        </style>
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

            <div class="content-gp">
                <div class="section_title">Equipos</div>
                <hr> 
                <div class="container-table-gp">
                    <table class="table-gp">
                        <tr class="table-header tr-gp">
                            <th class="th">Nombre</th>
                            <th class="th">Info</th>
                            <th class="th">Simulación</th>
                        </tr>
                        <% for (Equipo e : equipos) {%>
                        <tr class="tr-gp">
                            <td class="td-gp"><%=e.getNombre()%></td>
                            <td class="td-icons-gp">
                                <a href="/web-formula1/EquipoServlet?accion=view&id=<%=e.getId()%>">
                                        <i title="Información del Equipo" class="fas fa-info-circle"></i>
                                </a>
                            </td>
                            <td class="td-icons-gp">
                                <a href="/web-formula1/SimulacionesServlet?equipo=<%=e.getNombre()%>">
                                        <i title="Simulaciones" class="fas fa-tools"></i>
                                </a>
                            </td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>
            <footer class="footer-gp">
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
