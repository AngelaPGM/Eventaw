/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.UsuarioFacade;
import eventaw.dao.UsuarioeventoFacade;
import eventaw.entity.Usuario;
import eventaw.entity.Usuarioevento;
import java.io.IOException;
import java.text.SimpleDateFormat;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pepe
 */
@WebServlet(name = "ServletGuardarUsuarioEvento", urlPatterns = {"/ServletGuardarUsuarioEvento"})
public class ServletGuardarUsuarioEvento extends HttpServlet {

    @EJB
    private UsuarioeventoFacade usuarioeventoFacade;

    @EJB
    private UsuarioFacade usuarioFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("user");
        String id = request.getParameter("idUsuario");
        Usuario u;
        Usuarioevento uEvento = new Usuarioevento();
        String nombre = request.getParameter("nombre");
        String ape1 = request.getParameter("ape1");
        String ape2 = request.getParameter("ape2");
        String domicilio = request.getParameter("domicilio");
        String ciudad = request.getParameter("ciudad");
        String fNac = request.getParameter("fNac");
        String sexo = request.getParameter("sexo");
        String email = request.getParameter("email");
        String contrasena = request.getParameter("pass1");
        String repcontrasena = request.getParameter("pass2");
        String errorEditar = "";
        String editar = "0";
        Boolean correoExiste = false;
        Boolean ContrasenaAnterior = false;
         
        
         if(email!= null && !email.isEmpty()){
            u = this.usuarioFacade.findByEmail(email);
            if(usuario.getId().equals(new Integer(id))){
                if(u != null && !u.getCorreo().equals(usuario.getCorreo())){
                    correoExiste =true;
                }
            } else {
                if(u != null && !u.getCorreo().equals(this.usuarioFacade.find(new Integer(id)).getCorreo())){
                    correoExiste =true;
                }
            }
         }
            
        if (correoExiste) {
                errorEditar = "Este correo ya ha sido registrado, por favor pruebe con otro.";
                uEvento = this.usuarioFacade.find(new Integer(id)).getUsuarioevento();
                if(!usuario.getId().equals(new Integer(id))){
                    editar = "1";
                }
        }else{ //Si no hay errores hacemos esto.
            if(!contrasena.equals("") && !repcontrasena.equals("")){
                
                if(contrasena.equals(usuario.getContrasenya()) && contrasena.length()!=0){
                    ContrasenaAnterior = true;
                }
                
                if (!(contrasena.equals(repcontrasena))){ // Contraseñas distintas.
                    errorEditar = "Las contraseñas deben ser iguales.";
                   
                }else if(ContrasenaAnterior) {
            
                    errorEditar = "Es la misma contraseña que tenias antes, por favor crea una nueva.";
        
                } else {
                    try{
                        if(usuario.getId().equals(new Integer(id))){
                            uEvento = usuario.getUsuarioevento();
                            usuario.setCorreo(email);
                            usuario.setContrasenya(contrasena);
                            this.usuarioFacade.edit(usuario);
                            session.setAttribute("user", usuario);
                        } else {
                            Usuario aux = this.usuarioFacade.find(new Integer(id));
                            uEvento = aux.getUsuarioevento();
                            aux.setCorreo(email);
                            aux.setContrasenya(contrasena);
                            this.usuarioFacade.edit(aux);
                            editar = "1";
                        }
                        uEvento.setApellido1(ape1);
                        uEvento.setApellido2(ape2);
                        uEvento.setCiudad(ciudad);
                        uEvento.setDomicilio(domicilio);
                        uEvento.setFechanacimiento(new SimpleDateFormat("yyyy-MM-dd").parse(fNac));
                        uEvento.setNombre(nombre);
                        uEvento.setSexo(sexo);
                
                        
                        this.usuarioeventoFacade.edit(uEvento);
                        
                    } catch (Exception e){
                        errorEditar = "Error en la fecha: " + e.getMessage();
                    }
                }
            } else if(contrasena.equals("") && !repcontrasena.equals("")) {
                errorEditar = "Introduzca su nueva contraseña en ambos campos";
                uEvento = this.usuarioFacade.find(new Integer(id)).getUsuarioevento();
                if(!usuario.getId().equals(new Integer(id))){
                    editar = "1";
                }
            } else if(!contrasena.equals("") && repcontrasena.equals("")) {
                errorEditar = "Introduzca su nueva contraseña en ambos campos";
                uEvento = this.usuarioFacade.find(new Integer(id)).getUsuarioevento();
                if(!usuario.getId().equals(new Integer(id))){
                    editar = "1";
                }
            } else {//No cambiar contraseña
                try{
                    if(usuario.getId().equals(new Integer(id))){
                        uEvento = usuario.getUsuarioevento();
                        usuario.setCorreo(email);
                        
                        this.usuarioFacade.edit(usuario);
                        session.setAttribute("user", usuario);
                    } else {
                        Usuario aux = this.usuarioFacade.find(new Integer(id));
                        uEvento = aux.getUsuarioevento();
                        aux.setCorreo(email);
                        this.usuarioFacade.edit(aux);
                        editar = "1";
                    }
                    
                    uEvento.setApellido1(ape1);
                    uEvento.setApellido2(ape2);
                    uEvento.setCiudad(ciudad);
                    uEvento.setDomicilio(domicilio);
                    uEvento.setFechanacimiento(new SimpleDateFormat("yyyy-MM-dd").parse(fNac));
                    uEvento.setNombre(nombre);
                    uEvento.setSexo(sexo);
                
                    this.usuarioeventoFacade.edit(uEvento);
                   
                } catch (Exception e){
                    errorEditar = "Error en la fecha: " + e.getMessage();
                }
            } 
        }
        request.setAttribute("u", uEvento.getIdusuario());
        request.setAttribute("errorEditar", errorEditar);
        RequestDispatcher rd = request.getRequestDispatcher("perfilUsuario.jsp?editar=" + editar);
        rd.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
