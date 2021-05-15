<%-- 
    Document   : analista
    Created on : 12-may-2021, 4:07:02
    Author     : rafa
--%>

<%@page import="eventaw.entity.Usuario"%>
<%@page import="eventaw.entity.Analisis"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        List<Analisis> listaAnalisis = (List) request.getAttribute("listaAnalisis");
        
        Usuario a = (Usuario)session.getAttribute("analista");
        
        if(a != null){
            String string = a.getCorreo();
            String[] parts = string.split("@");
            if(parts.length > 0){
                String part1 = parts[0]; // nickname
                String part2 = parts[1]; // @gmail.com
            }
        }
        
        %>
    <body>
        <h1>Bienvenido</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>Analisis</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(Analisis anal: listaAnalisis){
                    %>
                <tr>
                    <td><%= anal.getNombre() %></td>
                    <td><a href="ServletEditarAnalisis?id=<%= anal.getAnalisisid() %>">Editar</a></td>
                    <td><a href="ServletBorrarAnalisis?id=<%= anal.getAnalisisid() %>">Borrar</a></td>
                </tr>
                <%
                    }
                    %>
            </tbody>
        </table>
            <a href="ServletEditarAnalisis">Crear analisis</a>
    </body>
</html>
