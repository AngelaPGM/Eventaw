<%-- 
    Document   : misEntradas
    Created on : 12-may-2021, 14:41:38
    Author     : Pepe
--%>

<%@page import="java.text.DecimalFormat"%>
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
                <li style="float:right"><a href="perfilUsuario.jsp?editar=0">Mi perfil</a></li>
                <li style="float:right"><a  class="active">Mis entradas</a></li>
                <li style="float:right"><a href="ServletNuevaConversacion">CHAT TELEOPERADOR</a></li>
            </ul> 
        </div>


        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white" style="height: 40vh">
            <div class="container">
                <div class="bg-text">
                    <h1 style="font-size: 4rem"> Mis entradas</h1>
                </div>
                <form action="ServletListadoEntradas">
                    <div class="row justify-content-center m-t-30">
                        <div class="col-4 wrap-input2 ">
                            <input class="input2" type="text" name="buscador" placeholder="Buscar entradas por nombre y/o fecha"/> 
                        </div>
                        <div class="col-2 wrap-input2 wrap-separacion10" >
                            <input class="input2"   type="date" id="start" name="fechaInicio" min="<%=formato.format(new Date())%>" max="2040-12-31"> 
                        </div>
                        <div class="col-2 wrap-input2 wrap-separacion10" >
                            <input class="input2"   type="date" id="start" name="fechaFinal" min="<%=formato.format(new Date())%>" max="2040-12-31"> 
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
                </form>
            </div>
        </header>

        <%
            List<Entrada> entradasFuturas = new ArrayList();
            List<Entrada> entradasPasadas = new ArrayList();
            Date todayDate = new Date();
            String todayString = new SimpleDateFormat("dd/MM/yyyy").format(todayDate);

            if (request.getParameter("filtrado").equals("1")) {

                entradasFuturas = (List<Entrada>) request.getAttribute("entradas");

                for (Entrada e : usuario.getUsuarioevento().getEntradaList()) {
                    String fecha = new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha());
                    if (!fecha.equals(todayString)) {
                        if (e.getEvento().getFecha().before(todayDate)) {
                            entradasPasadas.add(e);
                        }
                    }
                }
            } else {

                for (Entrada e : usuario.getUsuarioevento().getEntradaList()) {
                    String fecha = new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha());
                    if (e.getEvento().getFecha().after(todayDate)) {
                        entradasFuturas.add(e);
                    } else if (fecha.equals(todayString)) {
                        entradasFuturas.add(e);
                    } else {
                        entradasPasadas.add(e);
                    }
                }
            }
         if (entradasFuturas.isEmpty() && entradasPasadas.isEmpty()) { %>
        <div class="bg-text justify-content-center text-center" style="margin-top: 10%">
            <h1 style="color: #9e9e9e"> Vaya, parece que a&uacute;n no tienes ninguna entrada  :(</h1>
            <h1 style="color: #9e9e9e"> Cuando las tengas aparecer&aacute;n aqu&iacute;</h1>
        </div>

        <% } else {
        %>
        
        <!--  EVENTOS DISPONIBLES -->
        <%
            if (!entradasFuturas.isEmpty()) {
        %>
        <div class="container m-t-30">
            <h1 class="bg-text m-b-5" style="color:#b997f6">Eventos futuros</h1>
            <div class="table-responsive">
                <table class="center table table-striped align-middle" id="tabla-custom">
                    <thead>
                        <tr>
                            <th>EVENTO</th>
                            <th>DESCRIPCI&Oacute;N</th>
                            <th>CIUDAD</th>
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
                            <td><%= e.getEvento().getDescripcion()%></td>
                            <td><%= e.getEvento().getCiudad()%></td>
                            <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha())%></td>

                            <td><%= (e.getNumfila()==null?"-":e.getNumfila())%></td>
                            <td><%= (e.getAsientofila()==null?"-":e.getAsientofila())%></td>
                            <td><%= new DecimalFormat("#0.00").format(e.getEvento().getPrecio())%> €</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <%
                } 
            if (!entradasPasadas.isEmpty()) {
        %>
        <div class="container m-t-30">
            <h1 class="bg-text m-b-5" style="color:#00dbde">Eventos a los que he asistido</h1>
            <div class="table-responsive">
                <table class="center table table-striped align-middle" id="tabla-custom2">
                    <thead>
                        <tr>
                            <th>EVENTO</th>
                            <th>DESCRIPCI&Oacute;N</th>
                            <th>CIUDAD</th>
                            <th>FECHA</th>
                            <th>FILA</th>
                            <th>ASIENTO</th>
                            <th>PRECIO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Entrada e : entradasPasadas) {
                        %>
                        <tr>
                            <td><%= e.getEvento().getTitulo()%></td>
                            <td><%= e.getEvento().getDescripcion()%></td>
                            <td><%= e.getEvento().getCiudad()%></td>
                            <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getEvento().getFecha())%></td>
                            <td><%= e.getNumfila()%></td>
                            <td><%= e.getAsientofila()%></td>
                            <td><%= new DecimalFormat("#0.00").format(e.getEvento().getPrecio())%> €</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                    } }
                %>
            </div>
        </div> 

    </body>
</html>
