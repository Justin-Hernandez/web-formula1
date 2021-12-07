<%-- 
    Document   : GestionPilotos
    Created on : 17 nov. 2021, 01:25:44
    Author     : Nasr
--%>

<%@page import="Models.User"%>
<%@page import="Models.Piloto"%>
<%@page import="Models.Votacion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Piloto> pilotos = (ArrayList<Piloto>) request.getSession().getAttribute("pilotos");
        User usuario = (User) session.getAttribute("usuario");
        ArrayList<Integer> listaPilotos = (ArrayList<Integer>) request.getSession().getAttribute("listaP");
    %>
    <head>
        <title>Gestion de pilotos</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/app.js"></script>
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
    </head>
    <body>
        <div class="page-container">
            <!--Header-->
            <div class="topnav" id="myTopnav">
                <%if (usuario != null) {%>
                <%if (("Administrador").equals(usuario.getRol())) {%>
                <a href="/web-formula1/Views/AdminPanel.jsp" style="padding: 10px">
                    <img class="image" src="../img/f1_logo.png" alt="logo">
                </a>
                <%} else {%>
                <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" style="padding: 10px">
                    <img class="image" src="../img/f1_logo.png" alt="logo">
                </a>
                <%}%>
                <%} else {%>
                <a href="/web-formula1/Views/Noticias.jsp" style="padding: 10px">
                    <img class="image" src="../img/f1_logo.png" alt="logo">
                </a>
                <%}%> 
                <div class="nav-element">
                    <a href="/web-formula1/NoticiasServlet?accion=listar">Noticias</a>                    
                    <a href="/web-formula1/EquiposServlet?accion=listar">Equipos</a>
                    <a href="/web-formula1/VotacionesServlet?accion=listar">Votaciones</a>
                    <a href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a>
                </div>
                <%if (usuario != null) {%>
                <%if (("Administrador").equals(usuario.getRol())) {%>
                <a href="/web-formula1/Views/AdminPanel.jsp" class="avatar-name">
                    <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
                </a>
                <%} else {%>
                <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="avatar-name">
                    <img class="avatar" src="../img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
                </a>
                <%}%>
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
            <!--Content-->
            <div class="content-gp">
                <!--Añadir-->          
                <div>
                    <button class="btn">
                        <a href="/web-formula1/Views/AnadirPilotos.jsp">Añadir un piloto <i class="fas fa-user-plus"></i></a>
                    </button>
                </div>
                <!--Delete-->
                <div class="container-table-gp">
                    <table class="table-gp">
                        <tr class="table-header tr-gp">
                            <th>
                                Nombre y Apellido
                            </th>
                            <th>
                                N° de Votaciones
                            </th>
                            <th>
                                Borrar
                            </th>
                        </tr>
                        <%
                            for (Piloto p : pilotos) {
                        %>
                        <tr class="tr-gp">
                            <td class="td-gp"><%=p.getNombre()%> <%=p.getApellidos()%></td>
                            <td class="td-gp">
                                <%
                                    int j = 0;
                                    for (Integer i : listaPilotos) {
                                        if (p.getId() == i) {
                                            j++;
                                        }
                                    }
                                %>
                                <%=j%>
                            </td>
                            <td class="td-icons-gp">                                  
                                <% if (j != 0) {%>
                                <i class="fas fa-minus-circle" style="color: gray"></i>
                                <% } else {%> 
                                <a href="/web-formula1/PilotosServlet?accion=eliminar&siglas=<%=p.getSiglas()%>"> 
                                    <i class="fas fa-trash"></i>
                                </a>
                                <% }%> 
                            </td>
                            </td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>

            <!--Footer-->
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