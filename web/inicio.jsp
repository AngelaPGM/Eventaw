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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/util.css">
    <body>
        <%
            List<Evento> eventos;

            eventos = (List<Evento>) request.getAttribute("eventos");
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        %>


        <div class="topnav">
            <ul>
                <li><a class="active">Inicio</a></li>

                <li style="float:right"><a <a href="login.jsp">Cerrar sesión</a></li>
                <li style="float:right"><a <a href="perfil.jsp">Mi perfil</a></li>
                <li style="float:right"><a href="">Mis entradas</a></li>
            </ul> 
        </div>



        <h1>Bienvenido a EvenTAW</h1>
        <input type="text" name="buscador" value="Buscar Eventos" /> <input type="submit" value="Buscar" name="BuscarBoton" />


        Eventos Disponibles: <br/>
        <%
            for (Evento ev : eventos) {
        %>
        <a href="ServletEvento?id=<%= ev.getId()%>"><%= ev.getTitulo()%></a><br/>
        <%
            }
        %>

        <input type="date" id="start" name="trip-start" value="<%= formato.format(new Date())%>" min="<%=formato.format(new Date())%>" max="2040-12-31">
        <br/>
        <input type="submit" value="Ayuda" name="ayuda" />

    </body>
</html>
