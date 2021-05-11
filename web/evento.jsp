<%-- 
    Document   : evento
    Created on : 11-may-2021, 18:17:16
    Author     : Pepe
--%>

<%@page import="eventaw.entity.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Evento evento;
            
            evento = (Evento) request.getAttribute("evento");
        %>
        <h1><%= evento.getTitulo() %></h1>
        <%= evento.getDescripcion() %> <br/>
        <form action="ServletAceptaPago">
            <input type="hidden" name="idEvento" value="<%= evento.getId() %>" />
            ¿Desea comprar entradas? <select name="numEntradas">
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
        </select>
        <input type="submit" value="INSCRIBIRSE" name="inscribir" />
        </form>
    </body>
</html>
