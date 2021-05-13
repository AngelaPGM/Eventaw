<%-- 
    Document   : perfilUsuario
    Created on : 13-may-2021, 18:10:06
    Author     : angep
--%>

<%@page import="eventaw.entity.Usuarioevento"%>
<%@page import="eventaw.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Modificar perfil</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <%
        Usuario user = (Usuario) session.getAttribute("user");
        Usuarioevento uEvento = (Usuarioevento) user.getUsuarioevento();
    %>
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a href="inicio.jsp">Inicio</a></li>
                <li style="float:right"><a href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a class="active" href="perfilUsuario.jsp">Mi perfil</a></li>
                <li style="float:right"><a href="misEntradas.jsp">MIS ENTRADAS</a></li>
            </ul> 
        </div>
        <div class="fondo-pagina">
            <div class="container-registro">
                <div class="wrap-registro">
                    <form class="register-form" method="POST" action="">
                        <span class="login-form-title">                       
                            Modificar perfil
                        </span>

                        <hr/>

                        <div class="row justify-content-around p-t-5">
                            <div class="col-3 text-center">Nombre:</div>
                            <div class="col-4 text-center">Primer apellido:</div>
                            <div class="col-4  text-center">Segundo apellido: </div>
                        </div>
                        <div class="row p-b-20 justify-content-around">
                            <div class="row p-b-20 justify-content-around">
                                <div class="col-3 wrap-input2">
                                    <input class="input2" type="text" name="nombre" value="<%= uEvento.getNombre() %>" required>
                                </div>
                                <div class="col-4 wrap-input2  ">
                                    <input class="input2" type="text" name="ape1" required>
                                </div>
                                <div class="col-4 wrap-input2 ">
                                    <input class="input2" type="text" name="ape2">
                                </div>
                            </div>
                    </form>
                </div>
            </div>

        </div>
    </body>
</html>
