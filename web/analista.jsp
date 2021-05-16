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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Pagina Administrador</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">


    </head>
    <%
        List<Analisis> listaAnalisis = (List) request.getAttribute("listaAnalisis");

        Usuario a = (Usuario) session.getAttribute("analista");

        if (a != null) {
            String string = a.getCorreo();
            String[] parts = string.split("@");
            if (parts.length > 0) {
                String part1 = parts[0]; // nickname
                String part2 = parts[1]; // @gmail.com
            }
        }

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
                    <h2 style="font-size: 3rem"> analista</h2>
                    <a class="btn btn-primary btn-xl rounded-pill mt-5" href="#usuarios">Ver análisis</a>
                </div>
            </div>
        </header>

        <!-- ANALISIS  -->
        <section id="usuarios">
            <div class="container m-t-30">
                <div class="row justify-content-around">
                    <div class="col-4">
                        <h1 class="bg-text" style=" color:#b997f6;"> Análisis: </h1>
                    </div>
                    <div class="col-3">
                        <div class="wrap-login100-form-btn">
                            <div class="botones-pag"></div>
                            <a class="login100-form-btn" style="text-decoration: none" href="ServletEditarAnalisis" >
                                Crear Análisis
                            </a>
                        </div> 
                    </div>
                </div>
            </div> 
        </div>
    </section>

    <!-- TABLA ANALISIS -->

    <div class="container m-t-20 justify-content-center">
         <% if(!listaAnalisis.isEmpty()) { %>
        <table class="center table table-striped align-middle" id="tabla-custom">
            <tr>
                <th>Análisis</th>
                <th></th>
                <th></th>
            </tr>
            
            <%  
                for (Analisis anal : listaAnalisis) {
            %>
            <tr>
                <td><%= anal.getNombre()%></td>
                <td><a href="ServletEditarAnalisis?id=<%= anal.getAnalisisid()%>">Editar</a></td>
                <td><a href="ServletBorrarAnalisis?id=<%= anal.getAnalisisid()%>">Borrar</a></td>
            </tr>
            <%
                }
            %>
        </table>
        <% } else { %>
        <div class="row text-center m-t-50">
            <span class="bg-text"  style="color:#9e9e9e">
                <h1>A&uacute;n no tienes an&aacute;lisis.</h1>
            </span>
        </div>
        <div class="row text-center">
            <span class="bg-text" style="color:#9e9e9e">
                <h2>Cuando crees uno aparecer&aacute; aqu&iacute;</h2>
            </span>
        </div>
            <%    }
            %>
    </div>
    <div class="container p-b-100"></div>
</body>
</html>
