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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis entradas</title>

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/util.css">
    <body>
                <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a href="inicio.jsp">Inicio</a></li>

                <li style="float:right"><a href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="perfil.jsp">Mi perfil</a></li>
                <li style="float:right"><a  class="active" href="misEntradas.jsp">Mis entradas</a></li>
            </ul> 
        </div>
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
      <br/><br/>   <h1>Mis Entradas</h1>
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
