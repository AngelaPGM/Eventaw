<%-- 
    Document   : inicioCreador
    Created on : 13-may-2021, 14:09:19
    Author     : Pepe
--%>

<%@page import="eventaw.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Usuario usuario;
            
            usuario = (Usuario) session.getAttribute("user");
        %>
        <h1>Mis Eventos</h1>
        
        <input type="text" name="buscador" value="Buscar Eventos" /> <input type="submit" value="Buscar" name="buscarBoton" />
        <br/>
        <br/>
        
        <table border="1">
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
