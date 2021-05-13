<%-- 
    Document   : PaginaAdministrador
    Created on : 12-may-2021, 11:06:06
    Author     : Fran
--%>

<%@page import="eventaw.entity.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/util.css">
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a class="active">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="perfil.jsp">Mi perfil</a></li>
            </ul> 
        </div>

        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white">
            <div class="bg-text">
                <div class="container">
                    <h1 style="font-size: 4rem"> Bienvenido de nuevo, </h1>
                    <h2 style="font-size: 3rem"> administrador</h2>
                    <a class="btn btn-primary btn-xl rounded-pill mt-5" href="#!">Ver usuarios</a>

                </div>
            </div>
        </header>
        <h1>Lista de Usuarios</h1>
        <% List<Usuario> ListaUsuario = (List) request.getAttribute("listaUsuario");
            String errores = (String) request.getAttribute("errores");
            String borrar = "borrado";

            if (!ListaUsuario.isEmpty() || (errores != "")) {
        %>
        <form action="ServletListadoAdmin">

            Filtrado:<input type="text" name="filtradoUsuario" />
            <select name="tipofiltrado">
                <option value="id">ID</option> 
                <option value="email">EMAIL</option>
                <option value="rol">ROL</option>
            </select>
            <input type="submit" value="FiltrarUsuario" />
            <form/>
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
                    <td><%= u.getId()%></td>
                    <td><%= u.getCorreo()%></td>
                    <td><%= u.getContrasenya()%></td>            
                    <td><%= u.getRol().getTipo()%></td>      
                    <td><a href="ServletCrudUsuario?id=<%= u.getId()%>">Editar</a></td>
                    <td><a href="ServletCrudUsuario?id=<%= u.getId()%>&borrar=<%= borrar%>">Borrar</a></td>            
                </tr>        
                <%
                    }
                %>
            </table>
            <%
            } else {
            %>    
            <form action="ServletListadoAdmin">

                Filtrado:<input type="text" name="filtradoUsuario" />
                <select name="tipofiltrado">
                    <option>ID</option>
                    <option>EMAIL</option>
                    <option>ROL</option>
                </select>
                <input type="submit" value="FiltrarUsuario" />
                <form/>
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>EMAIL</th>
                        <th>PASSWORD</th>
                        <th>ROL</th>                                   
                    </tr> 

                    <%
                        }
                    %>
                </table>

                <%= errores%> <br/>
                <a href="ServletCrudUsuario">Crear</a> <br/>

                </body>
                </html>
