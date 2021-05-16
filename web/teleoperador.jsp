<%-- 
    Document   : teleoperador
    Created on : 14-may-2021, 16:58:28
    Author     : Gonzalo
--%>

<%@page import="eventaw.entity.Conversacion"%>
<%@page import="java.util.List"%>
<%@page import="eventaw.entity.Usuario"%>
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
    <%
        Usuario user = (Usuario) session.getAttribute("user");
        List<Conversacion> chats = (List<Conversacion>) request.getAttribute("chats");
        List<Conversacion> todosChats = (List<Conversacion>) request.getAttribute("todosChats");
        String borrar = "borrar";
    %>
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a class="active">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
            </ul> 
        </div>

        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white">
            <div class="bg-text">
                <div class="container">
                    <h1 style="font-size: 4rem"> Bienvenido de nuevo, </h1>
                    <h2 style="font-size: 3rem"> teleoperador</h2>
                    <a class="btn btn-primary btn-xl rounded-pill mt-5" href="#ancla">Ver conversaciones</a>
                </div>
            </div>
        </header>

        <!-- CONVERSACIONES  -->
        <section id="usuarios" class="m-t-30">
        <div class="container">
            <form action="ServletTeleoperador">
            <div class="row">
                <div class="col-4">
                            <h1 class="bg-text" style=" color:#b997f6;"> Conversaciones: </h1>
                </div>
                <%
                    if(!todosChats.isEmpty()) {
                    %>
                <div class="col-4 wrap-input2 offset-2">
                            <input class="input2" type="text" placeholder="Introduzca el filtro..." name="filtradoUsuario"/> 
                </div>
                <div class="col-2">
                            <div class="wrap-login100-form-btn">
                                <div class="botones-pag"></div>
                                <button class="login100-form-btn" value="Filtrar" >
                                    FILTRAR
                                </button>
                            </div>                    
                        </div>
                <% } %>
            </div>
            </form>
        </div>
       </section> 
        

        <!-- TABLA CONVERSACIONES -->
        <div class="container m-t-20">
            <%
                if(todosChats.isEmpty()) { %>
                <div class="row text-center">
                <div class="col bg-text" style="color:#9e9e9e"> Actualmente no tienes conversaciones. </div>
                </div>
             <%   } else { %>
              
            <table class="center table table-striped align-middle" id="tabla-custom">
                <tr>
                    <th>Teleoperador</th>
                    <th>Usuario</th>
                    <th></th>
                    <th></th>
                </tr>
                <%
                    for (Conversacion c : chats) {
                %>
                <tr>
                    <td><%= c.getTeleoperador().getCorreo()%></td>
                    <td><%= c.getUsuario().getCorreo()%></td>
                    <td><a class="btn  btn-primary" href="ServletRedireccion?id=<%= c.getId()%>">Ver</a></td>
                    <td><a class="btn  btn-primary" href="ServletTeleoperador?id=<%= c.getId()%>&borrar=<%= borrar%>">Eliminar</a></td>
                </tr>
                <%
                    }
                %>
            </table>
                  
               <% }
                %>
        </div>        

    </body>
</html>
