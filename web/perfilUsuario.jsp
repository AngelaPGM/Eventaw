<%-- 
    Document   : perfilUsuario
    Created on : 13-may-2021, 18:10:06
    Author     : angep
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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

        String errorLog = (String) request.getAttribute("errorLog");
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
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
            <div class="container-perfil">
                <div class="wrap-registro" style=" margin-top: 3%">
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
                                    <input class="input2" type="text" name="nombre" value="<%= uEvento.getNombre()%>" required>
                                </div>
                                <div class="col-4 wrap-input2  ">
                                    <input class="input2" type="text" name="ape1" value="<%= uEvento.getApellido1()%>" required>
                                </div>
                                <div class="col-4 wrap-input2 ">
                                    <input class="input2" type="text" name="ape2" value="<%= uEvento.getApellido2()%>">
                                </div>
                            </div>

                            <div class="row justify-content-around">
                                <div class="col-8 ">Domicilio: </div>
                                <div class="col-3 ">Ciudad: </div>
                            </div>
                            <div class="row justify-content-around p-b-20">
                                <div class="col-8 wrap-input2">
                                    <input class="input2" type="text" name="domicilio" value="<%= uEvento.getDomicilio()%>" required>
                                </div>
                                <div class="col-3 wrap-input2">
                                    <input class="input2" type="text" name="ciudad" value="<%= uEvento.getCiudad()%>" required>
                                </div>
                            </div>

                            <div class="row justify-content-around">
                                <div class="col-4 text-center">Fecha de nacimiento:</div>
                                <div class="col-3 text-center">Sexo:</div>
                            </div>
                            <div class="row justify-content-around p-b-20">

                                <div class="col-4 wrap-input2 ">
                                    <input class="input2" type="date" name="fNac" max="<%= formato.format(new Date())%>" 
                                           value="<%= formato.format(uEvento.getFechanacimiento())%>" required>
                                </div>

                                <div class="col-3">
                                    <select class="custom-select" name="sexo" required>
                                        <%
                                            if (uEvento.getSexo().equals('M')) { %>
                                        <option selected value="M">Mujer</option>
                                        <option value="H">Hombre</option>
                                        <% } else { %>
                                        <option value="M">Mujer</option>
                                        <option selected value="H">Hombre</option>
                                        <% }
                                        %>

                                    </select>
                                </div>
                            </div>

                            <hr/>
                            <div class="row justify-content-around">
                                <div class="col-11">
                                    Email: 
                                </div>
                            </div>
                            <div class="row justify-content-around">
                                <div class="col-11 wrap-input2">
                                    <input class="input2" type="email" name="email" value="<%= user.getCorreo() %>"required>
                                </div>
                            </div>
                            <div class="row justify-content-around m-t-20">
                                <div class="col-5">
                                    Nueva contraseña:
                                </div>
                                <div class="col-5">
                                    Repita nueva contraseña:
                                </div>
                            </div>
                            <div class="row justify-content-around">
                                <div class="col-6  wrap-input2" style="width: 45%;">
                                    <input class="input2" type="password" name="pass1">
                                </div>
                                <div class="col-6  wrap-input2" style="width: 45%;">
                                    <input class="input2" type="password" name="pass2" required>
                                </div>
                            </div>


                            <div class="row justify-content-center">
                                <div class="col-6">
                                    <div class="container-login100-form-btn p-t-30 justify-content-center">
                                        <div class="wrap-login100-form-btn">
                                            <div class="login100-form-bgbtn"></div>
                                            <button class="login100-form-btn">
                                                GUARDAR
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                    </form>
                </div>
            </div>

        </div>
        </div>
    </body>
</html>
