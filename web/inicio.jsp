<%-- 
    Document   : inicio
    Created on : 11-may-2021, 12:53:14
    Author     : Pepe
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
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
            List<Evento> eventos;
            
            eventos = (List<Evento>) request.getAttribute("eventos");
        %>
        <h1>Bienvenido a EvenTAW</h1>
        <input type="text" name="buscador" value="Buscar Eventos" /> <input type="submit" value="Buscar" name="BuscarBoton" />
        <a href="perfil.jsp">Mi Perfil</a>
        <a href="login.jsp">Cerrar Sesión</a>
        <br/>
        
        Eventos Disponibles: <br/>
        <%
            for(Evento ev : eventos){
        %>
        <a href="ServletEvento?id=<%= ev.getId() %>"><%= ev.getTitulo() %></a><br/>
        <%
            }
        %>
            
        <input type="date" id="start" name="trip-start" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" accept="" min="2021-01-01" max="2040-12-31">
        <br/>
        <input type="submit" value="Ayuda" name="ayuda" />
            
    </body>
</html>
