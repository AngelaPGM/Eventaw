/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.ConversacionFacade;
import eventaw.dao.MensajeFacade;
import eventaw.dao.UsuarioFacade;
import eventaw.entity.Conversacion;
import eventaw.entity.Mensaje;
import eventaw.entity.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
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
 * @author Gonzalo
 */
@WebServlet(name = "ServletNuevaConversacion", urlPatterns = {"/ServletNuevaConversacion"})
public class ServletNuevaConversacion extends HttpServlet {

    @EJB
    private MensajeFacade mensajeFacade;

    @EJB
    private ConversacionFacade conversacionFacade;

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
        Usuario u = (Usuario)session.getAttribute("user");
        
        List<Usuario> tvops = this.usuarioFacade.findFiltradoByRol("TELEOPERADOR");
        Integer total = tvops.size();
        Random r = new Random();
        Integer chosen = r.nextInt(total);
        Usuario to = tvops.get(chosen);
        
        Conversacion c = new Conversacion();
        c.setUsuario(u);
        c.setTeleoperador(to);
        this.conversacionFacade.create(c);
        
        List<Mensaje> mensajes = new ArrayList<>();
        c.setMensajeList(mensajes);
        this.conversacionFacade.edit(c);
        
        request.setAttribute("m", mensajes);
        request.setAttribute("c", c);
        
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
        //response.sendRedirect("ShoutServlet");
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
