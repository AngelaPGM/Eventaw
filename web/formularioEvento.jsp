<%-- 
    Document   : formularioEvento
    Created on : 10-may-2021, 16:01:30
    Author     : Gonzalo
--%>

<%@page import="java.util.Date"%>
<%@page import="eventaw.entity.Usuario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="eventaw.entity.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        Evento evento = (Evento)request.getAttribute("evento");
        String error = (String)request.getAttribute("error");
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        Usuario usuario;
        
        usuario = (Usuario)session.getAttribute("user");
        
        String id = "", titulo = "", desc = "", ciudad = "", fecha = "", fechaCompra = "", precio = "",
                    aforo = "", max = "", numFilas = "", asientos = "";
        
        if (evento != null) {
            id = "" + evento.getId();
            titulo = evento.getTitulo();
            desc = evento.getDescripcion();
            ciudad = evento.getCiudad();
            fecha = formato.format(evento.getFecha());
            fechaCompra = formato.format(evento.getFechacompra());
            precio = "" + evento.getPrecio();
            aforo = "" + evento.getAforo();
            max = "" + evento.getMaxentradasusuario();
            numFilas = "" + evento.getNumfilas();
            if(numFilas.equals("null")){
                numFilas="";
            }
            asientos = "" + evento.getAsientosfila();
            if(asientos.equals("null")){
                asientos="";
            }
        }
        
        
    %>
    <body>
        <h1>Formulario Evento</h1>
        <form action="ServletGuardarEvento">
            <table border="1" cellpadding="1">
                <input type="hidden" name="id" value="<%= id %>"/>
                <tbody>
                    <tr>
                        <td>Título*</td>
                        <td><input type="text" name="titulo" value="<%= titulo %>"/></td>
                    </tr>
                    <tr>
                        <td>Descripción*</td>
                        <td><input type="text" name="desc" value="<%= desc %>"/></td>
                    </tr>
                    <tr>
                        <td>Ciudad</td>
                        <td><input type="text" name="ciudad" value="<%= ciudad %>"/></td>
                    </tr>
                    <%
                           if(fecha.equals("") || fechaCompra.equals("")){ 
                    %>
                    <tr>
                        <td>Fecha*</td>
                        <td><input class="input2"   type="date" id="start" name="fecha" max="2040-12-31" 
                                   value="<%=formato.format(new Date())%>"></td>
                    </tr>
                    <tr>
                        <td>Fecha límite*</td>
                        <td><input class="input2"   type="date" id="start" name="fechaCompra" max="2040-12-31" 
                                   value="<%=formato.format(new Date())%>"></td>
                    </tr>
                    <%
                        } else {  
                    %>
                    <tr>
                        <td>Fecha*</td>
                        <td><input class="input2" type="date" id="start" name="fecha" max="2040-12-31" 
                                   value="<%= fecha %>"></td>
                    </tr>
                    <tr>
                        <td>Fecha límite*</td>
                        <td><input class="input2"   type="date" id="start" name="fechaCompra" max="2040-12-31" 
                                   value="<%= fechaCompra %>"></td>
                    </tr>
                    <%
                        }    
                    %>
                    <tr>
                        <td>Precio*</td>
                        <td><input type="text" name="precio" value="<%= precio %>"/></td>
                    </tr>
                    <tr>
                        <td>Aforo*</td>
                        <td><input type="text" name="aforo" value="<%= aforo %>"/></td>
                    </tr>
                    <tr>
                        <td>Límite de compra*</td>
                        <td><input type="text" name="max" value="<%= max %>"/></td>
                    </tr>
                    <tr>
                        <td>Nº de filas</td>
                        <td><input type="text" name="numFilas" value="<%= numFilas %>"/></td>
                    </tr>
                    <tr>
                        <td>Nº de asientos por fila</td>
                        <td><input type="text" name="asientos" value="<%= asientos %>"/></td>
                    </tr>
                </tbody>
                <input type="hidden" name="creador" value="<%= usuario.getId() %>"/>
            </table></br>
            Los campos marcados con * son obligatorios.</br>
            <input type="submit" value="Guardar"/></br>
            <%
                if(error!=null){
            %>
            <%= error %>
            <%        
                }
            %>
        </form>
    </body>
</html>
