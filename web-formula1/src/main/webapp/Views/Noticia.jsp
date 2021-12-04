<%-- 
    Document   : Noticia
    Created on : Nov 2, 2021, 5:59:16 PM
    Author     : Justin Hernández
--%>

<%@page import="Models.User"%>
<%@page import="Models.News"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        News noticia = (News) request.getSession().getAttribute("noticia");
        User usuario = (User) session.getAttribute("usuario");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>Noticia</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/app.js"></script>
        <style>
            .center {
                text-align: center;
                margin: 0 auto;
                width: 70%;
                overflow-wrap: break-word;
            }
            .p {
                word-wrap: break-word;
                overflow-wrap: break-word;
            }
        </style>
    </head>
    <body>
        <div class="page-container">
            <!--Header-->
            <div class="topnav" id="myTopnav">
                <a class="logo" href="/web-formula1/Views/Noticias.jsp" style="padding: 10px">                   
                    <img class="image" src="../img/f1_logo.png" alt="logo">
                </a>  
                <div class="nav-element">
                    <a href="/web-formula1/NoticiasServlet?accion=listar">Noticias</a>                    
                    <a href="/web-formula1/EquiposServlet?accion=listar">Equipos</a>
                    <a href="/web-formula1/VotacionesServlet?accion=listar">Votaciones</a>
                    <a href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a>
                </div>
                <%if (usuario != null) {%>
                <a href="/web-formula1/Views/ResponsableEquipoPanel.jsp" class="avatar-name">
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
            <div class="noticia-card">
                <section class="cards">
                    <a href="" class="card">
                        <div class="card_image" style='background-image: url("<%=noticia.getImg()%>")'></div>
                        <div class="card_content">
                            <div class="card_title"><%=noticia.getTitulo()%></div>
                            <div class="card_article"><%=noticia.getTexto()%></div>
                        </div>
                    </a>
                </section>
            </div>            
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
