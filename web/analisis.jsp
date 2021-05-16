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
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        List<Evento> listaEventos = (List) request.getAttribute("listaEventos");
        List<Entrada> listaEntradas = (List) request.getAttribute("listaEntradas");
        //List<Integer> anyos = (List) request.getAttribute("anyos");

        //Si estamos editando un analisis recuperamos los datos
        Analisis a = (Analisis) request.getAttribute("analisis");
        String nombreA = "";
        String servlet;
        
        //Value
        Date fechaMayor, fechaMenor, fechaIgual;
        Integer precioMayor, precioMenor, precioIgual;
        String ciudad;
        Integer edadMayor, edadMenor, edadIgual;
        String sexo;
        
        if(a != null){  //Editar
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
            <input type="date" name="fechaMayor" value="" />
            <br>
            Fecha <
            <input type="date" name="fechaMenor" value="" />
            <br>
            Fecha =
            <input type="date" name="fechaIgual" value="" />
            <br>
            Precio >
            <input type="number" name="precioMayor" <% if(a != null){%>value="<%= a.getPreciomayor() %>"<%}%> />
            <br>
            Precio <
            <input type="number" name="precioMenor" <% if(a != null){%>value="<%= a.getPreciomenor() %>"<%}%> />
            <br>
            Precio =
            <input type="number" name="precioIgual" <% if(a != null){%>value="<%= a.getPrecioigual() %>"<%}%> />
            <br>
            Ciudad
             <select name="ciudad">
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
            <input type="number" name="edadMayor" <% if(a != null){%>value="<%= a.getEdadmayor() %>"<%}%> />
            <br>
            Edad <
            <input type="number" name="edadMenor" <% if(a != null){%>value="<%= a.getEdadmenor() %>"<%}%> />
            <br>
            Edad =
            <input type="number" name="edadIgual" <% if(a != null){%>value="<%= a.getEdadigual() %>"<%}%> />
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
