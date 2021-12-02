<%-- 
    Document   : Calendario
    Created on : 15/11/2021, 03:14:54 PM
    Author     : DELL
--%>

<%@page import="Models.User"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="Models.Evento"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%
            String path = request.getContextPath();
            LinkedList<Evento> lista_eventos = (LinkedList<Evento>) request.getAttribute("lista_eventos");
            User usuario = (User) session.getAttribute("usuario");
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>Noticias</title>
        <link rel="stylesheet" href="<%= path%>/css/custom.css">
        <link rel="stylesheet" href="<%= path%>/css/all.min.css">
        <link rel="stylesheet" href="<%= path%>/css/theme.css"/>
        <script src="<%= path%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%= path%>/js/bootstrap.min.js"></script>
        <script src="<%= path%>/js/validaciones.js"></script>

<!--<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">-->
    </head>
    <body>
        <div>
            <nav class="nav">
                <div class="logo">
                    <a href="/web-formula1/Noticias.jsp">
                        <img class="image" src="<%= path%>/img/f1_logo.png">
                    </a>
                </div>
                <ul class="nav-menu">
                    <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/EquiposServlet?accion=listar" class="nav-menu-link nav-link">Equipos</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/VotacionesServlet?accion=listar" class="nav-menu-link nav-link">Votaciones</a></li>
                    <li class="nav-menu-item"><a href="/web-formula1/CalendarioServlet?accion=listar_eventos" class="nav-menu-link nav-link">Calendario</a></li>
                </ul> 
                <%
                    if (usuario != null) {%>
                <div class="admin">
                    <img class="avatar" src="<%= path%>/img/Diez.png" alt="Avatar">
                    <a href="AdminPanel.jsp" class="nav-menu-item"><%=usuario.getName()%></a>
                </div>
                <a class="down" href="Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
                    <%if (request.getParameter("logout") != null) {
                            session.removeAttribute("name");
                            response.sendRedirect("Noticias.jsp");
                        }
                    } else {%>

                <ul class="nav-menu">
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="<%= path%>/Views/InicioSesion.jsp">Iniciar sesión</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="<%= path%>/Views/CrearCuenta.jsp">Crear cuenta</a></li>    
                </ul> 
                <%}%>     
            </nav>
            
            <div  id="calendar"></div>

            <footer class="footer">
                <div class="footer_div">
                    <div>
                        Encuentra nuestro proyecto en <a href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i><br>
                    </div>
                    <p>2021 &copy</p>
                </div>
            </footer>
        </div>
        <script type="text/javascript" src="<%= path%>/js/caleandar.js"></script>
        <script type="text/javascript">
            <%
            Calendar cal = Calendar.getInstance();%>
            var events = [];
            <%
            for (Evento evento : lista_eventos) {
                cal.setTime(new Date(evento.getFechaEvento().getTime()));
                int year = cal.get(Calendar.YEAR);
                int month = cal.get(Calendar.MONTH);
                int day = cal.get(Calendar.DAY_OF_MONTH);

            %>
                var event = {'Date': new Date(<%=year%>, <%=month%>, <%=day%>), 'Title': '<%=evento.getNombre()%>'};
                events.unshift(event);

            <%}%>
            var settings = {};
            var element = document.getElementById('calendar');
            caleandar(element, events, settings);
        </script>
    </body>
</html>
