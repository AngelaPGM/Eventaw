<%-- 
    Document   : aceptarPago
    Created on : 11-may-2021, 19:27:15
    Author     : Pepe
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
                <li style="float:right"><a href="perfilUsuario.jsp?editar=0">Mi perfil</a></li>
                <li style="float:right"><a href="misEntradas.jsp?filtrado=0">MIS ENTRADAS</a></li>
            </ul> 
        </div>

        <div class="fondo-pagina">
            <div class="container-perfil">
                <div class="wrap-registro justify-content-center text-center" >
                    <form class="register-form" action="ServletInscribir">
                        <span class="bg-text" style="color: #7cc5e5">
                            <h1><%= evento.getTitulo()%></h1>
                            <h4><%= evento.getDescripcion()%></h4> 
                            <h4 style="padding-top: 1%;">en <%= evento.getCiudad()%> el <%= new SimpleDateFormat("dd/MM/yyyy").format(evento.getFecha())%></h4>
                        </span>
                        <hr/>
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
                        <span class="bg-text">
                            <h4>Se le realizará un cobro de <%= new DecimalFormat("#0.00").format(evento.getPrecio() * numEntradas)%>€ </h4>
                        </span>
                        
                    <form action="ServletInscribir">
                        <input type="hidden" name="idEvento" value="<%= evento.getId()%>" />
                        <input type="hidden" name="numEntradas" value="<%= new DecimalFormat("#0").format(numEntradas)%>" />

                        <span class="bg-text m-b-50">
                            <h4> Seleccione sus asientos: </h4> 
                        </span>
                        
                        
                        <%
                            for (int i = 0; i < numEntradas; i++) {
                        %>
                        <div class="row justify-content-center m-t-10" >
                        <div class="col-4"><select class="custom-select" style="padding:10px" name="asiento<%= i%>">
                            <%
                                for (Integer j : asientos.keySet()) {
                                    for (Integer k : asientos.get(j)) {
                            %>
                            <option>Fila: <%= j%> Asiento: <%= k%></option>
                            <%
                                    }
                                }
                            %>
                        </select></div></div>
                        <%
                            }
                        %>
                        <div class="row justify-content-center">
                                <div class="col-4">
                                    <div class="container-login100-form-btn p-t-20 justify-content-center">
                                        <div class="wrap-login100-form-btn">
                                            <div class="login100-form-bgbtn"></div>
                                            <button class="login100-form-btn">
                                                PAGAR
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </form>

                </div>
            </div>
        </div>

    </body>
</html>
