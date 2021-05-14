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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Comprar entrada</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <%
        Evento evento = (Evento) request.getAttribute("evento");
        Double numEntradas = (Double) request.getAttribute("numEntradas");
        Map<Integer, List<Integer>> asientos = new TreeMap();


    %>
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a href="ServletRedirectInicio">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="perfilUsuario.jsp">Mi perfil</a></li>
                <li style="float:right"><a href="misEntradas.jsp?filtrado=0">MIS ENTRADAS</a></li>
            </ul> 
        </div>
        <%      for (int i = 1; i <= evento.getNumfilas(); i++) {
                List<Integer> aux = new ArrayList();
                for (int j = 1; j <= evento.getAsientosfila(); j++) {
                    aux.add(j);
                }
                asientos.put(i, aux);
            }

            for (Entrada e : evento.getEntradaList()) {
                asientos.get(e.getNumfila()).remove(e.getAsientofila());
            }
        %>
        <h1>Se le realizará un cobro de <%= new DecimalFormat("#0.00").format(evento.getPrecio() * numEntradas)%> por su inscripción en el evento: <%= evento.getTitulo()%></h1>
        <%
            if (numEntradas == 1.0) {
        %>
        <form action="ServletInscribir">
            <input type="hidden" name="idEvento" value="<%= evento.getId()%>" />
            <input type="hidden" name="numEntradas" value="<%= new DecimalFormat("#0").format(numEntradas)%>" />
            Seleccione su asiento: : <select name="asiento0">
                <%
                    for (Integer i : asientos.keySet()) {
                        for (Integer j : asientos.get(i)) {
                %>
                <option>Fila: <%= i%> Asiento: <%= j%></option>
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
            <input type="hidden" name="idEvento" value="<%= evento.getId()%>" />
            <input type="hidden" name="numEntradas" value="<%= new DecimalFormat("#0").format(numEntradas)%>" />

            Seleccione sus asientos: <br/>
            <%
                for (int i = 0; i < numEntradas; i++) {
            %>
            <select name="asiento<%= i%>">
                <%
                    for (Integer j : asientos.keySet()) {
                        for (Integer k : asientos.get(j)) {
                %>
                <option>Fila: <%= j%> Asiento: <%= k%></option>
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
