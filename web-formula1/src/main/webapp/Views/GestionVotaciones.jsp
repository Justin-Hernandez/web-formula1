<%-- 
    Document   : GestionVotaciones
    Created on : 23/11/2021, 12:29:39 PM
    Author     : DELL
--%>

<%@page import="Models.Votacion"%>
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
        ArrayList<Votacion> votaciones = (ArrayList<Votacion>) request.getSession().getAttribute("votaciones");

    %>
    <head>
        <%            String path = request.getContextPath();
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Circuitos</title>

        <link rel="stylesheet" href="<%= path%>/css/custom.css">
        <link rel="stylesheet" href="<%= path%>/css/all.min.css">
        <script src="<%= path%>/js/validaciones.js"></script>
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

            <!--Crear Votaciones-->
            <h1 style="margin-bottom: 20px; margin-left:20px">Crear Votaciones</h1>



            <form action="/web-formula1/VotacionesServlet?accion=crear_votacion" method="POST" onsubmit="return validarCrearVotacion();">
                <table style="margin-bottom: 20px; margin-left: 20px">
                    <tr><td><label>Título:</label></td></tr>
                    <tr><td><input style="width: 236px" type="text" id="titulo" name="titulo" maxlength="100"></td></tr>
                    <tr><td><label>Descripción:</label></td></tr>
                    <tr><td><textarea name="descripcion" rows="5" cols="29" id="descripcion" maxlength="500"></textarea></td></tr>
                    <tr><td><label>Fecha límite</label></td></tr>
                    <tr><td><input type="datetime-local" id="date" name="fecha"></td></tr>
                    <tr><td>
                            <input class="btn" style="float: right; margin-top: 10px" 
                                   type="submit" id="crear_votacion" value="Crear votación">
                        </td>
                    </tr>
                </table>

                <div style="float: left; margin-left: 20px; width: 50%">
                    <table class="table-gp">
                        <tr>
                            <td colspan="3"><h3>Listado de pilotos disponibles para una votación:</h3></td>
                        </tr>                    
                        <tr class="table-header tr-gp">
                            <td style="text-align: center"><strong>Siglas</strong></td>
                            <td style="text-align: center"><strong>Nombre y apellidos</strong></td>
                            <td style="text-align: center"><strong>País</strong></td>
                            <td style="text-align: center"><strong>Seleccione</strong></td>
                        </tr>
                        <% for (Piloto p : pilotos) {%>
                        <tr class="tr-gp">           

                            <td class="td-noticias" style="text-align: center"><label><%=p.getSiglas()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label><%=p.getNombre() + " " + p.getApellidos()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label><%=p.getPais()%></label></td>                        

                            <td class="td-noticias" style="text-align: center">
                                <input type="checkbox" name="siglas" value="<%=p.getSiglas()%>">
                            </td>
                        </tr>
                        <%}%>                
                    </table>
                </div>
                <div style="float: left; margin-left: 50px; width: 40%">
                    <table class="table-gp">
                        <tr>
                            <td colspan="3"><h3>Listado de votaciones activas en el sistema:</h3></td>                  
                        </tr>                    
                        <tr class="table-header tr-gp">
                            <td style="text-align: center"><strong>Título</strong></td>
                            <td style="text-align: center"><strong>Descripción</strong></td>
                            <td style="text-align: center"><strong>Fecha Límite</strong></td>
                            <td style="text-align: center"><strong>Borrar</strong></td>
                        </tr>
                        <% for (Votacion v : votaciones) {%>
                        <tr class="tr-gp">                            
                            <td class="td-noticias" style="text-align: center"><label><%=v.getTitulo()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label><%=v.getDescripcion()%></label></td>
                            <td class="td-noticias" style="text-align: center"><label><%=v.getFechaLimite()%></label></td>                        
                            <td style="text-align: center" class="td-noticias" class="td-icons">
                                <a class="trash-button" href="/web-formula1/VotacionesServlet?accion=eliminar&titulo=<%=v.getTitulo()%>">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <%}%>                
                    </table>
                </div>
            </form>

                    <div class="clear"></div>

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