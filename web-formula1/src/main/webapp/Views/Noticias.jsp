<%-- 
    Document   : index
    Created on : Oct 28, 2021, 6:37:14 PM
    Author     : Justin Hernández
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.News"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.ModeloDatos"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        ArrayList<News> news = (ArrayList<News>) request.getSession().getAttribute("news");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>Noticias</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
    </head>
    <body>   
        <div class="page-container">
            <header>
                <nav class="nav">
                    <div class="logo">
                        <a href="/web-formula1/Views/Noticias.jsp"> 
                            <img class="image" src="../img/f1_logo.png">
                        </a>
                    </div>
                    <ul class="nav-menu">
                        <li class="nav-menu-item active" ><a class="nav-menu-link nav-link">Noticias</a></li>
                        <li class="nav-menu-item"><a class="nav-menu-link nav-link">Equipos</a></li>
                        <li class="nav-menu-item"><a class="nav-menu-link nav-link">Votaciones</a></li>
                        <li class="nav-menu-item"><a class="nav-menu-link nav-link" href="/web-formula1/CalendarioServlet?accion=listar_eventos">Calendario</a></li>
                    </ul>  
                    <%
                    if (session.getAttribute("name") != null) {%>
                    <div class="admin">
                        <img class="avatar" src="../img/Diez.png" alt="Avatar">
                        <% String nombre = (String) session.getAttribute("name");%>
                        <a href="AdminPanel.jsp" class="nav-menu-item"><%=nombre%></a>
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

            <!--News Section-->
            <div class="section_title">Noticias</div>
            <hr> 
            <section class="cards">
                <% for (News n : news) {%>
                <a href="<%=n.getPermalink()%>" target="_blank" class="card">
                    <div class="card_image" style='background-image: url("../img/img2.jpg")'></div>
                    <div class="card_content">
                        <div class="card_title"><%=n.getTitulo()%></div>
                        <div class="card_article"><%=n.getTexto()%></div>
                    </div>
                </a>
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

