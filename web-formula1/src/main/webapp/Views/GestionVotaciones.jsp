<%-- 
    Document   : GestionVotaciones
    Created on : 23/11/2021, 12:29:39 PM
    Author     : DELL
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Models.Piloto"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.ModeloDatos"%>
<!DOCTYPE html>
<html>
    <%

        User usuario = (User) session.getAttribute("usuario");
        ArrayList<Piloto> pilotos = (ArrayList<Piloto>) request.getSession().getAttribute("pilotos");
    %>
    <head>
        <%
            String path = request.getContextPath();
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Circuitos</title>

        <link rel="stylesheet" href="<%= path%>/css/custom.css">
        <link rel="stylesheet" href="<%= path%>/css/all.min.css">
        <script src="<%= path%>/js/validaciones.js"></script>

    </head>
    <body>
        <div class="page-container">
            <header>
                <nav class="nav">
                    <div class="logo">
                        <a href="<%= path%>/Views/Noticias.jsp"> 
                            <img class="image" src="<%= path%>/img/f1_logo.png">
                        </a>
                    </div>
                    <ul class="nav-menu">
                        <li class="nav-menu-item active" ><a class="nav-menu-link nav-link">Noticias</a></li>
                        <li class="nav-menu-item"><a class="nav-menu-link nav-link">Equipos</a></li>
                        <li class="nav-menu-item"><a class="nav-menu-link nav-link">Votaciones</a></li>
                        <li class="nav-menu-item"><a class="nav-menu-link nav-link" href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a></li>
                    </ul>  

                    <%
                        if (usuario != null) {%>
                    <div class="admin">
                        <img class="avatar" src="<%= path%>/img/Diez.png" alt="Avatar">
                        <a href="<%= path%>/Views/AdminPanel.jsp" class="nav-menu-item"><%=usuario.getName()%></a>
                    </div>
                    <a class="down" href="Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
                        <%if (request.getParameter("logout") != null) {
                                session.removeAttribute("name");
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

            <!--Crear Votaciones-->
            <h1 style="margin-bottom: 20px; margin-left:20px">Crear Votaciones</h1>



            <form action="/web-formula1/VotacionesServlet?accion=crear_votacion" method="POST">
                <table style="margin-bottom: 20px; margin-left: 20px">
                    <tr><td><label>Título:</label></td></tr>
                    <tr><td><input style="width: 236px" type="text" maxlength="100"></td></tr>
                    <tr><td><label>Descripción:</label></td></tr>
                    <tr><td><textarea name="textarea" rows="5" cols="29" id="descripcion" maxlength="500"></textarea></td></tr>
                    <tr><td><label>Fecha límite</label></td></tr>
                    <tr><td><input type="datetime-local" id="date" name="date"></td></tr>
                </table>

                <div style="float: left; margin-left: 20px; width: 50%">
                    <table>
                        <tr>
                            <td colspan="3"><strong><label style="color: red">Seleccione los pilotos a valorar para esta votación:</label></strong></td>
                            <td style="text-align: center"><input style="color: blue; border-color: blue" type="submit" id="crear_votacion" value="Crear votación"></td>                    
                        </tr>                    
                        <tr>
                            <td style="text-align: center"><strong>Siglas</strong></td>
                            <td style="text-align: center"><strong>Nombre y apellidos</strong></td>
                            <td style="text-align: center"><strong>País</strong></td>
                            <td style="text-align: center"><strong>Seleccione</strong></td>
                        </tr>
                        <% for (Piloto p : pilotos) {%>
                        <tr>                            
                            <td class="td-noticias" style="text-align: center"><label for="<%=p.getSiglas()%>"><%=p.getSiglas()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label for="<%=p.getSiglas()%>"><%=p.getNombre() + " " + p.getApellidos()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label for="<%=p.getSiglas()%>"><%=p.getPais()%></label></td>                        
                            <td class="td-noticias" style="text-align: center">
                                <input type="checkbox" id="<%=p.getSiglas()%>">
                            </td>
                        </tr>
                        <%}%>                
                    </table>
                </div>
                <div style="float: left; margin-left: 60px; width: 30%">
                    <table>
                        <tr>
                            <td colspan="3"><strong><label style="color: red">Listado de votaciones activas en el sistema:</label></strong></td>                  
                        </tr>                    
                        <tr>
                            <td style="text-align: center"><strong>Título</strong></td>
                            <td style="text-align: center"><strong>Descripción</strong></td>
                            <td style="text-align: center"><strong>Fecha Límite</strong></td>
                        </tr>
                        <% for (Piloto p : pilotos) {%>
                        <tr>                            
                            <td class="td-noticias" style="text-align: center"><label for="<%=p.getSiglas()%>"><%=p.getSiglas()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label for="<%=p.getSiglas()%>"><%=p.getNombre() + " " + p.getApellidos()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label for="<%=p.getSiglas()%>"><%=p.getPais()%></label></td>                        
                            <td class="td-noticias" class="td-icons"><button class="trash-button"><a href="#"><i class="fas fa-trash"></i></a></button></td>
                        </tr>
                        <%}%>                
                    </table>
                </div>
            </form>




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