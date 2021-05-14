<%-- 
    Document   : inicioCreador
    Created on : 13-may-2021, 14:09:19
    Author     : Pepe
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="eventaw.entity.Evento"%>
<%@page import="eventaw.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String borrado = "borrado";
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            
            List<Evento> misEventos;
            misEventos = (List<Evento>) request.getAttribute("eventos");
        %>
        <h1>Mis Eventos  <a href="">Mi Perfil</a> <a href="ServletCierreSesion">Cerrar Sesión</a></h1>
        
        <form action="ServletListadoEventos">
            <input type="text" name="buscador" value="" /> 
        <input class="input2"   type="date" id="start" name="fechaInicio" min="<%=formato.format(new Date())%>" max="2040-12-31">
        <input class="input2"   type="date" id="start" name="fechaFinal" min="<%=formato.format(new Date())%>" max="2040-12-31">
        <input type="submit" value="Buscar" name="buscarBoton" />
        </form>
        <br/>
        <br/>
        
        <table border="1">
            <thead>
                <tr>
                    <th>TITULO</th>
                    <th>DESCRIPCION</th>
                    <th>FECHA</th>
                    <th>FECHA_LIMITE_COMPRA</th>
                    <th>PRECIO</th>
                    <th>AFORO</th>
                    <th>MAX_ENTRADAS_USUARIO</th>
                    <th>NUM_FILAS</th>
                    <th>ASIENTOS_POR_FILA</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(Evento e : misEventos){
                %>
                <tr>
                    <td><%= e.getTitulo() %></td>
                    <td><%= e.getDescripcion() %></td>
                    <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getFecha()) %></td>
                    <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getFechacompra()) %></td>
                    <td><%= e.getPrecio() %></td>
                    <td><%= e.getAforo() %></td>
                    <td><%= e.getMaxentradasusuario() %></td>
                    <td><%= e.getNumfilas() %></td>
                    <td><%= e.getAsientosfila() %></td>
                    <td><a href="ServletCRUDEvento?id=<%= e.getId() %>">Editar</a></td>
                    <td><a href="ServletCRUDEvento?id=<%= e.getId() %>&borrar=<%= borrado %>">Borrar</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        
            <h2><a href="ServletCRUDEvento">Publicar Nuevo Evento</a></h2>
    </body>
</html>
