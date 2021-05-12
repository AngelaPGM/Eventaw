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
        <form method="POST" action="ServletCrudUsuario">
        
        <h1>Lista de Usuarios.</h1>
        <% List<Usuario> ListaUsuario = (List)request.getAttribute("listaUsuario");
           String borrar = "borrado";
           
           for(Usuario u : ListaUsuario){
           
        %>
        Id:<%= u.getId()%> Email: <%= u.getCorreo()%> Contraseña: <%= u.getContrasenya()%> Rol: <%= u.getRol().getTipo() %> <a href ="ServletCrudUsuario?id=<%=u.getId()%>"> Editar </a>&nbsp; <a href ="ServletCrudUsuario?id=<%=u.getId()%>&borrar=<%=borrar%>"> Borrar </a> <br/>
        <% 
           }
        
        %>
        </form>
    </body>
</html>
