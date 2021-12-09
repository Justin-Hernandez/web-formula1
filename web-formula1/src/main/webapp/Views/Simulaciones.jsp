<%-- 
    Document   : AdminPanel
    Created on : 28/10/2021, 08:16:07 PM
    Author     : DELL
--%>

<%@page import="Models.Equipo"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Models.Circuito"%>
<%@page import="Models.Coche"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        ArrayList<Coche> listaCoches = (ArrayList<Coche>) request.getSession().getAttribute("listaCoches");
        ArrayList<Circuito> listaCircuitos = (ArrayList<Circuito>) request.getSession().getAttribute("listaCircuitos");

        String consumoVuelta = (String) request.getSession().getAttribute("consumoVuelta");
        String consumoTotal = (String) request.getSession().getAttribute("consumoTotal");

        String gananciaVuelta = (String) request.getSession().getAttribute("gananciaVuelta");
        String vueltasNecesariasErs = (String) request.getSession().getAttribute("vueltasNecesariasErs");
        String tipoConduccion = (String) request.getSession().getAttribute("tipoConduccion");

        Coche cocheCombustible = (Coche) request.getSession().getAttribute("cocheCombustible");
        Circuito circuitoCombustible = (Circuito) request.getSession().getAttribute("circuitoCombustible");

        Coche cocheErs = (Coche) request.getSession().getAttribute("cocheErs");
        Circuito circuitoErs = (Circuito) request.getSession().getAttribute("circuitoErs");

        User usuario = (User) request.getSession().getAttribute("usuario");

        String equipo = (String) request.getSession().getAttribute("equipo");
    %>    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel de Administración</title>
        <link rel="stylesheet" href="../css/custom.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <style>
            .h1 {
                text-align: center; 
                margin-bottom: 10px;
            }

            input, label {
                display:block;
            }

            .form {
                display:flex;
                justify-content: center;
            }
        </style>
    </head>
    <body>
        <!--Header-->
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

        <h1 class="h1">Gasto de combustible</h1>
        <br>
        <div class="form">
            <form action="/web-formula1/SimulacionesServlet">

                <%if (equipo != null) {%>
                <input type="hidden" name="equipo" value=<%=equipo%> />
                <%}%>

                <div style="float:left;margin-right:40px; margin-left: 10px">
                    <label for="coche" style="font-weight: bold">Coche</label>
                    <select id="coche" name="cocheCombustible" style="font-size: 1em; background-color: #ecebeb; width: 150px" required>
                        <%for (Coche c : listaCoches) {%>
                        <option value=<%=c.getId()%>><%=c.getNombre()%></option>
                        <%}%>
                    </select>
                </div>

                <div style="float:left;margin-right:10px;">
                    <label for="circuito" style="font-weight: bold">Circuito</label>
                    <select id="circuito" name="circuitoCombustible" style="font-size: 1em; background-color: #ecebeb; width: 150px" required>
                        <%for (Circuito c : listaCircuitos) {%>
                        <option value=<%=c.getId()%>><%=c.getNombre()%></option>
                        <%}%>
                    </select>
                </div>
                <br><br><br>

                <div style="text-align: center;">
                    <button class="btn" type="submit" style="font-size: 1em;">Calcular</button>
                </div>
            </form>
        </div>

        <br>
        <% if (consumoVuelta != null && consumoTotal != null && cocheCombustible != null && circuitoCombustible != null) {%>
        <h3 class="h1"><%="Coche '" + cocheCombustible.getNombre() + "' en el circuito '" + circuitoCombustible.getNombre() + "'"%></h3>
        <div class="content-gp">
            <div class="container-table-gp">
                <table class="table-gp">
                    <tr class="table-header tr-gp">
                        <th>Consumo (L/100KM)</th>
                        <th>Longitud (M)</th>
                        <th>Vueltas</th>
                        <th>Consumo por vuelta (L)</th>
                        <th>Consumo total (L)</th>
                    </tr>
                    <tr class="tr-gp">
                        <td class="td-gp2"><%=cocheCombustible.getConsumo()%></td>
                        <td class="td-gp2"><%=circuitoCombustible.getLongitud()%></td>
                        <td class="td-gp2"><%=circuitoCombustible.getNumeroDeVueltas()%></td>
                        <td class="td-gp2"><%=consumoVuelta%></td>
                        <td class="td-gp2"><%=consumoTotal%></td>
                    </tr>
                </table>
            </div>
        </div>
        <%}%>

        <hr style="border: 1px solid #dddddd; width: 60%; margin-left: auto; margin-right: auto; margin-top: 50px; margin-bottom: 30px">

        <h1 class="h1">ERS</h1>
        <br>
        <div class="form">
            <form action="/web-formula1/SimulacionesServlet">

                <%if (equipo != null) {%>
                <input type="hidden" name="equipo" value=<%=equipo%> />
                <%}%>

                <div style="float:left;margin-right:40px; margin-left: 10px">
                    <label for="coche" style="font-weight: bold">Coche</label>
                    <select id="coche" name="cocheErs" style="font-size: 1em; background-color: #ecebeb; width: 150px" required>
                        <%for (Coche c : listaCoches) {%>
                        <option value=<%=c.getId()%>><%=c.getNombre()%></option>
                        <%}%>
                    </select>
                </div>

                <div style="float:left;margin-right:10px;">
                    <label for="circuito" style="font-weight: bold">Circuito</label>
                    <select id="circuito" name="circuitoErs" style="font-size: 1em; background-color: #ecebeb; width: 150px" required>
                        <%for (Circuito c : listaCircuitos) {%>
                        <option value=<%=c.getId()%>><%=c.getNombre()%></option>
                        <%}%>
                    </select>
                </div>

                <div style="float:left;margin-right:40px; margin-left: 10px">
                    <label for="conduccion" style="font-weight: bold">Tipo de conducción</label>
                    <select id="conduccion" name="conduccion" style="font-size: 1em; background-color: #ecebeb; width: 150px" required>
                        <option value="ahorrador">Ahorrador</option>
                        <option value="normal">Normal</option>
                        <option value="deportivo">Deportivo</option>
                    </select>
                </div>
                <br><br><br>
                <div style="text-align: center;">
                    <button class="btn" type="submit" style="font-size: 1em;">Calcular</button>
                </div>
            </form>
        </div>

        <br>
        <% if (gananciaVuelta != null && vueltasNecesariasErs != null && tipoConduccion != null && cocheErs != null && circuitoErs != null) {%>
        <h3 class="h1"><%="Coche '" + cocheErs.getNombre() + "' en el circuito '" + circuitoErs.getNombre() + "' con tipo de conducción '" + tipoConduccion + "'"%></h3>
        <div class="content-gp">
            <div class="container-table-gp">
                <table class="table-gp">
                    <tr class="table-header tr-gp">
                        <th>Ganacia Vuelta Lenta</th>
                        <th>Ganacia Vuelta Media</th>
                        <th>Ganacia Vuelta Rapida</th>
                        <th>Curvas Lentas</th>
                        <th>Curvas Medias</th>
                        <th>Curvas Rapidas</th>
                        <th>Ganancia por vuelta (kW)</th>
                        <th>Vueltas necesarias para generar 1.2 kW</th>
                    </tr>
                    <tr class="tr-gp">
                        <td class="td-gp2"><%=cocheErs.getErsCL()%></td>
                        <td class="td-gp2"><%=cocheErs.getErsCM()%></td>
                        <td class="td-gp2"><%=cocheErs.getErsCR()%></td>
                        <td class="td-gp2"><%=circuitoErs.getCurvasLentas()%></td>
                        <td class="td-gp2"><%=circuitoErs.getCurvasMedia()%></td>
                        <td class="td-gp2"><%=circuitoErs.getCurvasRapidas()%></td>
                        <td class="td-gp2"><%=gananciaVuelta%></td>
                        <td class="td-gp2"><%=vueltasNecesariasErs%></td>
                    </tr>
                </table>
            </div>
        </div>
        <%}%>

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