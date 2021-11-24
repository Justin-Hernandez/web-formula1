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
            .info-button {
                border-style: none;
                background-color: rgb(236, 235, 235);
            }
            .titulo {
                margin-left: 30px;
            }
            .datos{
                margin: 20px;
                margin-left: 40px;
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
            .divtable{
                align-content: center;
                width:300px;
                height: 300px;
                overflow: auto;
            }
            .columnas {
                width: 25%;
                height: 60%;
                float: left;
            }


        </style>
    </head>
    <body>
        <header class="header">
            <nav class="nav">
                <img class="image" src="../img/f1_logo.png">
                <ul class="nav-menu">
                    <li class="nav-menu-item"><a href="/web-formula1/NoticiasServlet?accion=listar" class="nav-menu-link nav-link">Noticias</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Equipos</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Votaciones</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link">Calendario</a></li>
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
        <div>
            <%if (equipoUser == null) {%>
            <h1 class="titulo">Añadir Equipo</h1>
            <form class="datos" action="/web-formula1/EquipoServlet?accion=insertar" method="post" enctype="multipart/form-data" onsubmit="return validarEquipo();">
                <table>
                    <tr><td><label class="label">Nombre</label></td></tr>
                    <tr><td><input class="input" type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
                    <tr><td><label class="label">Twitter</label></td></tr>
                    <tr><td><input class="input" type="text" name="twitter" id="twitter" maxlength="50" width="400px"></td></tr>
                    <tr><td><label class="label">Logo</label></td></tr>
                    <tr>
                        <td><input class="input" type="file" id="imagen_noticia" name="file" onchange="validarImagen(this)"></td>
                    </tr>
                    <tr>
                        <td><input class="label" type="submit" id="add_equipo" value="Añadir"></td>
                    </tr>
                </table>
            </form>
            <%
                String mensaje = (String) request.getSession().getAttribute("mensaje");

                if (mensaje != null) {%>
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <%=mensaje%>
            </div>
            <%}%> 
            <%} else {%> 
            <div>
                <h1 class="titulo">Detalles Equipo</h1>
                <div>
                    <div class="columnas">
                        <form class="datos">
                            <table>
                                <tr><td><label class="label">Nombre</label></td></tr>
                                <tr><td><input class="input" type="text" name="nombre" id="nombre" maxlength="100" width="400px" value="<%=equipoUser.getNombre()%>" disabled></td></tr>
                                <tr><td><label class="label">Twitter</label></td></tr>
                                <tr><td><input class="input" type="text" name="twitter" id="twitter" maxlength="50" width="400px" value="<%=equipoUser.getTwitter()%>" disabled ></td></tr>
                                        <%if (equipoUser.getLogo() != null && !equipoUser.getLogo().isEmpty()) {%>
                                <tr><td><label class="label" >Logo</label></td></tr>
                                <tr><td><img class="imageEquipo" src="<%=equipoUser.getLogo()%>" width="400"></td></tr>
                                        <%}%> 
                            </table>
                        </form>
                    </div>

                    <%if (usuario.getRol() != null && ("Administrador").equals(usuario.getRol())) {%>
                    <div class="columnas">
                        <br/>
                        <h3 class="titulo">Responsables del Equipo</h3>
                        <div class="divtable">
                            <table class="table">
                                <tr>
                                    <th class="th">Usuario</th>
                                    <th class="th">Nombre</th>
                                </tr>
                                <% for (User r : responsables) {%>
                                <tr class="fila">
                                    <td class="td"><%=r.getUser()%></td>
                                    <td class="td"><%=r.getName()%></td>
                                </tr>
                                <%}%>
                            </table>
                        </div>
                    </div>
                    <div class="columnas">
                        <br/>
                        <h3 class="titulo">Pilotos del Equipo</h3>
                        <%if (pilotos != null && !pilotos.isEmpty()) {%>
                        <div class="divtable">
                            <table class="table">
                                <tr>
                                    <th class="th">Nombre</th>
                                    <th class="th">Apellidos</th>
                                </tr>
                                <% for (Piloto p : pilotos) {%>
                                <tr class="fila">
                                    <td class="td"><%=p.getNombre()%></td>
                                    <td class="td"><%=p.getApellidos()%></td>
                                </tr>
                                <%}%>
                            </table>
                        </div>
                        <%} else {%> 
                        <span class="frase"> Este equipo no tiene níngún piloto.</span>
                        <%}%>
                    </div>
                    <div class="columnas">
                        <br/>
                        <h3 class="titulo">Coches del Equipo</h3>
                        <%if (coches != null && !coches.isEmpty()) {%>
                        <div class="divtable">
                            <table class="table">
                                <tr>
                                    <th class="th">Nombre</th>
                                    <th class="th">Código</th>
                                </tr>
                                <% for (Coche c : coches) {%>
                                <tr class="fila">
                                    <td class="td"><%=c.getNombre()%></td>
                                    <td class="td"><%=c.getCodigo()%></td>
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
    </body>

</html>
