
<%@page import="eventaw.entity.Rol"%>
<%@page import="eventaw.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear Usuario</title>
    </head>
    <body>
        <% String errorCrear = (String) request.getAttribute("errorCrear");
           String errorEditar = (String) request.getAttribute("errorEditar");
           Usuario u = (Usuario) request.getAttribute("u");
           
           if(errorCrear == null){
                errorCrear ="";
            } 
           if(errorEditar == null){
               errorEditar ="";
           }
           if(u == null && errorEditar == ""){
               
             
        %>
           <h1>Rellena los datos del usuario a crear. <h1>
           <form method="POST" action="ServletGuardarUsuario">
           Correo Electronico : <input type="text" name="correo" value="" /> <br/>
           Contraseña: <input type="password" name="contrasenia" value="" /> <br/>
           Repetir Contraseña:  <input type="password" name="contrasenia1" value="" /> <br/>
           Rol: <br/> 
           <input type="radio" name="rol" value="3" /> Creador de Eventos <br/>
           <input type="radio" name="rol" value="1" /> Administrador del Sistema <br/>
           <input type="radio" name="rol" value="4" /> Teleoperadores <br/>
           <input type="radio" name="rol" value="5" /> Analista de Eventos <br/>
           <input type="submit" value="Crear" /> <br/>
           <%= errorCrear %>
        </form>
       
        
           <%
           } else {
                Integer idU = u.getId();
                String correoU = u.getCorreo();
                String contrasenia = u.getContrasenya();
                Rol rolU = u.getRol();
                Integer idRolU = rolU.getId();
           %>
           <h1>Modificación de datos del usuario. <h1>
           <form method="POST" action="ServletGuardarUsuario">
           Id : <input type="text" name="id" value="<%= idU%>" readonly="readonly" /> <br/>
           Correo Electronico : <input type="text" name="correo" value="<%= correoU%>" /> <br/>
           Contraseña: <input type="password" name="contrasenia" value="" /> <br/>
           Repetir Contraseña:  <input type="password" name="contrasenia1" value="" /> <br/>
           Rol: <br/> 
           <% if(idRolU == 3){
           %>
           <input type="radio" name="rol" value="3" checked="checked" /> Creador de Eventos <br/>
           <input type="radio" name="rol" value="1" /> Administrador del Sistema <br/>
           <input type="radio" name="rol" value="4" /> Teleoperadores <br/>
           <input type="radio" name="rol" value="5" /> Analista de Eventos <br/>
           <input type="submit" value="Guardar" /> <br/>
           <%
           }else if(idRolU == 1){
           %>
           <input type="radio" name="rol" value="3" /> Creador de Eventos <br/>
           <input type="radio" name="rol" value="1" checked="checked" /> Administrador del Sistema <br/>
           <input type="radio" name="rol" value="4" /> Teleoperadores <br/>
           <input type="radio" name="rol" value="5" /> Analista de Eventos <br/>
           <input type="submit" value="Guardar" /> <br/>
           
           <%
           }else if(idRolU == 4){
           %>
           <input type="radio" name="rol" value="3" /> Creador de Eventos <br/>
           <input type="radio" name="rol" value="1" /> Administrador del Sistema <br/>
           <input type="radio" name="rol" value="4" checked="checked" /> Teleoperadores <br/>
           <input type="radio" name="rol" value="5" /> Analista de Eventos <br/>
           <input type="submit" value="Guardar" /> <br/>
           <%
           }else{
           %>
           <input type="radio" name="rol" value="3" /> Creador de Eventos <br/>
           <input type="radio" name="rol" value="1" /> Administrador del Sistema <br/>
           <input type="radio" name="rol" value="4" /> Teleoperadores <br/>
           <input type="radio" name="rol" value="5" checked="checked"/> Analista de Eventos <br/>
           <input type="submit" value="Guardar" /> <br/>
           <%
               }
           %>
           <%= errorEditar %>
        </form>

            <%
            }
            %>
        
        
        
        
        
    </body>
</html>
