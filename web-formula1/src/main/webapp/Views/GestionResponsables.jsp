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

        <h1 class="h1">Responsables actuales</h1>
        <table class="table">
            <tr>
                <th class="th">Nombre</th>
                <th class="th">Nombre de usuario</th>
                <th class="th">Correo</th>
                <th class="th">Rol</th>
                <th class="th">Equipo</th>
                <th class="th2"></th>
            </tr>
            <% for (User user : conEquipo) {%>
            <tr>
                <td class="td"><%=user.getName()%></td>
                <td class="td"><%=user.getUser()%></td>
                <td class="td"><%=user.getEmail()%></td>
                <td class="td"><%=user.getRol()%></td>
                <td class="td"><%=user.getEquipo()%></td>
                <td class="td">
                    <form action="/web-formula1/GestionResponsables">
                        <button class="buttonDenegar" type="submit" name="accion" value="remove;<%=user.getUser()%>">Eliminar</button>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>

        <hr style="border: 1px solid #dddddd; width: 60%; margin-left: auto; margin-right: auto; margin-top: 50px; margin-bottom: 30px">

        <h1 class="h1">Responsables disponibles</h1>
        <table class="table">
            <tr>
                <th class="th">Nombre</th>
                <th class="th">Nombre de usuario</th>
                <th class="th">Correo</th>
                <th class="th">Rol</th>
                <th class="th2"></th>
            </tr>
            <% for (User user : sinEquipo) {%>
            <tr>
                <td class="td"><%=user.getName()%></td>
                <td class="td"><%=user.getUser()%></td>
                <td class="td"><%=user.getEmail()%></td>
                <td class="td"><%=user.getRol()%></td>
                <td class="td">
                    <form action="/web-formula1/GestionResponsables">
                        <button class="buttonAprobar" type="submit" name="accion" value="add;<%=user.getUser()%>">Añadir</button>
                    </form>
                </td>
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
