<%-- 
    Document   : analisis
    Created on : 07-may-2021, 0:38:45
    Author     : rafa
--%>

<%@page import="java.util.Date"%>
<%@page import="eventaw.entity.Analisis"%>
<%@page import="eventaw.entity.Entrada"%>
<%@page import="eventaw.entity.Evento"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Analisis</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/util.css">
    <%
        List<Evento> listaEventos = (List) request.getAttribute("listaEventos");
        List<Entrada> listaEntradas = (List) request.getAttribute("listaEntradas");
        //List<Integer> anyos = (List) request.getAttribute("anyos");

        //Si estamos editando un analisis recuperamos los datos
        Analisis a = (Analisis) request.getAttribute("analisis");
        String nombreA = "";
        String servlet;
        
        Date fechaMayor, fechaMenor, fechaIgual;
        Integer precioMayor, precioMenor, precioIgual;
        String ciudad;
        Integer edadMayor, edadMenor, edadIgual;
        String sexo;
        
        if (a != null) {
            nombreA = a.getNombre();
            servlet = "ServletGuardarAnalisis?id="+a.getAnalisisid();
            
            fechaMayor = a.getFechamayor();
            fechaMenor = a.getFechamenor();
            fechaIgual = a.getFechaigual();
            precioMayor = a.getPreciomayor();
            precioMenor = a.getEdadmenor();
            precioIgual = a.getPrecioigual();
            //ciudad
            edadMayor = a.getEdadmayor();
            edadMenor = a.getEdadmenor();
            edadIgual = a.getEdadigual();
        }else{          //Crear
            servlet = "ServletGuardarAnalisis";
        }
        String str = "";
    %>
    <body>
        <!-- Barra navegacion -->
        <div class="topnav fixed-top">
            <ul>
                <li><a <a href="ServletAnalistaEventos">Inicio</a></li>
                <li style="float:right"><a  href="ServletCierreSesion">Cerrar sesión</a></li>
            </ul> 
        </div>
        <!-- Imagen fondo -->
        <header class="header-inicio text-center text-white" style="height: 30vh">
            <div class="bg-text">
                <div class="container">
                    <h1 style="font-size: 4rem"> An&aacute;lisis </h1>
                </div>
            </div>
        </header>

        <div class="container m-t-30">
            <div class="row"><span class="bg-text" style="font-size: 1.6rem; color:#b997f6">Eventos</span></div>
            <table class="center table table-striped align-middle" id="tabla-custom">
                <thead>
                    <tr>
                        <th>ID Evento</th>
                        <th>Ciudad Evento</th>
                        <th>Fecha</th>
                        <th>Precio</th>
                        <th>ID Comprador</th>
                        <th>Ciudad Comprador</th>
                        <th>Edad</th>
                        <th>Sexo</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Entrada e : listaEntradas) {
                    %>
                    <tr>
                        <td></td>
                        <td><%= e.getEvento().getCiudad()%></td>
                        <td><%= e.getEvento().getFecha()%></td>
                        <td><%= e.getEvento().getPrecio()%></td>
                        <td></td>
                        <td><%= e.getUsuario().getCiudad()%></td>
                        <td><%= e.getUsuario().getFechanacimiento()%></td>
                        <td><%= e.getUsuario().getSexo()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- ANALISIS -->
            <div class="container ">
                <div class="wrap-login" style="width: 100% ">
                    <form class="login-form " method="POST" action="<%= servlet%>">
                        <div class="row">          
                            <div class="col-1 bg-text" style="font-size: 1.6rem; color:#d85ee4; margin-right: 40px">An&aacute;lisis:</div>
                            <div class="col-4 wrap-input">
                                <input class="input100" type="text" name="nombreAnalisis" value="<%= nombreA%>" placeholder="Introduzca un nombre"></div>
                        </div>

                        <div class="row m-t-20"><span class="bg-text" style="font-size: 1.6rem; color:#d85ee4">Filtros evento:</span></div>
                        <div class="row">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Fecha ></div>
                            <div class="col-2 wrap-input2"><input class="input2" type="date" name="fechaMayor" value="" /></div>
                        </div>
                        <div class="row m-t-10">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Fecha <</div>
                            <div class="col-2 wrap-input2"><input class="input2" type="date" name="fechaMenor" value="" /></div>
                        </div>
                        <div class="row m-t-10">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Fecha =</div>
                            <div class="col-2 wrap-input2"><input class="input2" type="date" name="fechaIgual" value="" /></div>
                        </div>
                        <div class="row m-t-10">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Precio ></div>
                            <div class="col-2 wrap-input2"><input class="input2" type="number" name="precioMayor" value="" /></div>
                        </div>
                        <div class="row m-t-10">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Precio ></div>
                            <div class="col-2 wrap-input2"><input class="input2" type="number" name="precioMenor" value="" /></div>
                        </div>
                        <div class="row m-t-10">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Precio =</div>
                            <div class="col-2 wrap-input2"><input class="input2" type="number" name="precioIgual" value="" /></div>
                        </div>
                        <div class="row m-t-10">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Ciudad</div>
                            <div class="col-2"><select class="custom-select" style="padding: 4%" name="ciudad">
                                    <option>---</option>
                                    <%
                                        for (Evento e : listaEventos) {
                                    %>
                                    <option><%=  e.getCiudad()%></option>
                                    <%
                                        }
                                    %>
                                </select></div>
                        </div>

                        <!--FILTROS USUARIO -->
                        <div class="row m-t-30"><span class="bg-text" style="font-size: 1.6rem; color:#d85ee4">Filtros usuario</span></div>

                        <div class="row">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Edad ></div>
                            <div class="col-2 wrap-input2"><input class="input2" type="number" name="edadMayor" value="" /></div>
                        </div>
                        <div class="row  m-t-20">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Edad <</div>
                            <div class="col-2 wrap-input2"><input class="input2" type="number" name="edadMenor" value="" /></div>
                        </div>
                        <div class="row  m-t-20">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Edad =</div>
                            <div class="col-2 wrap-input2"><input class="input2" type="number" name="edadIgual" value="" /></div>
                        </div>
                        <div class="row  m-t-20 ">
                            <div class="col-2" style="font-size: 1.3rem; display:flex; justify-content: flex-end">Sexo</div>
                            <div class="col-2"><input type="radio" id="male" name="sexo" value="H">
                                <label for="male">Hombre</label>
                                <input type="radio" id="female" name="sexo" value="M">
                                <label for="female">Mujer</label></div>
                        </div>
                        <div class="row">
                                <div class="col-3 offset-1">
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


    </body>

</html>
