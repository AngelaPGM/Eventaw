
<%@page import="eventaw.entity.Rol"%>
<%@page import="eventaw.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Datos Usuario</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <body>

        <%  String errorCrear = (String) request.getAttribute("errorCrear");
            String errorEditar = (String) request.getAttribute("errorEditar");
            Usuario yo = (Usuario) session.getAttribute("user");
            Usuario u = (Usuario) request.getAttribute("u");

            if (errorCrear == null) {
                errorCrear = "";
            }
            if (errorEditar == null) {
                errorEditar = "";
            }

            if (yo.getRol().getId() == 1) {
        %>   
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a href="ServletListadoAdmin">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
                <li style="float:right"><a class="active">Mi perfil</a></li>
            </ul> 
        </div>
        <%
        } else {
        %>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a href="ServletListadoEventos">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>                   
                <li style="float:right"><a class="active">Mi perfil</a></li>
                <%
                    if (yo.getRol().getId() == 3) { %>
                <li style="float:right"><a href="ServletNuevaConversacion">CHAT TELEOPERADOR</a></li>
                    <%  }
                    %>
            </ul> 
        </div>
        <%
            }
        %>
        <div class="fondo-pagina">
            <div class="container-perfil">
                <div class="wrap-registro justify-content-center text-center" >
                    <%
                        if (u == null && errorEditar == "") {
                    %>

                    <form class="register-form" method="POST" action="ServletGuardarUsuario">
                        <h1 class="bg-text">Nuevo Usuario</h1>
                        <%
                            if (errorCrear != "") {%>
                        <div class=" alert alert-danger vertical-align-middle">
                            <strong>¡Error!</strong> <%= errorCrear%> </a>
                        </div>
                        <% }
                        %>
                        <hr/>
                        <div class="row justify-content-around m-t-20">
                            <div class="col-11">
                                Email: <span style="color:#a64bf4">(*)</span>
                            </div>
                        </div>
                        <div class="row justify-content-around">
                            <div class="col-11 wrap-input2">
                                <input class="input2" type="email" name="correo" required>
                            </div>
                        </div>
                        <div class="row justify-content-around m-t-20">
                            <div class="col-5">
                                Contraseña: <span style="color:#a64bf4">(*)</span>
                            </div>
                            <div class="col-5">
                                Repita contraseña: <span style="color:#a64bf4">(*)</span>
                            </div>
                        </div>
                        <div class="row justify-content-around">
                            <div class="col-6  wrap-input2" style="width: 45%;">
                                <input class="input2" type="password" name="contrasenia" required>
                            </div>
                            <div class="col-6  wrap-input2" style="width: 45%;">
                                <input class="input2" type="password" name="contrasenia1" required>
                            </div>
                        </div>
                        <div class="row justify-content-around m-t-20">
                            <div class="col-3 text-center">Rol:<span style="color:#a64bf4"> (*)</span></div>
                        </div>
                        <div class="row justify-content-center" style="line-height: 1.2; height: 50px">
                            <div class="col-6">
                                <select class="custom-select" name="rol" required>
                                    <option disabled selected value>  </option>
                                    <option value="3">Creador de Eventos</option>
                                    <option value="1">Administrador del Sistema</option>
                                    <option value="4">Teleoperadores</option>
                                    <option value="5">Analista de Eventos</option>
                                </select>
                            </div>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-6">
                                <div class="container-login100-form-btn p-t-30 justify-content-center">
                                    <div class="wrap-login100-form-btn">
                                        <div class="login100-form-bgbtn"></div>
                                        <button class="login100-form-btn">
                                            Crear
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>



                    <%
                    } else {
                        Integer idU = u.getId();
                        String correoU = u.getCorreo();
                        String contrasenia = u.getContrasenya();
                        Rol rolU = u.getRol();
                        Integer idRolU = rolU.getId();
                    %>
                    <form class="register-form" method="POST" action="ServletGuardarUsuario?id=<%= idU%>">
                        <h1 class="bg-text">Editar datos</h1>
                        <%
                            if (errorEditar != "") {
                                if (errorEditar.equals("Sus datos han sido modificados correctamente")) {
                        %>
                        <div class=" alert alert-success vertical-align-middle">
                            <strong><%= errorEditar%></strong>
                        </div>
                        <%
                        } else {
                        %>
                        <div class=" alert alert-danger vertical-align-middle">
                            <strong>¡Error!</strong> <%= errorEditar%>
                        </div>
                        <%
                                }
                            }
                        %>
                        <hr/>
                        <div class="row justify-content-around m-t-20">
                            <div class="col-11">
                                Email: <span style="color:#a64bf4">(*)</span>
                            </div>
                        </div>
                        <div class="row justify-content-around">
                            <div class="col-11 wrap-input2">
                                <input class="input2" type="email" name="correo"value="<%= correoU%>"  required>
                            </div>
                        </div>
                        <div class="row justify-content-around m-t-20">
                            <div class="col-5">
                                Contraseña: <span style="color:#a64bf4">(*)</span>
                            </div>
                            <div class="col-5">
                                Repita contraseña: <span style="color:#a64bf4">(*)</span>
                            </div>
                        </div>
                        <div class="row justify-content-around">
                            <div class="col-6  wrap-input2" style="width: 45%;">
                                <input class="input2" type="password" name="contrasenia">
                            </div>
                            <div class="col-6  wrap-input2" style="width: 45%;">
                                <input class="input2" type="password" name="contrasenia1">
                            </div>
                        </div>
                        <%
                            if (yo.getRol().getId() == 1) {
                        %>
                        <div class="row justify-content-around m-t-20">
                            <div class="col-3 text-center">Rol:<span style="color:#a64bf4"> (*)</span></div>
                        </div>
                        <div class="row justify-content-center" style="line-height: 1.2; height: 50px">
                            <div class="col-6">
                                <select class="custom-select" name="rol" required>
                                    <option value="3" <% if (idRolU == 3) { %> selected <% } %>>Creador de Eventos</option>
                                    <option value="1" <% if (idRolU == 1) { %> selected <% } %>>Administrador del Sistema</option>
                                    <option value="4" <% if (idRolU == 4) { %> selected <% } %>>Teleoperadores</option>
                                    <option value="5" <% if (idRolU == 5) { %> selected <% }%>>Analista de Eventos</option>
                                </select>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <div class="row justify-content-center">
                            <div class="col-6">
                                <div class="container-login100-form-btn p-t-30 justify-content-center">
                                    <div class="wrap-login100-form-btn">
                                        <div class="login100-form-bgbtn"></div>
                                        <button class="login100-form-btn">
                                            Guardar
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form> 
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
