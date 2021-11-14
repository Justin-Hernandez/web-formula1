<%-- 
    Document   : Noticia
    Created on : Nov 2, 2021, 5:59:16 PM
    Author     : Justin Hernández
--%>

<%@page import="Models.News"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        News noticia = (News) request.getSession().getAttribute("noticia");
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
            <a href="" class="card">
                <div class="card_image" style="background-image: url('../img/img2.jpg')"></div>
                <div class="card_content">
                    <div class="card_title"><%=noticia.getTitulo()%></div>
                    <div class="card_article"><%=noticia.getTexto()%></div>
                </div>
            </a>

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
