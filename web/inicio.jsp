<%-- 
    Document   : inicio
    Created on : 11-may-2021, 12:53:14
    Author     : Pepe
--%>

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
        <h1>Bienvenido a TAW</h1>
        <input type="text" name="buscador" value="Buscar Eventos" /> <input type="submit" value="Buscar" name="BuscarBoton" />
        <a href="perfil.jsp">Mi Perfil</a>
        <a href="login.jsp">Cerrar Sesión</a>
        <br/>
        
        Eventos Disponibles: <br/>
        <%
            for(Evento ev : eventos){
        %>
        <a href="ServletEvento"><%= ev.getTitulo() %></a><br/>
        <%
            }
        %>
            
        <input type="date" id="start" name="trip-start" value="2018-07-22" accept="" min="2018-01-01" max="2018-12-31">
        <input type="submit" value="Ayuda" name="ayuda" />
            
    </body>
</html>
