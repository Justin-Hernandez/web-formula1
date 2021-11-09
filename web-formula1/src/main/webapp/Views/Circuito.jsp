<%-- 
    Document   : Circuito
    Created on : 9 nov. 2021, 12:56:15
    Author     : Nasr
--%>

<%@page import="Models.Circuitos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        Circuitos circuito = (Circuitos) request.getSession().getAttribute("circuito");
    %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Noticias</title>
    <link rel="stylesheet" href="../css/custom.css">
    <link rel="stylesheet" href="../css/all.min.css">
</head>
<body>
    <table>
        <tr> 
            <td><%=circuito.getNombre()%></td>
        </tr>
        <tr> 
            <td><%=circuito.getPais()%></td>
        </tr>
        <tr> 
            <td><%=circuito.getCiudad()%></td>
        </tr>
    </table>
</body>
</html>