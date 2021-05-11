<%-- 
    Document   : aceptarPago
    Created on : 11-may-2021, 19:27:15
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
            Double numEntradas;
            
            evento = (Evento)request.getAttribute("evento");
            numEntradas = (Double)request.getAttribute("numEntradas");
        %>
        <h1>Se le realizará un cobro de <%= evento.getPrecio() * numEntradas %> por su inscripción en el evento: <%= evento.getTitulo() %></h1>
        <%
            if(numEntradas == 1.0){
        %>
        <form action="ServletInscribir">
            <input type="hidden" name="idEvento" value="<%= evento.getId() %>" />
            Seleccione su asiento: <br/>
            Fila: <select name="fila">
                <%
                    for(int i = 1; i <= evento.getNumfilas();i++){
                %>
                <option><%= i %></option>
                <%
                    }
                %>
            </select>
            Asiento: <select name="asiento">
                <%
                    for(int i = 1; i <= evento.getAsientosfila();i++){
                %>
                <option><%= i %></option>
                <%
                    }
                %>
            </select> <br/>
            <input type="submit" value="Aceptar" name="aceptar" />
        </form>
        <%
            } else {
        %>
        <form action="ServletInscribir">
            <input type="hidden" name="idEvento" value="<%= evento.getId() %>" />
            Seleccione sus asientos: <br/>
            <%
                for(int i = 0; i < numEntradas;i++){
            %>
            Fila: <select name="fila">
                <%
                    for(int j = 1; j <= evento.getNumfilas();j++){
                %>
                <option><%= j %></option>
                <%
                    }
                %>
            </select>
            Asiento: <select name="asiento">
                <%
                    for(int j = 1; j <= evento.getAsientosfila();j++){
                %>
                <option><%= j %></option>
                <%
                    }
                %>
            </select> <br/>
            <%
                }
            %>
            <input type="submit" value="Aceptar" name="aceptar" />
        </form>
        <%
            } 
        %>
    </body>
</html>
