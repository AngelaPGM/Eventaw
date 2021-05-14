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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        Conversacion c = (Conversacion)request.getAttribute("c");
        Usuario user = (Usuario) session.getAttribute("user");
        List<Mensaje> mensajes = (List<Mensaje>)request.getAttribute("m");
    %>
    <body onload="getMessages();">
        <h1>Conversación</h1>
        <%
            if(user.getId() == c.getUsuario().getId() || user.getId() == c.getTeleoperador().getId()){
        %>
        <form>
            <table>
                <input type="hidden" id="id" name="id" value="<%= c.getId() %>"/>
                <input type="hidden" id="name" name="name" value="<%= user.getCorreo() %>"/>
                <tr>
                    <td><input type="text" id="message" name="message" /></td>
                </tr>
                <tr>
                    <td><input type="button" onclick="postMessage();" value="Enviar" /></td>
                </tr>
            </table>
        </form>
        <%
            }
        %>
        <div id="content">
            <% if (application.getAttribute("messages") != null) {%>
            <%= application.getAttribute("messages")%>
            <% }%>
        </div>
        <%
            for(Mensaje m : mensajes){
        %>
        <p><b><%= m.getEmisor().getCorreo() %> </b><%= new SimpleDateFormat("dd/MM/yyyy hh:mm").format(m.getFecha()) %><br/>
        <%= m.getContenido() %></p>
        <%
            }
        %>
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
                xmlhttp.send("id="+idText+"&name="+nameText+"&message="+messageText);
            }
            var messagesWaiting = false;
            function getMessages(){
                if(!messagesWaiting){
                    messagesWaiting = true;
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange=function(){
                        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
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
    </body>
</html>