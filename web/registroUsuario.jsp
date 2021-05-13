<%-- 
    Document   : registroUsuario
    Created on : 29-abr-2021, 19:39:39
    Author     : angep
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nuevo usuario</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/util.css">
    </head>
    <%
        String errorLog = (String) request.getAttribute("errorLog");
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
    %>
    <body>
        <div class="fondo-login">
            <div class="container-registro">
                <div class="wrap-registro">
                    <form class="register-form" method="POST" action="ServletRegistroUsuarioEvento">
                        <span class="login-form-title">                       
                           <img class="img-zoom" src="images/Eventaw.png" alt="Logo" style="width: 30%;"><br/>
                            Nueva cuenta
                        </span>

                        <%
                            if (errorLog != null) {%>
                        <div class=" alert alert-danger vertical-align-middle">
                            <strong>Error:</strong> <%= errorLog%> </a>
                        </div>
                        <% }
                        %>

                        <hr/>

                        <div class="row justify-content-around p-t-5">
                            <div class="col-3 text-center">Nombre: <span style="color:#a64bf4">(*)</span></div>
                            <div class="col-4 text-center">Primer apellido: <span style="color:#a64bf4">(*)</span></div>
                            <div class="col-4  text-center">Segundo apellido: </div>
                        </div>
                        <div class="row p-b-20 justify-content-around">
                            <div class="col-3 wrap-input2">
                                <input class="input2" type="text" name="nombre" required>
                            </div>
                            <div class="col-4 wrap-input2  ">
                                <input class="input2" type="text" name="ape1" required>
                            </div>
                            <div class="col-4 wrap-input2 ">
                                <input class="input2" type="text" name="ape2">
                            </div>
                        </div>

                        <div class="row justify-content-around">
                            <div class="col-8 ">Domicilio: <span style="color:#a64bf4">(*)</span></div>
                            <div class="col-3 ">Ciudad: <span style="color:#a64bf4">(*)</span></div>
                        </div>
                        <div class="row justify-content-around p-b-20">
                            <div class="col-8 wrap-input2">
                                <input class="input2" type="text" name="domicilio" required>
                            </div>
                            <div class="col-3 wrap-input2">
                                <input class="input2" type="text" name="ciudad" required>
                            </div>
                        </div>

                        <div class="row justify-content-around">
                            <div class="col-4 text-center">Fecha de nacimiento: <span style="color:#a64bf4">(*)</span></div>
                            <div class="col-3 text-center">Sexo:<span style="color:#a64bf4"> (*)</span></div>
                        </div>
                        <div class="row justify-content-around">

                            <div class="col-4 wrap-input2 ">
                                <input class="input2" type="date" name="fNac" max="<%= formato.format(new Date())%>" required>
                            </div>

                            <div class="col-3">
                                <select class="custom-select" name="sexo" required>
                                    <option disabled selected value>  </option>
                                    <option value="M">Mujer</option>
                                    <option value="H">Hombre</option>
                                </select>
                            </div>
                        </div>

                        <hr/>
                        <div class="row justify-content-around">
                            <div class="col-11">
                                Email: <span style="color:#a64bf4">(*)</span>
                            </div>
                        </div>
                        <div class="row justify-content-around">
                            <div class="col-11 wrap-input2">
                                <input class="input2" type="email" name="email" required>
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
                                <input class="input2" type="password" name="pass1" required>
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
                                            Registrarse
                                        </button>
                                    </div>
                                </div>

                                <div class="text-center p-t-8">
                                    ¿Ya tienes cuenta?
                                    <a href="login.jsp">INICIA SESIÓN AQUÍ</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>

</html>