<%-- 
    Document   : Circuito
    Created on : 11 nov. 2021, 02:04:33
    Author     : Nasr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Circuito" %>
<!DOCTYPE html>
<html>
    <%
        Circuito circuito = (Circuito) request.getSession().getAttribute("circuito");
    %>
<head>
    <title>Circuito</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="stylesheet" href="../css/custom.css">
    <link rel="stylesheet" href="../css/all.min.css">
</head>
<body>
    <table>
        <tr>
            <td><%=circuito.getNombre()%></td>
        </tr>
        <tr>
            <td><%=circuito.getCiudad()%></td>
        </tr>
        <tr>
            <td><%=circuito.getPais()%></td>
        </tr>
    </table>      
</body>
</html>
