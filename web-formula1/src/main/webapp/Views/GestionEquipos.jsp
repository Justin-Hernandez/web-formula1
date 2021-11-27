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
            .info-button {
                border-style: none;
                align-items: center;
            }
            .h1 {
                text-align: center; 
                margin-bottom: 10px;
            }
            .td-nombre{
                text-align: center; 
                border: 1px solid black;
                border-collapse: separate;
            }
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
            .td-info{
                text-align: center; 

            }
            .fila{
                margin-top: 5px; 
                margin-bottom:  5px;

            }

            .td {
                text-align:center; 
                padding: 10px 0; 
                border: 2px solid #dddddd;
            }
            .divtable{
                align-content: center;
                width:500px;
                height: 440px;
                overflow: auto;
                margin: 0 auto;
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
        <!--View/Delete-->
        <h1 class="h1">Equipos</h1>
        <div class="divtable">
            <table class="table">
                <tr>
                    <th class="th">Nombre</th>
                    <th class="th"></th>
                </tr>
                <% for (Equipo e : equipos) {%>
                <tr class="fila">
                    <td class="td-nombre td"><%=e.getNombre()%></td>
                    <td class="td-info td"><a href="/web-formula1/EquipoServlet?accion=view&id=<%=e.getId()%>"><button class="info-button"><i class="fas fa-info-circle"></i></button></td>
                    <td class="td-nombte td"><a href="/web-formula1/">simulación</a></td> 
                </tr>
                <%}%>
            </table>
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
