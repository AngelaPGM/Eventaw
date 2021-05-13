/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.RolFacade;
import eventaw.dao.UsuarioFacade;
import eventaw.entity.Rol;
import eventaw.entity.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Fran
 */
@WebServlet(name = "ServletGuardarUsuario", urlPatterns = {"/ServletGuardarUsuario"})
public class ServletGuardarUsuario extends HttpServlet {

    @EJB
    private RolFacade rolFacade;

    @EJB
    private UsuarioFacade usuarioFacade;
    
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Usuario u, usuarioEncontrado;
        usuarioEncontrado = null;
        String id = request.getParameter("id");
        String email = request.getParameter("correo");
        String contrasena = request.getParameter("contrasenia");
        String repcontrasena = request.getParameter("contrasenia1");
        String rol = request.getParameter("rol");
        String errorCrear = "";
        String jsp = "";
        
        if((email !="") && (!email.equals(null))){
           usuarioEncontrado = this.usuarioFacade.findByEmail(email);
        }
        if((email == "") || (rol == null) || (repcontrasena.length() == 0) || (contrasena.length() == 0) ){
            
            jsp = "crearEditarUsuario.jsp";
            errorCrear = "Por favor, completa todos los campos.";
            
        }else if (!(contrasena.equals(repcontrasena))){
            
            jsp = "crearEditarUsuario.jsp";
            errorCrear = "Las contraseñas deben ser iguales.";
            
        }else if(!usuarioEncontrado.equals(null)){
            
            jsp = "crearEditarUsuario.jsp";
            errorCrear = "Este correo ya ha sido utilizado.";
        
        }else{
            
            if(id == null || id.isEmpty()){ //Crear
                u = new Usuario();
            }else{//Editar
                u = this.usuarioFacade.find(new Integer(id));
            }
                Rol r = this.rolFacade.find(new Integer(rol));
                u.setCorreo(email);
                u.setContrasenya(contrasena);
                u.setRol(r);
                
            if(id == null || id.isEmpty()){ //Crear
                this.usuarioFacade.create(u);
            }else{ //Editar
                this.usuarioFacade.edit(u);
            }
        }
        
        if(jsp != ""){
        
            request.setAttribute("errorCrear", errorCrear);
            RequestDispatcher rd = request.getRequestDispatcher(jsp);
            rd.forward(request, response);
            
        }else{
            response.sendRedirect("ServletListadoAdmin");
        }
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
