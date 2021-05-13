<%-- 
    Document   : inicio
    Created on : 11-may-2021, 12:53:14
    Author     : Pepe
--%>

<%@page import="eventaw.entity.Usuario"%>
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
            List<Evento> eventos = (List<Evento>) session.getAttribute("eventos");
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            Usuario user = (Usuario) session.getAttribute("user");
            String cabecera = "", subcabecera = "";

        %>

        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a class="active">Inicio</a></li>

                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="perfil.jsp">Mi perfil</a></li>
                    <% if (user.getRol().getId() == 1) { //admin 
                    cabecera = "Hola de nuevo";
                    subcabecera = "Administrador";
                    %>
                <li style="float:right"><a href="ServletListadoAdmin">VER USUARIOS</a></li>
                    <%} else if (user.getRol().getId() == 2) { //usuario evento 
                                        cabecera = "Reserva ya tus entradas";
                    subcabecera = "Y no te pierdas nada";
                    %>
                <li style="float:right"><a href="misEntradas.jsp">MIS ENTRADAS</a></li>
                    <% } else if (user.getRol().getId() == 3) { //creador eventos 
                    cabecera = "Un espacio para";
                    subcabecera = "tus mejores eventos";
                    %>
                <li style="float:right"><a href="LlistaEventos.jsp">MIS EVENTOS</a></li>
                    <%
                        }
                    %>

            </ul> 
        </div>



        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white">
            <div class="bg-text">
                <div class="container">
                    <h1 class="masthead-heading mb-0"> <%= cabecera %> </h1>
                    <h2 class="masthead-subheading mb-0"><%= subcabecera %> </h2>

                </div>
            </div>
        </header>



        <h1>Bienvenido a EvenTAW</h1>
        <input type="text" name="buscador" value="Buscar Eventos" /> <input type="submit" value="Buscar" name="BuscarBoton" />
        <br/>

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
