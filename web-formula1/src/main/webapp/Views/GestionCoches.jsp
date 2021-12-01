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
            <!--Header-->
            <header class="header">
                <nav class="nav">
                    <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp">                   
                        <img class="image" src="../img/f1_logo.png" alt="logo">
                    </a>  
                    <ul class="nav-menu">
                        <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                        <li class="nav-menu-item"><a href="/web-formula1/EquiposServlet?accion=listar" class="nav-menu-link nav-link">Equipos</a></li>
                        <li class="nav-menu-item"><a href="/web-formula1/VotacionesServlet?accion=listar" class="nav-menu-link nav-link">Votaciones</a></li>
                        <li class="nav-menu-item"><a href="/web-formula1/CalendarioServlet?accion=listar_eventos" class="nav-menu-link nav-link">Calendario</a></li>
                    </ul>
                    <di class="admin">
                        <%if (usuario != null) {%>
                        <img class="avatar" src="../img/Diez.png" alt="Avatar">
                        <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="nav-menu-item"><%=usuario.getName()%></a>
                    </di>
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
                </nav>
            </header>
            <div class="content-gp">
                <!--Añadir-->          
                <div>
                    <button class="btn">
                        <a href="/web-formula1/Views/AnadirCoches.jsp">Añadir un coche <i class="fas fa-plus"></i></a>
                    </button>
                </div>
                <!--Edit/Delete-->
                <div class="container-table-gp">
                    <table class="table-gp">
                        <tr class="table-header tr-gp">
                            <th>
                                Nombre
                            </th>
                            <th>
                                Borrar
                            </th>
                        </tr>
                        <% for (Coche c : coches) {%>
                        <tr class="tr-gp">
                            <td class="td-gp"><%=c.getNombre()%></td>
                            <td class="td-icons-gp">
                                
                                    <a href="/web-formula1/CochesServlet?accion=eliminar&codigo=<%=c.getCodigo()%>">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                
                            </td>
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