<%-- 
    Document   : teleoperador
    Created on : 14-may-2021, 16:58:28
    Author     : Gonzalo
--%>

<%@page import="eventaw.entity.Conversacion"%>
<%@page import="java.util.List"%>
<%@page import="eventaw.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        Usuario user = (Usuario)session.getAttribute("user");
        List<Conversacion> chats = (List<Conversacion>)request.getAttribute("chats");
        String borrar = "borrar";
    %>
    <body>
        <h1>Conversaciones</h1>
        <form action="ServletTeleoperador">
            <input type="text" placeholder="Introduzca el filtro..." name="filtro"/> 
            <input type="submit" value="Filtrar"/>
        </form>
        <table border="1">
            <thead>
                <tr>
                    <th>Teleoperador</th>
                    <th>Usuario</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(Conversacion c : chats){
                %>
                <tr>
                    <td><%= c.getTeleoperador().getCorreo() %></td>
                    <td><%= c.getUsuario().getCorreo() %></td>
                    <td><a href="ServletRedireccion?id=<%= c.getId() %>">Ver</a></td>
                    <td><a href="ServletTeleoperador?id=<%= c.getId() %>&borrar=<%= borrar %>">Eliminar</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
            
        </table>

    </body>
</html>
