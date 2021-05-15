<%-- 
    Document   : analisis
    Created on : 07-may-2021, 0:38:45
    Author     : rafa
--%>

<%@page import="eventaw.entity.Evento"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        List<Evento> listaEventos = (List) request.getAttribute("listaEventos");
        List<Integer> anyos = (List) request.getAttribute("anyos");
        
        %>
    <body>
        <h1>Analisis </h1>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Titulo</th>
                    <th>Descripcion</th>
                    <th>Ciudad</th>
                    <th>Fecha</th>
                    <th>Precio</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(Evento e: listaEventos){
                    %>
                <tr>
                    <td><%= e.getId() %></td>
                    <td><%= e.getTitulo() %></td>
                    <td><%= e.getDescripcion() %></td>
                    <td><%= e.getCiudad() %></td>
                    <td><%= e.getFecha() %></td>
                    <td><%= e.getPrecio() %></td>
                </tr>
                <%
                    }
                    %>
            </tbody>
        </table>
            <br>
        <form>
            Fecha >
            <select name="fechaMayor">
                <%
                    for(Integer a: anyos){
                %>
                <option><%= a.intValue() %></option>
                <%}%>
            </select>
            <br>
            Fecha <
            <br>
            Fecha =
            <br>
            Precio >
            <br>
            Precio <
            <br>
            Precio =
            <br>
            Ciudad
            <select>
                <option></option>
            </select>
        </form>
    </body>
    
</html>
