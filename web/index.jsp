<%-- 
    Document   : index
    Created on : 16-mar-2021, 18:28:47
    Author     : guzman
--%>

<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="eventaw.entity.Mensaje"%>
<%@page import="eventaw.entity.Conversacion"%>
<%@page import="eventaw.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Chat teleoperador</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <%
        Conversacion c = (Conversacion) request.getAttribute("c");
        Usuario user = (Usuario) session.getAttribute("user");
        List<Mensaje> mensajes = (List<Mensaje>) request.getAttribute("m");

        String inicio = "";
        if (user.getRol().getId() == 2) { //usuarioevento
            inicio = "ServletRedirectInicio";
        } else if (user.getRol().getId() == 3) { //creador
            inicio = "ServletListadoEventos";
        } else if (user.getRol().getId() == 4) { //teleoperador
            inicio = "ServletTeleoperador";
        }
    %>
    <body onload="getMessages();">
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>                
                <li><a href="<%= inicio%> ">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                    <%
                        if (user.getRol().getId() == 3) {%>
                <li style="float:right"><a href="ServletCrudUsuario?id=<%= user.getId()%>">Mi perfil</a></li>
                    <%   } else if (user.getRol().getId() == 2) { %>
                <li style="float:right"><a href="perfilUsuario.jsp?editar=0">Mi perfil</a></li>
                <li style="float:right"><a href="misEntradas.jsp?filtrado=0">MIS ENTRADAS</a></li>
                    <% }
                    %>
                <li style="float:right"><a class="active">CHAT TELEOPERADOR</a></li>
            </ul> 
        </div>

        <div class="fondo-pagina">
            <div class="container-perfil">
                <div class="wrap-registro justify-content-center" style=" margin-top: 3%">
                    <span class="login-form-title m-t-20">                       
                        Conversaci&oacute;n
                    </span>                                                             
                    <form class="login-form">
                        <%
                            if (user.getId() == c.getUsuario().getId() || user.getId() == c.getTeleoperador().getId()) {
                        %>
                        <input type="hidden" id="id" name="id" value="<%= c.getId()%>"/>
                        <input type="hidden" id="name" name="name" value="<%= user.getCorreo()%>"/>
                        <div class="row">
                            <div class="col-9">
                                <div class="wrap-input100">                               
                                    <input class="input100" type="text" id="message" name="message" placeholder="Escribe un mensaje aqu&iacute;" />
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="wrap-login100-form-btn">
                                    <div class="botones-pag"></div>
                                    <a class="login100-form-btn" type="button" style="text-decoration: none"  onclick="postMessage();" value="Enviar" />Enviar</a></div>
                            </div> 
                        </div>  

                        <%
                            }
                        %>
                        <div id="content">
                            <% if (application.getAttribute("messages") != null) {%>
                            <div class="row" style="padding-top: 10px"> <%= application.getAttribute("messages")%> </div>                      
                            <% }%>
                        </div>

                        <script>
                            function postMessage() {
                                var xmlhttp = new XMLHttpRequest();
                                //xmlhttp.open("POST", "shoutServlet?t="+new Date(), false);
                                xmlhttp.open("POST", "shoutServlet", false);
                                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                var idText = escape(document.getElementById("id").value);
                                var nameText = escape(document.getElementById("name").value);
                                var messageText = escape(document.getElementById("message").value);
                                document.getElementById("message").value = "";
                                xmlhttp.send("id=" + idText + "&name=" + nameText + "&message=" + messageText);
                            }
                            var messagesWaiting = false;
                            function getMessages() {
                                if (!messagesWaiting) {
                                    messagesWaiting = true;
                                    var xmlhttp = new XMLHttpRequest();
                                    xmlhttp.onreadystatechange = function () {
                                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                            messagesWaiting = false;
                                            var contentElement = document.getElementById("content");
                                            contentElement.innerHTML = xmlhttp.responseText + contentElement.innerHTML;
                                        }
                                    }
                                    //xmlhttp.open("GET", "shoutServlet?t="+new Date(), true);
                                    xmlhttp.open("GET", "shoutServlet", true);
                                    xmlhttp.send();
                                }
                            }
                            setInterval(getMessages, 1000);
                        </script>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>