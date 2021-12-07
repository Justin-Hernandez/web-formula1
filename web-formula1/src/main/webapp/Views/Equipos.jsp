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
        HashMap<Integer, List<Piloto>> pilotos = (HashMap<Integer, List<Piloto>>) request.getSession().getAttribute("pilotos");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Equipos</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
        <style>
            .card_equipo{
                width:300px;
                height: 300px;
                background-color: #fff;
                border-radius: 20px;
                overflow: auto;

            }
            .imgRedonda {
                width:150px;
                height:150px;
                border-radius:150px;

            }
            .imgtop{
                border-top-right-radius: 20px;
                border-top-left-radius: 20px;
                height: 130px;
                width: 300px;
            }

            .pilotos5{
                text-align: center;
                margin-top: 10px;
            }
            .nopilotos{
                text-align: center;
                margin-top: 50px;
            }
            .card_equipo_content{
                margin: 30px;
                text-align: center;
            }

            .top{
                margin-top: 10px
            }


        </style>
    </head>
    <body>
        <div class="page-container">
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
            <div class="section_title">Equipos</div>
            <hr> 
            <section class="cards">
                <% for (Equipo e : equipos) {%>
                <div class="card_equipo">
                    <div class="card_equipo_content">
                        <%if (e.getLogo() != null && !e.getLogo().isEmpty()) {%>
                        <img class="imgRedonda" src="<%=e.getLogo()%>" width="400">
                        <%}%> 
                        <body>
                            <h4><%=e.getNombre()%></h4>
                            <%if (e.getTwitter() != null && !e.getTwitter().isEmpty()) {%>
                            <h6 class="top"><%=e.getTwitter()%></h6>
                            <%}%> 
                            <% if (pilotos.get(e.getId()) != null && pilotos.get(e.getId()).size() > 0) {%>
                            <div class="pilotos5">
                                <b>Pilotos:</b><br>
                                <div class="pilotos5_content">
                                    <% for (Piloto p : pilotos.get(e.getId())) {%>
                                    <span>&#8226;&nbsp;<%=p.getNombre()%>&nbsp;<%=p.getApellidos()%></span><br/>
                                    <%}%>
                                </div>
                            </div>
                            <%} else {%>
                            <div class="nopilotos">
                                <span class="nopilotos_text">Este equipo no tiene ningún piloto</span>
                                <br>
                            </div>
                            <%}%>
                        </body>
                    </div>
                </div>
                <%}%>
            </section>

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
