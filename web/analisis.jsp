<%-- 
    Document   : analisis
    Created on : 07-may-2021, 0:38:45
    Author     : rafa
--%>

<%@page import="eventaw.entity.Analisis"%>
<%@page import="eventaw.entity.Entrada"%>
<%@page import="eventaw.entity.Evento"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        List<Evento> listaEventos = (List) request.getAttribute("listaEventos");
        List<Entrada> listaEntradas = (List) request.getAttribute("listaEntradas");
        List<Integer> anyos = (List) request.getAttribute("anyos");

        //Si estamos editando un analisis recuperamos los datos
        Analisis a = (Analisis) request.getAttribute("analisis");
        String nombreA = "";
        String servlet;
        if(a != null){
            nombreA = a.getNombre();
            servlet = "ServletGuardarAnalisis?id="+a.getAnalisisid();
        }else{
            servlet = "ServletGuardarAnalisis";
        }
        String str = "";
        %>
    <body>
        Eventos
        <table border="1">
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
                    for(Entrada e: listaEntradas){
                    %>
                <tr>
                    <td></td>
                    <td><%= e.getEvento().getCiudad() %></td>
                    <td><%= e.getEvento().getFecha() %></td>
                    <td><%= e.getEvento().getPrecio() %></td>
                    <td></td>
                    <td><%= e.getUsuario().getCiudad() %></td>
                    <td><%= e.getUsuario().getFechanacimiento() %></td>
                    <td><%= e.getUsuario().getSexo() %></td>
                </tr>
                <%
                    }
                    %>
            </tbody>
        </table>
            <br>
            <form method="POST" action="<%= servlet %>">
            Analisis: <input type="text" name="nombreAnalisis" value="<%= nombreA %>" />
            <br>
            Filtros evento
            <br>
            Fecha >
            <select name="fechaMayor">
                <option>---</option>
                <%
                    for(Integer i: anyos){
                    %>
                    <option><%=  i.intValue() %></option>
                <%
                    }
                    %>
            </select>
            <br>
            Fecha <
            <select name="fechaMenor">
                <option>---</option>
                <%
                    for(Integer i: anyos){
                        if(a!=null && i.equals(a.getFechamenor()) ){
                            str = "selected";
                        }
                    %>
                    <option <%=str%> ><%= i.intValue() %></option>
                <%
                    }
                    %>
            </select>
            <br>
            Fecha =
            <select name="fechaIgual">
                <option>---</option>
                <%
                    for(Integer i: anyos){
                    %>
                    <option><%= i.intValue() %></option>
                <%
                    }
                    %>
            </select>
            <br>
            Precio >
            <input type="number" name="precioMayor" value="" />
            <br>
            Precio <
            <input type="number" name="precioMenor" value="" />
            <br>
            Precio =
            <input type="number" name="precioIgual" value="" />
            <br>
            Ciudad
             <select name="fechaMayor">
                <option>---</option>
                <%
                    for(Evento e: listaEventos){
                    %>
                    <option><%=  e.getCiudad() %></option>
                <%
                    }
                    %>
            </select>
            <br>
            Filtros usuario
            <br>
            Edad >
            <input type="number" name="edadMayor" value="" />
            <br>
            Edad <
            <input type="number" name="edadMenor" value="" />
            <br>
            Edad =
            <input type="number" name="edadIgual" value="" />
            <br>
            <input type="radio" id="male" name="sexo" value="H">
            <label for="male">H</label>
            <input type="radio" id="female" name="sexo" value="M">
            <label for="female">M</label>
            <br>
            <input type="submit" value="Guardar analisis" />
        </form>
    </body>
    
</html>
