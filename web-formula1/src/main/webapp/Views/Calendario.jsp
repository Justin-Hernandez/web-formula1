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
        <title>Calendario</title>
        <link rel="stylesheet" href="<%= path%>/css/custom.css">
        <link rel="stylesheet" href="<%= path%>/css/all.min.css">
        <link rel="stylesheet" href="<%= path%>/css/theme.css"/>
        <script src="<%= path%>/js/jquery-3.6.0.min.js"></script>
        <script src="<%= path%>/js/bootstrap.min.js"></script>
        <script src="<%= path%>/js/validaciones.js"></script>
        <script src="<%= path%>/js/app.js"></script>

<!--<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">-->
    </head>
    <body>

        <!--Header-->
        <div class="topnav" id="myTopnav">
            <%if (usuario != null) {%>
            <%if (("Administrador").equals(usuario.getRol())) {%>
            <a href="/web-formula1/Views/AdminPanel.jsp" style="padding: 10px">
                <img class="image" src="<%= path%>/img/f1_logo.png" alt="logo">
            </a>
            <%} else {%>
            <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" style="padding: 10px">
                <img class="image" src="<%= path%>/img/f1_logo.png" alt="logo">
            </a>
            <%}%>
            <%} else {%>
            <a href="/web-formula1/Views/Noticias.jsp" style="padding: 10px">
                <img class="image" src="<%= path%>/img/f1_logo.png" alt="logo">
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
                <img class="avatar" src="<%= path%>/img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
            </a>
            <%} else {%>
            <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="avatar-name">
                <img class="avatar" src="<%= path%>/img/Diez.png" alt="Avatar"> <%=usuario.getName()%>
            </a>
            <%}%>
            <a class="down" href="/web-formula1/Views/Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
                <%if (request.getParameter("logout") != null) {
                        session.removeAttribute("usuario");
                        response.sendRedirect("Noticias.jsp");
                    }
                } else {%>

            <ul class="nav-menu">
                <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="/web-formula1/Views/InicioSesion.jsp">Iniciar sesi??n</a></li>
                <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="/web-formula1/Views/CrearCuenta.jsp">Crear cuenta</a></li>    
            </ul> 
            <%}%>
            <!--responsive-->
            <a href="javascript:void(0);" class="icon" onclick="myFunction()">
                <i class="fa fa-bars"></i>
            </a>
        </div>

        <div  id="calendar"></div>

        <footer class="footer">
            <div class="footer_div">
                <div>
                    Encuentra nuestro proyecto en <a href="https://github.com/Justin-Hernandez/web-formula1" target="_blank"><strong>Github </strong></a><i class="fab fa-github-square"></i><br>
                </div>
                <p>2021 &copy</p>
            </div>
        </footer>

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
