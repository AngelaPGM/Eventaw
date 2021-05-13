/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.RolFacade;
import eventaw.dao.UsuarioFacade;
import eventaw.dao.UsuarioeventoFacade;
import eventaw.entity.Rol;
import eventaw.entity.Usuario;
import eventaw.entity.Usuarioevento;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author angep
 */
@WebServlet(name = "ServletRegistroUsuarioEvento", urlPatterns = {"/ServletRegistroUsuarioEvento"})
public class ServletRegistroUsuarioEvento extends HttpServlet {

    @EJB
    private UsuarioeventoFacade usuarioeventoFacade;

    @EJB
    private UsuarioFacade usuarioFacade;

    @EJB
    private RolFacade rolFacade;

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
        String errorLog = "";
        String url = "";
        String email = new String(request.getParameter("email").getBytes("ISO-8859-1"), "UTF8");
        String pass1 = new String(request.getParameter("pass1").getBytes("ISO-8859-1"), "UTF8");
        String pass2 = new String(request.getParameter("pass2").getBytes("ISO-8859-1"), "UTF8");

        if (this.usuarioFacade.findByEmail(email) != null) {
            errorLog = "Este email ya ha sido registrado. Inicie sesion.";
            url = "registroUsuario.jsp";
        } else if (!pass1.equals(pass2)) {
            errorLog = "Las contraseñas no coinciden";
            url = "registroUsuario.jsp";
        } else {
            //CREACION USUARIO
            Usuario user = new Usuario();
            user.setId(0);

            user.setContrasenya(pass1);
            user.setCorreo(email);

            Rol rolUsuario = this.rolFacade.find(2);
            user.setRol(rolUsuario);

            //CREACION USUARIO EVENTO
            Usuarioevento uEvento = new Usuarioevento();
            uEvento.setId(0);
            uEvento.setNombre(new String(request.getParameter("nombre").getBytes("ISO-8859-1"), "UTF8"));
            uEvento.setApellido1(new String(request.getParameter("ape1").getBytes("ISO-8859-1"), "UTF8"));

            String ape2 = new String(request.getParameter("ape2").getBytes("ISO-8859-1"), "UTF8");
            if (!("".equals(ape2))) {
                uEvento.setApellido2(ape2);
            } else {
                uEvento.setApellido2("");
            }

            uEvento.setDomicilio(new String(request.getParameter("domicilio").getBytes("ISO-8859-1"), "UTF8"));
            uEvento.setCiudad(new String(request.getParameter("ciudad").getBytes("ISO-8859-1"), "UTF8"));
            String fecha = request.getParameter("fNac");

            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");

            try {
                uEvento.setFechanacimiento(formato.parse(fecha));
            } catch (ParseException ex) {
                Logger.getLogger(ServletRegistroUsuarioEvento.class.getName()).log(Level.SEVERE, null, ex);
            }

            uEvento.setSexo(request.getParameter("sexo"));
            uEvento.setIdusuario(user);
            

            this.usuarioFacade.create(user);
            this.usuarioeventoFacade.create(uEvento);
            
            user.setUsuarioevento(uEvento);
            this.usuarioFacade.edit(user);

            url = "ServletLogin?email=" + email + "&pass=" + pass1;

        }

        request.setAttribute("errorLog", errorLog);

        RequestDispatcher rd = request.getRequestDispatcher(url);
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
