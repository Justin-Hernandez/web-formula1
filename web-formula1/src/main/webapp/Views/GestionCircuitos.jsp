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
        String evento_adicionado = (String) request.getSession().getAttribute("adicionado");
        String evento_existe = (String) request.getSession().getAttribute("existe");
    %>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Circuitos</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
        <script src="../js/app.js"></script>

    </head>
    <body>
        <div class="page-container">
            <!--Header-->
            <div class="topnav" id="myTopnav">
                <a class="logo" href="/web-formula1/Views/AdminPanel.jsp" style="padding: 10px">                   
                    <img class="image" src="../img/f1_logo.png" alt="logo">
                </a>  
                <div class="nav-element">
                    <a href="/web-formula1/NoticiasServlet?accion=listar">Noticias</a>                    
                    <a href="/web-formula1/EquiposServlet?accion=listar">Equipos</a>
                    <a href="/web-formula1/VotacionesServlet?accion=listar">Votaciones</a>
                    <a href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a>
                </div>
                <%if (usuario != null) {%>
                <a href="/web-formula1/Views/AdminPanel.jsp" class="avatar-name">
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

            <div class="content-gp">
                <!--Añadir-->          
                <div>
                    <button class="btn">
                        <a href="/web-formula1/Views/AnadirCircuitos.jsp">Añadir un circuito <i class="fas fa-plus"></i></a>
                    </button>
                </div>

                <%
                if (evento_adicionado != null) {%>
                <p style="color: green; text-align: center; margin-top: 2px; margin-bottom: 2px">El evento fue adicionado al calendario correctamente</p>
                <%
                        session.removeAttribute("adicionado");
                    }
                    if (evento_existe != null) {%>
                <p style="color: red; text-align: center; margin-top: 2px; margin-bottom: 2px">Ya ese evento existe para ese día</p>
                <%
                        session.removeAttribute("existe");
                    }
                %>

                <!--Delete-->
                <div class="container-table-gp">
                    <table class="table-gp">
                        <tr class="table-header tr-gp">
                            <th>Circuito</th>
                            <th>Borrar</th>                            
                            <th colspan="3">Añadir el circuito como evento en el calendario</th>

                        </tr>
                        <% for (Circuito c : circuitos) {%>
                        <tr>
                            <td class="td-noticias"><%=c.getNombre()%></td>
                            <td style="text-align: center" class="td-icons">
                                <button class="trash-button">
                                    <a href="/web-formula1/CircuitosServlet?accion=eliminar&nombre=<%=c.getNombre()%>">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </button>
                            </td>
                        <form action="/web-formula1/CalendarioServlet?accion=adicionar_evento&nombre=<%=c.getNombre()%>" method="post" onsubmit="return validarFechaVacia();">
                            <td>
                                <input type="datetime-local" id="dateEvent" name="dateEvent">
                            </td>
                            <td class="td-icons">
                                <button class="edit-button" type="submit">
                                    <!--<a href="/web-formula1/CalendarioServlet?accion=adicionar_evento&nombre=<%=c.getNombre()%>" >
                                        <i class="fas fa-check-square"></i>
                                    </a>-->
                                    <a href="#">
                                        <i class="fas fa-check-square"></i>
                                    </a>
                                </button>
                            </td>
                        </form>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>


            <!--Footer-->
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