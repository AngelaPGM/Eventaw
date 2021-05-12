<%-- 
    Document   : aceptarPago
    Created on : 11-may-2021, 19:27:15
    Author     : Pepe
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="eventaw.entity.Etiqueta"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.util.SortedMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="eventaw.entity.Entrada"%>
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
            Map<Integer, List<Integer>> asientos = new TreeMap();
            
            evento = (Evento)request.getAttribute("evento");
            numEntradas = (Double)request.getAttribute("numEntradas");
            
            for(int i = 1; i <= evento.getNumfilas();i++){
                List<Integer> aux = new ArrayList();
                for(int j = 1; j <= evento.getAsientosfila();j++){
                    aux.add(j);
                }
                asientos.put(i, aux);
            }
            
            for(Entrada e : evento.getEntradaList()){
                asientos.get(e.getNumfila()).remove(e.getAsientofila());
            }
        %>
        <h1>Se le realizará un cobro de <%= new DecimalFormat("#0.00").format(evento.getPrecio() * numEntradas) %> por su inscripción en el evento: <%= evento.getTitulo() %></h1>
        <%
            if(numEntradas == 1.0){
        %>
        <form action="ServletInscribir">
            <input type="hidden" name="idEvento" value="<%= evento.getId() %>" />
            <input type="hidden" name="numEntradas" value="<%= new DecimalFormat("#0").format(numEntradas) %>" />
            Seleccione su asiento: : <select name="asiento0">
                <%
                    for(Integer i : asientos.keySet()){
                        for(Integer j : asientos.get(i)){                    
                %>
                <option>Fila: <%= i %> Asiento: <%= j %></option>
                <%  
                        }
                    }
                %>
            </select>
            <input type="submit" value="Aceptar" name="aceptar" />
        </form>
        <%
            } else {
        %>
        <form action="ServletInscribir">
            <input type="hidden" name="idEvento" value="<%= evento.getId() %>" />
            <input type="hidden" name="numEntradas" value="<%= new DecimalFormat("#0").format(numEntradas) %>" />
            
            Seleccione sus asientos: <br/>
            <%
                for(int i = 0; i < numEntradas;i++){
            %>
            <select name="asiento<%= i %>">
                <%
                    for(Integer j : asientos.keySet()){
                        for(Integer k : asientos.get(j)){                    
                %>
                <option>Fila: <%= j %> Asiento: <%= k %></option>
                <%  
                        }
                    }
                %>
            </select><br/>
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
