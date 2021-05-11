<%-- 
    Document   : registroUsuario
    Created on : 29-abr-2021, 19:39:39
    Author     : angep
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo usuario</title>
    </head>
    <%
        String errorLog = (String) request.getAttribute("errorLog");
        if (errorLog == null) {
            errorLog = "";
        }
    %>
    <body>
        <h1>Registro nuevo usuario</h1>
        <p style="color:red"><%= errorLog%></p>
        <form method="POST" action="ServletRegistroUsuarioEvento">

            <fieldset style="width:400px">
                <legend>Datos personales</legend>
                ​<label for="nombre"><b>Nombre:</b></label>
                <input type="text" name="nombre" ><br/><br/>

                ​<label for="nombre"><b>Primer apellido:</b></label>
                <input type="text" name="ape1"><br/><br/>
                ​<label for="nombre"><b>Segundo apellido:</b></label>
                <input type="text" name="ape2" ><br/><br/>



                <label for="domicilio"><b>Domicilio:</b></label>
                <input type="text" name="domicilio" ><br/><br/>

                <label for="ciudad"><b>Ciudad:</b></label>
                <input type="text" name="ciudad" ><br/><br/>


                <label for="fNac"><b>Fecha Nacimiento:</b></label>
                <input type="date" name="fNac" ><br/><br/>

                <label for="sexo"><b>Sexo</b></label>
                <select name="sexo" required>
                    <option value="M">Mujer</option>
                    <option value="H">Hombre</option>
                </select><br/>

            </fieldset>
            <br/>
            <fieldset style="width:400px">
                <legend>Datos de la cuenta</legend>
                ​<label for="email"><b>Email</b></label>
                <input type="email" name="email" ><br/><br/>

                <label for="contra1"><b>Contraseña:</b></label>
                <input type="password" name="pass1" ><br/><br/>

                <label for="contra2"><b>Repita contraseña:</b></label>
                <input type="password" name="pass2" ><br/><br/>
            </fieldset><br/>

            <input type="submit" value="Crear cuenta" /><br/><br/>

        </form>

        ¿Ya tienes cuenta?
        <a href="login.jsp">Inicia sesi&oacute;n aqu&iacute;</a>
    </body>
</html>
