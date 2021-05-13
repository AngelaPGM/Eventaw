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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mis entradas</title>

        <!-- BOOTSTRAP Y CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <%
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        Usuario usuario = (Usuario) session.getAttribute("user");
    %>
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a href="ServletRedirectInicio">Inicio</a></li>
                <li style="float:right"><a href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="perfilUsuario.jsp">Mi perfil</a></li>
                <li style="float:right"><a  class="active" href="misEntradas.jsp">Mis entradas</a></li>
            </ul> 
        </div>


        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white" style="height: 40vh">
            <div class="container">
                <div class="bg-text">
                    <h1 style="font-size: 4rem"> Mis entradas</h1>
                </div>
                <div class="row justify-content-center m-t-30">
                    <div class="col-4 wrap-input2 ">
                        <input class="input2" type="text" name="buscador" placeholder="Buscar entradas por nombre y/o fecha"/> 
                    </div>
                    <div class="col-2 wrap-input2 wrap-separacion10" >
                        <input class="input2"   type="date" id="start" name="trip-start" min="<%=formato.format(new Date())%>" max="2040-12-31"> 
                    </div>
                    <div class="col-2 wrap-input2 wrap-separacion10" >
                        <input class="input2"   type="date" id="start" name="trip-start" min="<%=formato.format(new Date())%>" max="2040-12-31"> 
                    </div>
                    <div class="col-2">
                        <div class="wrap-login100-form-btn">
                            <div class="login100-form-bgbtn"></div>
                            <button class="login100-form-btn" value="Buscar">
                                Buscar
                            </button>
                        </div>                    
                    </div>
                </div>
            </div>
        </header>

        <%
            List<Entrada> entradasFuturas = new ArrayList();
            List<Entrada> entradasPasadas = new ArrayList();

            for (Entrada e : usuario.getEntradaList()) {
                if (e.getEvento().getFecha().after(new Date())) {
                    entradasFuturas.add(e);
                } else {
                    entradasPasadas.add(e);
                }
            }
        %>

        <div class="container m-t-30">
            <div class="table-responsive">

                <%
                    if (!entradasFuturas.isEmpty()) {
                %>
                <table class="center table table-striped align-middle" id="tabla-custom">
                    <thead>
                        <tr>
                            <th>EVENTO</th>
                            <th>FECHA</th>
                            <th>FILA</th>
                            <th>ASIENTO</th>
                            <th>PRECIO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Entrada e : entradasFuturas) {
                        %>
                        <tr>
                            <td><%= e.getEvento().getTitulo()%></td>
                            <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha())%></td>
                            <td><%= e.getNumfila()%></td>
                            <td><%= e.getAsientofila()%></td>
                            <td><%= e.getEvento().getPrecio() %> €</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table> <br/>
                <%
                } else {
                %>

                <div class="bg-text text-center" style="margin-top: 10%">
                    <h1 style="color: #9e9e9e"> Vaya, a&uacute;n no tienes ninguna entrada :(</h1>
                    <h1 style="color: #9e9e9e"> Cuando las tengas aparecer&aacute;n aqu&iacute;</h1>
                </div>
                <%
                    }

                    if (!entradasPasadas.isEmpty()) {
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
                            for (Entrada e : entradasPasadas) {
                        %>
                        <tr>
                            <td><%= e.getEvento().getTitulo()%></td>
                            <td><%= e.getEvento().getDescripcion()%></td>
                            <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha())%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
