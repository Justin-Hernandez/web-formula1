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

        <h1 class="h1">Gasto de combustible</h1>
        <br><br>
        <div class="form">
            <form action="/web-formula1/SimulacionesServlet">
                
                <%if(equipo != null){%>
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
                    <button class="button" type="submit" style="font-size: 1em;">Calcular</button>
                </div>
            </form>
        </div>

        <br><br><br>
        <% if (consumoVuelta != null && consumoTotal != null && cocheCombustible != null && circuitoCombustible != null) {%>
        <h3 class="h1"><%="Coche '" + cocheCombustible.getNombre() + "' en el circuito '" + circuitoCombustible.getNombre() + "'"%></h3>
        <table class="table">
            <tr>
                <th class="th">Consumo (L/100KM)</th>
                <th class="th">Longitud (M)</th>
                <th class="th">Vueltas</th>
                <th class="th">Consumo por vuelta (L)</th>
                <th class="th">Consumo total (L)</th>
            </tr>
            <tr>
                <td class="td"><%=cocheCombustible.getConsumo()%></td>
                <td class="td"><%=circuitoCombustible.getLongitud()%></td>
                <td class="td"><%=circuitoCombustible.getNumeroDeVueltas()%></td>
                <td class="td"><%=consumoVuelta%></td>
                <td class="td"><%=consumoTotal%></td>
            </tr>
        </table>
        <%}%>

        <hr style="border: 1px solid #dddddd; width: 60%; margin-left: auto; margin-right: auto; margin-top: 50px; margin-bottom: 30px">

        <h1 class="h1">ERS</h1>
        <br><br>
        <div class="form">
            <form action="/web-formula1/SimulacionesServlet">
                
                <%if(equipo != null){%>
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
                    <button class="button" type="submit" style="font-size: 1em;">Calcular</button>
                </div>
            </form>
        </div>

        <br><br><br>
        <% if (gananciaVuelta != null && vueltasNecesariasErs != null && tipoConduccion != null && cocheErs != null && circuitoErs != null) {%>
        <h3 class="h1"><%="Coche '" + cocheErs.getNombre() + "' en el circuito '" + circuitoErs.getNombre() + "' con tipo de conducción '" + tipoConduccion + "'"%></h3>
        <table class="table">
            <tr>
                <th class="th">Ganacia Vuelta Lenta</th>
                <th class="th">Ganacia Vuelta Media</th>
                <th class="th">Ganacia Vuelta Rapida</th>
                <th class="th">Curvas Lentas</th>
                <th class="th">Curvas Medias</th>
                <th class="th">Curvas Rapidas</th>
                <th class="th">Ganancia por vuelta (kW)</th>
                <th class="th">Vueltas necesarias para generar 120 kW</th>
            </tr>
            <tr>
                <td class="td"><%=cocheErs.getErsCL()%></td>
                <td class="td"><%=cocheErs.getErsCM()%></td>
                <td class="td"><%=cocheErs.getErsCR()%></td>
                <td class="td"><%=circuitoErs.getCurvasLentas()%></td>
                <td class="td"><%=circuitoErs.getCurvasMedia()%></td>
                <td class="td"><%=circuitoErs.getCurvasRapidas()%></td>
                <td class="td"><%=gananciaVuelta%></td>
                <td class="td"><%=vueltasNecesariasErs%></td>
            </tr>
        </table>
        <%}%>
        
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