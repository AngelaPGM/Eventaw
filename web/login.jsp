<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de sesión</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/util.css">
</head>

<body>
    <div class="fondo-login">
        <div class="container-login">
            <div class="wrap-login">
                <%
                    String errorLog;
                    
                    errorLog = (String)request.getAttribute("errorLog");
                    if(errorLog == null) errorLog = "";
                %>
                <form class="login-form" action="ServletLogin">

                    <span class="login-form-title p-b-35">
                        <img class="img-zoom" src="images/Eventaw.png" alt="Logo" style="width: 60%;"><br>
                        Inicia sesión
                    </span>

                    <div class="wrap-input100 ">
                        Email:<br>
                        <input class="input100" type="text" name="email" required>
                    </div>

                    <div class="wrap-input100 m-t-30 m-b-30">
                        Contraseña:<br>
                        <input class="input100" type="password" name="pass" required>
                    </div>
                    
                    <%= errorLog %>
                    
                    <div class="container-login100-form-btn p-b-10">
                        <div class="wrap-login100-form-btn">
                            <div class="login100-form-bgbtn"></div>
                            <button class="login100-form-btn">
                                Acceder
                            </button>
                        </div>
                    </div>
                    <div class="text-center p-t-8">
                        ¿No tienes cuenta?
                        <a href="registroUsuario.jsp" class="txt2">
                            REGÍSTRATE AQUÍ
                        </a>
                    </div>
                </form>

            </div>
        </div>
    </div>
</body>

</html>
