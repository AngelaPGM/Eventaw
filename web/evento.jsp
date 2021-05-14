<%-- 
    Document   : evento
    Created on : 11-may-2021, 18:17:16
    Author     : Pepe
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="eventaw.entity.Entrada"%>
<%@page import="java.util.List"%>
<%@page import="eventaw.entity.Usuarioevento"%>
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

        <title>Comprar entrada</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <%
        Evento evento = (Evento) request.getAttribute("evento");
        Usuario user = (Usuario) session.getAttribute("user");
        List<Entrada> entradasUsuario = user.getUsuarioevento().getEntradaList();
        int entradasLibres = evento.getAforo()-evento.getEntradaList().size();
        int contador = 0;
        
        for(Entrada e: entradasUsuario) {
            if(e.getEvento().equals(evento)) {
                contador++;
            }
        }
        
        int puedeComprar = evento.getMaxentradasusuario()-contador;
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

        <div class="fondo-pagina">
            <div class="container-perfil">
                <div class="wrap-registro justify-content-center text-center" >
                    <form class="register-form" method="POST" action="ServletAceptaPago?idEvento=<%= evento.getId()%>">                    
                        <span class="bg-text" style="color: #7cc5e5">
                            <h1><%= evento.getTitulo()%></h1>
                            <h4><%= evento.getDescripcion()%></h4> 
                            <h4 style="padding-top: 1%;">en <%= evento.getCiudad()%> el <%= new SimpleDateFormat("dd/MM/yyyy").format(evento.getFecha())%></h4>
                        </span>
                        <hr/>
                        <div class="row">
                            <p style="font-size: 1.2rem; color:black">
                                ¿Cuantas entradas desea comprar? (<%= new DecimalFormat("#0.00").format(evento.getPrecio())%>€ cada una): 
                            </p>
                        </div>
                        <div class="row justify-content-center" >
                            <p class="m-b-10">
                                    Nota: tendr&aacute;s que confirmar la compra en la siguiente ventana.
                                </p>
                            <div class="col-2">
                                <select  class="custom-select text-center justify-content-center" style="padding: 5px" name="numEntradas">
                                    <%  
                                        if(entradasLibres < puedeComprar) {
                                            puedeComprar = entradasLibres;
                                        }
                                        for (int i = 1; i <= puedeComprar; i++) {
                                    %>
                                    <option><%= i%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                                <div class="col-2">
                                    <input class="btn btn-primary" style="border-radius: 40px; background-color: #7cc5e5; border-color: #7cc5e5" 
                                           type="submit" value="RESERVAR" name="inscribir" />
                                </div>
                        </div>
                                
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
