<%-- 
    Document   : GestionCircuitos
    Created on : 7 nov. 2021, 00:23:19
    Author     : Nasr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.ModeloDatos"%>
<%@page import="Models.Circuitos"%>

<!DOCTYPE html>
<html>
    <%
        ArrayList<Circuitos> circuitos = (ArrayList<Circuitos>) request.getSession().getAttribute("circuitos");
    %>
<head>
    <title>Gestion de Circuitos</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/custom.css">
    <link rel="stylesheet" href="../css/all.min.css">
    <script src="../js/validaciones.js"></script>
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
                <%
                if(session.getAttribute("name") != null){%>
                    <img class="avatar" src="../img/Diez.png" alt="Avatar">
                    <% String nombre = (String) session.getAttribute("name"); %>
                    <a href="AdminPanel.jsp" class="nav-menu-item"><%=nombre%></a><a class="down" href="Noticias.jsp?logout=1"><i class="fas fa-door-open"></i></a>
                    <%if(request.getParameter("logout")!= null){
                        session.removeAttribute("name");
                        response.sendRedirect("Noticias.jsp");
                    }
                }else{%>

                <ul class="nav-menu">
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="InicioSesion.jsp">Iniciar sesión</a></li>
                    <li class="nav-menu-item"><a class="nav-menu-link nav-link custom-button" href="CrearCuenta.jsp">Crear cuenta</a></li>    
                </ul> 
                <%}%>  
        </nav>
    </header>
    
    <form action="/web-formula1/RegistroCircuito?accion=insertar" method="post" enctype="multipart/form-data">
        <table>
            <tr><td><label>Nombre:</label></td></tr>
            <tr><td><input type="text" name="nombre" id="nombre" maxlength="100" width="400px"></td></tr>
            <tr><td><label>Ciudad:</label></td></tr>
            <tr><td><input type="text" name="ciudad" id="ciudad" maxlength="100" width="400px"></td></tr>
            <tr><td><label>País:</label></td></tr>
            <tr><td><input type="text" name="pais" id="pais" maxlength="100" width="400px"></td></tr>
            <tr>
                <td>
                    <label>Número de vueltas:</label><br>
                    <input type="number" name="numeroDeVueltas">
                </td>
                <td>
                    <label>Longitud:</label><br>
                    <input type="number" name="longitud">
                </td>
                <td>
                    <label>Curvas Lentas:</label><br>
                    <input type="number" name="curvasLentas">
                </td>
                <td>
                    <label>Curvas Media:</label><br>
                    <input type="number" name="curvasMedia">
                </td>
                <td>
                    <label>Curvas Rápidas:</label><br>
                    <input type="number" name="curvasRapidas">
                </td>
            </tr>
        </table> 
        <input type="file" id="trazado" name="trazado" onchange="validarImagen(this)"><br>
        <input type="submit" id="adicionar_circuito" value="Adicionar">
    </form>
    <br>
    <table>
        <% for (Circuitos c : circuitos) {%>
            <tr>
                <td class="td-noticias"><%=c.getNombre()%></td>
                <td class="td-icons"><button class="edit-button"><i class="fas fa-edit"></i></button></td>
                <td class="td-icons"><button class="trash-button"><a href="/web-formula1/RegistroCircuito?accion=eliminar&nombre=<%=c.getNombre()%>"><i class="fas fa-trash"></i></a></button></td>
            </tr>
        <%}%>
    </table> 
    
  
    
</body>
</html>
