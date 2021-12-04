<%-- 
    Document   : GestionEquipos
    Created on : 14-nov-2021, 18:20:14
    Author     : laura
--%>


<%@page import="Models.Coche"%>
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
        Equipo equipoUser = (Equipo) request.getSession().getAttribute("equipoUser");
        User usuario = (User) session.getAttribute("usuario");
        ArrayList<Piloto> pilotos = (ArrayList<Piloto>) request.getSession().getAttribute("pilotos");
        ArrayList<Coche> coches = (ArrayList<Coche>) request.getSession().getAttribute("coches");
        ArrayList<User> responsables = (ArrayList<User>) request.getSession().getAttribute("responsables");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión Equipo</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/validaciones.js"></script>
        <style>
            .titulo {
                margin-left: 30px;
            }

            .datos{
                margin: 20px;
                margin-left: 70px;
            }
            .label{
                margin-top: 10px;
                margin-bottom: 5px;
            }
            .input{
                margin-top: 5px;
                margin-bottom: 5px;
            }
            .table{
                margin-left: 30px;
                margin-top: 10px;
                border-spacing: 25px;
                border-collapse: collapse;
                width: 230px;
                margin-right: auto;
            }

            .th {
                border: 2px solid #dddddd;
            }

            .td {
                text-align:center;
                padding: 10px 0;
                border: 2px solid #dddddd;
            }
            .frase{
                margin-left: 30px;
                margin-top: 10px;
            }
            .columnas {
                width: 23%;
                height: 60%;
                float: left;
                margin-top: 10px;
                margin:5px
            }
            .imgRedonda {
                width:150px;
                height:150px;
                border-radius:150px;
                border:3px solid #dddddd;
            }
            .form-equipo-admin{
                margin-left: 30px;
            }
            .detalles{
                margin-left: 50px;
            }
            .form-table-gp
            input[type="text"], input[type="number"] {
                width:200px;
            }
            .container-table-gp{
                height: 500px;
                overflow: auto;
            }


        </style>
    </head>
    <body>
        <div class="page-container">
            <!--Header-->
            <div class="topnav" id="myTopnav">
                <a class="logo" href="/web-formula1/Views/ResponsableEquipoPanel.jsp" style="padding: 10px">                   
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
            <div class="content-gp">
                <%if (equipoUser == null) {%>
                <h1 class="section_title">Añadir Equipo</h1>
                <div class="form-gp">
                    <form action="/web-formula1/EquipoServlet?accion=insertar" method="post" enctype="multipart/form-data" onsubmit="return validarEquipo();">
                        <table class="form-table-gp">
                            <tr><td><label class="label">Nombre</label></td></tr>
                            <tr><td><input class="input" type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                            <tr><td><label class="label">Twitter</label></td></tr>
                            <tr><td><input class="input" type="text" name="twitter" id="twitter" maxlength="50" width="400px" value="@"></td></tr>
                            <tr><td><label class="label">Logo</label></td></tr>
                            <tr>
                                <td><input class="input" type="file" id="imagen_noticia" name="file" onchange="validarImagen(this)"></td>
                            </tr>
                            <tr>
                                <td><input type="submit" id="addequipo" value="Añadir" class="btn"></td>
                            </tr>
                        </table>
                    </form>
                </div>
                <%
                    String mensaje = (String) request.getSession().getAttribute("mensaje");

                    if (mensaje != null) {%>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <%=mensaje%>
                </div>
                <%}%> 
                <%} else {%> 
                <div class="content-gp">
                    <div class="section_title">Detalle Equipo</div>
                    <hr> 
                    <div>
                        <%if (usuario.getRol() != null && !("Administrador").equals(usuario.getRol())) {%>
                        <div class="form-gp">
                            <form >
                                <table class="form-table-gp">
                                    <%if (equipoUser.getLogo() != null && !equipoUser.getLogo().isEmpty()) {%>
                                    <tr><td><label class="label" >Logo</label></td></tr>
                                    <tr><td><img class="imgRedonda" id="imgRedonda" src="<%=equipoUser.getLogo()%>" width="400"></td></tr>
                                            <%}%> 
                                    <tr><td><label class="label">Nombre</label></td></tr>
                                    <tr><td><input class="input" type="text" name="nombre" id="nombre" maxlength="100" width="400px" value="<%=equipoUser.getNombre()%>" disabled></td></tr>
                                    <tr><td><label class="label">Twitter</label></td></tr>
                                    <tr><td><input class="input" type="text" name="twitter" id="twitter" maxlength="50" width="400px" value="<%=equipoUser.getTwitter()%>" disabled></td></tr>
                                </table>
                            </form>
                        </div>
                        <%}%> 

                        <%if (usuario.getRol() != null && ("Administrador").equals(usuario.getRol())) {%>
                        <div class="detalles">
                            <div class="columnas">
                                <form >
                                    <table class="form-table-gp">
                                        <%if (equipoUser.getLogo() != null && !equipoUser.getLogo().isEmpty()) {%>
                                        <tr><td><label class="label" >Logo</label></td></tr>
                                        <tr><td><img class="imgRedonda" id="imgRedonda" src="<%=equipoUser.getLogo()%>" width="400"></td></tr>
                                                <%}%> 
                                        <tr><td><label class="label">Nombre</label></td></tr>
                                        <tr><td><input class="input" type="text" name="nombre" id="nombre" maxlength="100" width="400px" value="<%=equipoUser.getNombre()%>" disabled></td></tr>
                                        <tr><td><label class="label">Twitter</label></td></tr>
                                        <tr><td><input class="input" type="text" name="twitter" id="twitter" maxlength="50" width="400px" value="<%=equipoUser.getTwitter()%>" disabled></td></tr>
                                    </table>
                                </form>
                            </div>
                            <div class="columnas content-gp">
                                <br/>
                                <h3 class="titulo-resp">Responsables del Equipo</h3>
                                <div class="container-table-gp">
                                    <table class="table-gp">
                                        <tr class="table-header tr-gp">
                                            <th class="th">Usuario</th>
                                            <th class="th">Nombre</th>
                                        </tr>
                                        <% for (User r : responsables) {%>
                                        <tr class="tr-gp">
                                            <td class="td-gp"><%=r.getUser()%></td>
                                            <td class="td-gp"><%=r.getName()%></td>
                                        </tr>
                                        <%}%>
                                    </table>
                                </div>
                            </div>
                            <div class="columnas content-gp">
                                <br/>
                                <h3 class="titulo-piloto">Pilotos del Equipo</h3>
                                <%if (pilotos != null && !pilotos.isEmpty()) {%>
                                <div class="container-table-gp">
                                    <table class="table-gp">
                                        <tr class="table-header tr-gp">
                                            <th class="th">Nombre</th>
                                            <th class="th">Apellidos</th>
                                        </tr>
                                        <% for (Piloto p : pilotos) {%>
                                        <tr class="tr-gp">
                                            <td class="td-gp"><%=p.getNombre()%></td>
                                            <td class="td-gp"><%=p.getApellidos()%></td>
                                        </tr>
                                        <%}%>
                                    </table>
                                </div>
                                <%} else {%> 
                                <span class="frase"> Este equipo no tiene níngún piloto.</span>
                                <%}%>
                            </div>
                            <div class="columnas content-gp">
                                <br/>
                                <h3 class="titulo titulo-coche">Coches del Equipo</h3>
                                <%if (coches != null && !coches.isEmpty()) {%>
                                <div class="container-table-gp">
                                    <table class="table-gp">
                                        <tr class="table-header tr-gp">
                                            <th class="th">Nombre</th>
                                            <th class="th">Código</th>
                                        </tr>
                                        <% for (Coche c : coches) {%>
                                        <tr class="tr-gp">
                                            <td class="td-gp"><%=c.getNombre()%></td>
                                            <td class="td-gp"><%=c.getCodigo()%></td>
                                        </tr>
                                        <%}%>
                                    </table>
                                </div>
                                <%} else {%> 
                                <span class="frase"> Este equipo no tiene níngún coche.</span>
                                <%}%>
                                <br/>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%> 
                <%}%> 
            </div>

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
