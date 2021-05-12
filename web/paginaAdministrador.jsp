<%-- 
    Document   : PaginaAdministrador
    Created on : 12-may-2021, 11:06:06
    Author     : Fran
--%>

<%@page import="eventaw.entity.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PaginaAdministrador</title>
    </head>
    <body>
        <h1>Lista de Usuarios.</h1>
        <% List<Usuario> ListaUsuario = (List)request.getAttribute("listaUsuario");
           String borrar = "borrado";
        %>
        <table border="1">
        <tr>
            <th>ID</th>
            <th>EMAIL</th>
            <th>PASSWORD</th>
            <th>ROL</th>            
            <th></th>            
            <th></th>                        
        </tr>        
            
        <%
            for (Usuario u : ListaUsuario) {
        %>   
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getCorreo() %></td>
            <td><%= u.getContrasenya() %></td>            
            <td><%= u.getRol().getTipo() %></td>      
            <td><a href="ServletCrudUsuario?id=<%= u.getId()%>">Editar</a></td>
            <td><a href="ServletCrudUsuario?id=<%= u.getId()%>&borrar=<%= borrar%>">Borrar</a></td>            
        </tr>        
        <%
            }
        %>    
        </table>
    </body>
</html>
