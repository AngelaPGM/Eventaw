<%-- 
    Document   : inicioCreador
    Created on : 13-may-2021, 14:09:19
    Author     : Pepe
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="eventaw.entity.Evento"%>
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
        String borrado = "borrado";
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        Usuario usuario = (Usuario) session.getAttribute("user");

        List<Evento> misEventos;
        misEventos = (List<Evento>) request.getAttribute("eventos");
    %>
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a class="active">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="ServletCrudUsuario?id=<%= usuario.getId()%>">Mi perfil</a></li>
            </ul> 
        </div>
        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white" style="height: 60vh;">
            <div class="bg-text">
                <div class="container">
                    <h1 style="font-size: 4rem"> Bienvenido a Eventaw </h1>
                    <h2 style="font-size: 3rem"> un espacio para tus eventos</h2>
                    <a class="btn btn-primary btn-xl rounded-pill mt-5" href="ServletCRUDEvento">Crear evento</a><br/>
                    <a class="btn btn-primary btn-xl rounded-pill mt-3" href="#eventos">Mis eventos</a>
                </div>
            </div>
        </div>
    </header>          

    <section id="eventos">
        <%
                if (!misEventos.isEmpty()) { %>

        <div class="container m-t-30">
            <div class="row">
                <div class="col-sm-10 col-md-7">
                    <h1 class="bg-text" style=" color:#b997f6;"> Mis eventos: </h1>
                </div>
            </div>

            <form action="ServletListadoEventos">
                <div class="row m-t-10 justify-content-center">
                    <div class="col-5 wrap-input2">
                        <input class="input2" type="text" placeholder="Introduzca el filtro..." name="buscador"/>                           
                    </div>
                    <div class="col-2 wrap-input2 wrap-separacion10" >
                        <input class="input2" type="date" id="start" name="fechaInicio"> 
                    </div>
                    <div class="col-2 wrap-input2 wrap-separacion10" >
                        <input class="input2" type="date" id="start" name="fechaFinal"> 
                    </div>
                    <div class="col-2">
                        <div class="wrap-login100-form-btn">
                            <div class="login100-form-bgbtn"></div>
                            <button class="login100-form-btn" value="Buscar" name="buscarBoton">
                                Buscar
                            </button>
                        </div>                    
                    </div>
                </div>
            </form>
        </div>
    </section>
    <div class="container">
        <table class="center table table-striped align-middle m-t-30" id="tabla-custom">
            <thead>
                <tr style="text-align: center; vertical-align: middle; font-size:1.1rem">
                    <th>NOMBRE</th>
                    <th>DESCRIPCI&Oacute;N</th>
                    <th>CIUDAD</th>
                    <th>FECHA</th>
                    <th>COMPRA HASTA</th>
                    <th>PRECIO</th>
                    <th>AFORO</th>
                    <th>ENTRADAS/USUARIO</th>
                    <th>Nº FILAS</th>
                    <th>ASIENTOS/FILA</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Evento e : misEventos) {
                %>
                <tr style="text-align: center; vertical-align: middle; font-size:1.2rem">
                    <td><%= e.getTitulo()%></td>
                    <td><%= e.getDescripcion()%></td>
                    <td><%= e.getCiudad()%></td>
                    <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getFecha())%></td>
                    <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getFechacompra())%></td>
                    <td><%= e.getPrecio()%></td>
                    <td><%= e.getAforo()%></td>
                    <td><%= e.getMaxentradasusuario()%></td>
                    <td><%= e.getNumfilas()%></td>
                    <td><%= e.getAsientosfila()%></td>
                    <td><a style="color: white" href="ServletCRUDEvento?id=<%= e.getId()%>">EDITAR</a></td>
                    <td><a style="color: white" href="ServletCRUDEvento?id=<%= e.getId()%>&borrar=<%= borrado%>">BORRAR</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <%  } else { %>
    </section>
    <div class="container justify-content-center text-center" style="margin-top: 10vh">
        <h1 class="bg-text" style="color: #9e9e9e; font-size: 3rem">Actualmente no tienes eventos :(</h1>
        <h1 class="bg-text" style="color: #9e9e9e; font-size: 2.5rem">Prueba a crear uno.</h1>
    </div>

<% }
%>
</body>
</html>
