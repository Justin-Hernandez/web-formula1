<%-- 
    Document   : GestionEquipos
    Created on : 14-nov-2021, 18:20:14
    Author     : laura
--%>


<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="Models.Piloto"%>
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
        HashMap <Integer, List<Piloto>> pilotos = (HashMap <Integer, List<Piloto>>) request.getSession().getAttribute("pilotos");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Equipos</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
        <style>
            .divtable{
                align-content: center;
                width:500px;
                height: 440px;
                overflow: auto;
                margin: 0 auto;
            }
            .table{
                border-spacing: 25px; 
                border-collapse: collapse;
                margin-left: auto; 
                margin-right: auto;
                width:400px;
                height: 400px;
            }
            .h1 {
                text-align: center; 
                margin-bottom: 10px;
            }
            .foto{
                margin-top: 5px;
                margin-bottom: 5px;
            }
            .detalle{
                margin:6px;
                border-spacing: 25px; 
            }
            .divequipo{
                width:400px;
                height: auto;
                background-color: #fff;
                
            }
            .cards{
                display:flex;
                flex-wrap:wrap;
                justify-content:center;
                gap:1.5rem;
                padding:1rem;
                margin: 0;
                
            }
            .page{
                align-content: center;
                height: 400px;
                overflow: auto;
            }
        </style>
    </head>
    <body>
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
        <!--View/Delete-->
        <div class="page">
            <h1 class="h1">Equipos</h1>
        <section class="cards">
        <% for (Equipo e : equipos) {%>
            <div class="divequipo">
                <%if (e.getLogo() != null && !e.getLogo().isEmpty()) {%>
                <div style="float: left; margin: 10px; heigth: 50px; width: 50px" class="foto">
                    <img class="imageEquipo" src="<%=e.getLogo()%>" width="150px">
                </div>
                <div style="float: right; margin-left: 20px; width: 50%"class="detalle">
                    <body>
                        <h4><%=e.getNombre()%></h4>
                        <br>
                        <% if (pilotos.get(e.getId()) != null && pilotos.get(e.getId()).size() > 0) {%>
                        Pilotos:<br>
                        <% for (Piloto p : pilotos.get(e.getId())) {%>
                        <span>&#8226;&nbsp;<%=p.getNombre()%>&nbsp;<%=p.getApellidos()%></span><br/>
                        <%}%>
                        <%} else {%>
                        Este equipo no tiene ningún piloto
                        <br>
                        <%}%>
                    </body>
                </div>
                <%}else{%> 
                <div class="detalle">
                    <body>
                        <h4><%=e.getNombre()%></h4>
                        <br>
                        <% if (pilotos.get(e.getId()) != null && pilotos.get(e.getId()).size() > 0) {%>
                        <b>Pilotos:</b><br><br>
                        <% for (Piloto p : pilotos.get(e.getId())) {%>
                        <%=p.getNombre()%>&nbsp;<%=p.getApellidos()%><br/>
                        <%}%>
                        <%} else {%>
                        Este equipo no tiene ningún piloto
                        <br>
                        <%}%>
                    </body>
                </div>
                <%}%> 
                
            </div>
                    <%}%>
        </section>
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
