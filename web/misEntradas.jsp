<%-- 
    Document   : misEntradas
    Created on : 12-may-2021, 14:41:38
    Author     : Pepe
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="eventaw.entity.Entrada"%>
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
            Usuario usuario;
            List<Entrada> entradasFuturas = new ArrayList();
            List<Entrada> entradasPasadas = new ArrayList();
            Date today = new Date();
        
            usuario = (Usuario)session.getAttribute("user");
        
            for(Entrada e : usuario.getEntradaList()){
                if(e.getEvento().getFecha().after(today)){
                    entradasFuturas.add(e);
                } else {
                    entradasPasadas.add(e);
                }
            }
        %>
        <h1>Mis Entradas</h1>
        <%
            if(!entradasFuturas.isEmpty()){
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>EVENTO</th>
                    <th>FECHA</th>
                    <th>FILA</th>
                    <th>ASIENTO</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(Entrada e : entradasFuturas){
                %>
                <tr>
                    <td><%= e.getEvento().getTitulo() %></td>
                    <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha()) %></td>
                    <td><%= e.getNumfila() %></td>
                    <td><%= e.getAsientofila() %></td>
                    <td><a href="ServletCancelarEntrada?idEntrada=<%= e.getId() %>">Cancelar</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table> <br/>
        <%
            } else {
        %>
        No tienes ninguna entrada :(
        <%
            }

            if(!entradasPasadas.isEmpty()){
        %>
        <h1>Eventos a los que he asistido</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>EVENTO</th>
                    <th>DESCRIPCION</th>
                    <th>FECHA</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(Entrada e : entradasPasadas){
                %>
                <tr>
                    <td><%= e.getEvento().getTitulo() %></td>
                    <td><%= e.getEvento().getDescripcion() %></td>
                    <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha()) %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            }
        %>
    </body>
</html>
