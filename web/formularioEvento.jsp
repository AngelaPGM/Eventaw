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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Nuevo evento</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <%
        Evento evento = (Evento) request.getAttribute("evento");
        String error = (String) request.getAttribute("error");
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        Usuario usuario;

        usuario = (Usuario) session.getAttribute("user");

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
            if (numFilas.equals("null")) {
                numFilas = "";
            }
            asientos = "" + evento.getAsientosfila();
            if (asientos.equals("null")) {
                asientos = "";
            }
        }


    %>
    <body>

        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a  href="inicioCreador.jsp">Inicio</a></li>
                <li style="float:right"><a href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="ServletCrudUsuario?id=<%= usuario.getId()%>">Mi perfil</a></li>
            </ul> 
        </div>

        <div class="fondo-pagina">
            <div class="container-perfil">
                <div class="wrap-registro justify-content-center text-center" >
                    <form class="register-form" method="POST" action="ServletGuardarEvento"> 
                        <span class="bg-text" style="color: #a64bf4">
                            <h1>
                                Nuevo evento
                            </h1> 
                        </span>
                        
                    </form>
                </div>
            </div>
        </div>



        <h1>Formulario Evento</h1>
        <form action="ServletGuardarEvento">
            <table border="1" cellpadding="1">
                <input type="hidden" name="id" value="<%= id%>"/>
                <tbody>
                    <tr>
                        <td>Título*</td>
                        <td><input type="text" name="titulo" value="<%= titulo%>"/></td>
                    </tr>
                    <tr>
                        <td>Descripción*</td>
                        <td><input type="text" name="desc" value="<%= desc%>"/></td>
                    </tr>
                    <tr>
                        <td>Ciudad</td>
                        <td><input type="text" name="ciudad" value="<%= ciudad%>"/></td>
                    </tr>
                    <%
                        if (fecha.equals("") || fechaCompra.equals("")) {
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
                                   value="<%= fecha%>"></td>
                    </tr>
                    <tr>
                        <td>Fecha límite*</td>
                        <td><input class="input2"   type="date" id="start" name="fechaCompra" max="2040-12-31" 
                                   value="<%= fechaCompra%>"></td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td>Precio*</td>
                        <td><input type="text" name="precio" value="<%= precio%>"/></td>
                    </tr>
                    <tr>
                        <td>Aforo*</td>
                        <td><input type="text" name="aforo" value="<%= aforo%>"/></td>
                    </tr>
                    <tr>
                        <td>Límite de compra*</td>
                        <td><input type="text" name="max" value="<%= max%>"/></td>
                    </tr>
                    <tr>
                        <td>Nº de filas</td>
                        <td><input type="text" name="numFilas" value="<%= numFilas%>"/></td>
                    </tr>
                    <tr>
                        <td>Nº de asientos por fila</td>
                        <td><input type="text" name="asientos" value="<%= asientos%>"/></td>
                    </tr>
                </tbody>
                <input type="hidden" name="creador" value="<%= usuario.getId()%>"/>
            </table></br>
            Los campos marcados con * son obligatorios.</br>
            <input type="submit" value="Guardar"/></br>
            <%
                if (error != null) {
            %>
            <%= error%>
            <%
                }
            %>
        </form>
    </body>
</html>
