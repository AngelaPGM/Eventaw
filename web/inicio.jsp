<%-- 
    Document   : inicio
    Created on : 11-may-2021, 12:53:14
    Author     : Pepe
--%>

<%@page import="eventaw.entity.Usuario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="eventaw.entity.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Inicio</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <body>
        <%
            List<Evento> eventos = (List<Evento>) request.getAttribute("eventos");
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");

        %>

        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a class="active">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="perfilUsuario.jsp">Mi perfil</a></li>
                <li style="float:right"><a href="misEntradas.jsp?filtrado=0">MIS ENTRADAS</a></li>
            </ul> 
        </div>



        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white">
            <div class="bg-text">
                <div class="container">
                    <h1 style="font-size: 4rem"> Reserva ya tus entradas </h1>
                    <h2 style="font-size: 3rem"> y no te pierdas nada</h2>
                    <a class="btn btn-primary btn-xl rounded-pill mt-5" href="#!">Ver eventos</a>

                </div>
            </div>
        </header>


        <section>
            <div class="container p-t-30">
                <div class="row">
                    <div class="col-sm-10 col-md-7 offset-1" style="padding: 1rem 4rem">
                        <h1 class="bg-text"> Busca un evento: </h1>
                    </div>
                </div>
                <form action="ServletListadoInicio">
                    <div class="row justify-content-center">
                    <div class="col-5 wrap-input2 ">
                        <input class="input2" type="text" name="buscadorNombre" placeholder="Buscar eventos por nombre"/> 
                    </div>
                    <div class="col-2 wrap-input2 wrap-separacion10" >
                        <input class="input2"   type="date" id="start" name="buscadorFecha" min="<%=formato.format(new Date())%>" max="2040-12-31"> 
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
        </section>            




        <!--<br/>Eventos Disponibles: <br/>-->
        <%
            for (Evento ev : eventos) {
        %>
        <a href="ServletEvento?id=<%= ev.getId()%>"><%= ev.getTitulo()%></a><br/>
        <%
            }
        %>


        <br/>
    </body>
</html>
