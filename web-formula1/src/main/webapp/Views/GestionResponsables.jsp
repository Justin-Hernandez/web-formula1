<%-- 
    Document   : GestionUsuarios
    Created on : Nov 6, 2021, 9:20:59 PM
    Author     : justi
--%>

<%@page import="Models.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        ArrayList<User> conEquipo = (ArrayList<User>) request.getSession().getAttribute("conEquipo");
        ArrayList<User> sinEquipo = (ArrayList<User>) request.getSession().getAttribute("sinEquipo");

        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <title>Gestión de Responsables de Equipo</title>
        <script src="../js/app.js"></script>
        <style>
            .h1 {
                text-align: center; 
                margin-bottom: 10px;
            }

            .th {
                border: 2px solid #dddddd;
            }

            .td {
                text-align:center; 
                padding: 10px 0; 
                border: 2px solid #dddddd;
            }

            .th2 {
                border: 2px solid #ecebeb;
                border-bottom: 2px solid #dddddd;
            }

            .table {
                border-spacing: 25px; 
                border-collapse: collapse;
                width: 60%; 
                margin-left: auto; 
                margin-right: auto;
            }

            .buttonAprobar {
                border: 1px solid #4CAF50;
                width: 70px;
                transition-duration: 250ms;
            }

            .buttonAprobar:hover {
                background-color: #4CAF50;
                color: #ecebeb
            }

            .buttonDenegar {
                border: 1px solid #FF2E2E;
                width: 70px;
                transition-duration: 250ms;
            }

            .buttonDenegar:hover {
                background-color: #FF2E2E;
                color: #ecebeb
            }            
        </style>
    </head>
    <body>
        <div class="page-container">
            <!--Header-->
            <div class="topnav" id="myTopnav">
                <a class="logo" href="/web-formula1/Views/ResponsableEquipoPanel.jsp" style="padding: 10px">                   
                    <img class="image" src="../img/f1_logo.png" alt="logo">
                </a>  
                <div class="nav-element">
                    <a href="/web-formula1/NoticiasServlet?accion=listar">Noticias</a>                    
                    <a href="/web-formula1/EquiposServlet?accion=listar">Equipos</a>
                    <a href="/web-formula1/VotacionesServlet?accion=listar">Votaciones</a>
                    <a href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a>
                </div>
                <%if (usuario != null) {%>
                <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="avatar-name">
                    <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
                </a>

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

            <h1 class="h1">Responsables actuales</h1>
            <div class="content-gp">
                <div class="container-table-gp">
                    <table class="table-gp">
                        <tr class="table-header tr-gp">
                            <th>Nombre</th>
                            <th>Nombre de usuario</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Equipo</th>
                            <th>Eliminar</th>
                        </tr>
                        <% for (User user : conEquipo) {%>
                        <tr class="tr-gp">
                            <td class="td-gp"><%=user.getName()%></td>
                            <td class="td-gp"><%=user.getUser()%></td>
                            <td class="td-gp"><%=user.getEmail()%></td>
                            <td class="td-gp"><%=user.getRol()%></td>
                            <td class="td-gp"><%=user.getEquipo()%></td>
                            <td class="td-icons-gp">
                                <a href="/web-formula1/GestionResponsables?accion=remove;<%=user.getUser()%>">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>
                    
            <hr style="border: 1px solid #dddddd; width: 60%; margin-left: auto; margin-right: auto; margin-top: 50px; margin-bottom: 30px">

            <h1 class="h1">Responsables disponibles</h1>
            <%if (sinEquipo.size() == 0) {%>
            <h3 class="h1">--No hay responsables disponbles--</h3>

            <%} else {%>
            <div class="content-gp">
                <div class="container-table-gp">
                    <table class="table-gp">
                        <tr class="table-header tr-gp">
                            <th>Nombre</th>
                            <th>Nombre de usuario</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Añadir</th>
                        </tr>
                        <% for (User user : sinEquipo) {%>
                        <tr class="tr-gp">
                            <td class="td-gp"><%=user.getName()%></td>
                            <td class="td-gp"><%=user.getUser()%></td>
                            <td class="td-gp"><%=user.getEmail()%></td>
                            <td class="td-gp"><%=user.getRol()%></td>
                            <td class="td-gp">
                                <form action="/web-formula1/GestionResponsables">
                                    <button class="buttonAprobar" type="submit" name="accion" value="add;<%=user.getUser()%>">Añadir</button>
                                </form>
                            </td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>
            <%}%>
            
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
