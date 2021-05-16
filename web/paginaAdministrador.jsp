<%-- 
    Document   : PaginaAdministrador
    Created on : 12-may-2021, 11:06:06
    Author     : Fran
--%>

<%@page import="eventaw.entity.Etiqueta"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="eventaw.entity.Evento"%>
<%@page import="eventaw.entity.Usuario"%>
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
        List<Usuario> ListaUsuario = (List) request.getAttribute("listaUsuario");
        List<Evento> listaEventos = (List) request.getAttribute("listaEventos");
        List<Evento> todosEventos = (List) request.getAttribute("todosEventos");
        Usuario user = (Usuario) session.getAttribute("user");
        
        String borrar = "borrado";
    %>
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a class="active">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a href="ServletCrudUsuario?id=<%= user.getId()%>">Mi perfil</a></li>
            </ul> 
        </div>

        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white">
            <div class="bg-text">
                <div class="container">
                    <h1 style="font-size: 4rem"> Bienvenido de nuevo, </h1>
                    <h2 style="font-size: 3rem"> administrador</h2>
                    <a class="btn btn-primary btn-xl rounded-pill mt-5" href="#usuarios">Ver usuarios</a><br/>
                    <a class="btn btn-primary btn-xl rounded-pill mt-3" href="#usuarios">Ver eventos</a>
                </div>
            </div>
        </header>

        <!-- USUARIOS  -->
        <section id="usuarios">
            <div class="container m-t-30">
                <div class="row">
                    <div class="col-sm-10 col-md-7">
                        <h1 class="bg-text" style=" color:#b997f6;"> Usuarios: </h1>
                    </div>
                </div>
                <form action="ServletListadoAdmin">
                    <div class="row m-t-10">
                        <div class="col-2">
                            <div class="wrap-login100-form-btn">
                                <div class="botones-pag"></div>
                                <a class="login100-form-btn" style="text-decoration: none" href="ServletCrudUsuario" >
                                    Nuevo usuario
                                </a>
                            </div>                    
                        </div>
                        <div class="col-5 wrap-input2 offset-2">
                            <input class="input2" type="text" placeholder="Introduzca el filtro..." name="filtradoUsuario"/> 
                        </div>
                        <div class="col-1">
                            <select name="tipofiltrado" class="custom-select">
                                <option value="id">ID</option> 
                                <option value="email">EMAIL</option>
                                <option value="rol">ROL</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <div class="wrap-login100-form-btn">
                                <div class="botones-pag"></div>
                                <button class="login100-form-btn" value="FiltrarUsuario" >
                                    FILTRAR
                                </button>
                            </div>                    
                        </div>
                    </div>
                </form>
            </div>
        </section>   

        <!-- TABLA USUARIOS -->
        <div class="container m-t-20">
            <table class="center table table-striped align-middle" id="tabla-custom">
                <tr>
                    <th>ID</th>
                    <th>EMAIL</th>
                    <th>CONTRASEÑA</th>
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
                    <td><a class="btn  btn-primary" href="ServletCrudUsuario?id=<%= u.getId()%>">EDITAR</a></td>
                    <%
                        if (user.getId() != u.getId()) {
                    %>
                    <td><a class="btn  btn-primary" href="ServletCrudUsuario?id=<%= u.getId()%>&borrar=<%= borrar%>">BORRAR</a></td>  
                        <%
                        } else {
                        %>
                    <td></td>
                    <%
                        }
                    %>
                </tr>        
                <%
                    }
                %>
            </table>
        </div>


        <!-- EVENTOS  -->  

        <section id="eventos" >
            <div class="container m-t-50">
                <div class="row">
                    <div class="col-sm-10 col-md-7">
                        <h1 class="bg-text" style=" color:#7cc5e5;"> Eventos disponibles: </h1>
                    </div>
                </div>
                <form action="ServletListadoAdmin">
                    <div class="row m-t-10">
                        <div class="col-2">
                            <div class="wrap-login100-form-btn">
                                <div class="botones-pag-azul"></div>
                                <a class="login100-form-btn" style="text-decoration: none" href="ServletCRUDEvento" >
                                    Nuevo evento
                                </a>
                            </div>                    
                        </div>

                        <%
                            if (!todosEventos.isEmpty()) {
                        %>    

                        <div class="col-5 wrap-input2 offset-1">
                            <input class="input2" type="text" placeholder="Introduzca el filtro..." name="filtradoEvento"/> 
                        </div>
                        <div class="col-2" >
                            <select name="tipofiltrado2" class="custom-select">
                                <option value="id">ID</option> 
                                <option value="titulo">TITULO</option>
                                <option value="email">CREADOR</option>
                                <option value="ciudad">CIUDAD</option>
                                <option value="fecha">FECHA</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <div class="wrap-login100-form-btn">
                                <div class="botones-pag-azul"></div>
                                <button class="login100-form-btn" value="FiltrarEvento" >
                                    FILTRAR
                                </button>
                            </div>                    
                        </div>
                </form>
            </div>

        </div>
    </section> 


    <div class="container m-t-20">
        <table class="center table table-striped align-middle" id="tabla-custom2">
            <tr>
                <th>ID</th>
                <th>T&Iacute;TULO</th>
                <th>DESCRIPCI&Oacute;N</th>
                <th>CREADOR</th>
                <th>FECHA</th>  
                <th>CIUDAD</th>
                <th>PRECIO</th>            
                <th>AFORO</th>
                <th>ETIQUETAS</th>
                <th></th>
                <th></th> 
            </tr>        

            <%
                for (Evento e : listaEventos) {
            %>   
            <tr>
                <td><%= e.getId()%></td>
                <td><%= e.getTitulo()%></td>
                <td><%= e.getDescripcion()%></td>
                <td><%= e.getCreador().getCorreo()%></td>
                <td><%= new SimpleDateFormat("dd/MM/yyyy").format(e.getFecha())%></td>  
                <td><%= e.getCiudad()%></td>
                <td>  <%= new DecimalFormat("#0.00").format(e.getPrecio())%>€ </td>
                <td><%= e.getAforo()%></td> 
                <td> <% for(Etiqueta etiqueta: e.getEtiquetaList()) { %>
                            <%= etiqueta.getNombre() %><br/>
                     <%   }
                            %></td>
                <td><a class="btn  btn-primaryazul" href="ServletCRUDEvento?id=<%= e.getId()%>">EDITAR</a></td>
                <td><a class="btn  btn-primaryazul"  href="ServletCRUDEvento?id=<%= e.getId()%>&borrar=<%= borrar%>">BORRAR</a></td> 
            </tr>  

            <%
                }
            %>
        </table>
    </div>
    <%
    } else {
    %>    

    <div class="col offset-2 bg-text" style="color:#9e9e9e"> Actualmente no hay eventos en el sistema. </div>

</div>   
</div>
</section> 
<%
    }
%>
<div class="container p-b-100"></div>
</body>
</html>
