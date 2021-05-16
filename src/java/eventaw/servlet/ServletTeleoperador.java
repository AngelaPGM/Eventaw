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
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gonzalo
 */
@WebServlet(name = "ServletTeleoperador", urlPatterns = {"/ServletTeleoperador"})
public class ServletTeleoperador extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

    @EJB
    private MensajeFacade mensajeFacade;


    @EJB
    private ConversacionFacade conversacionFacade;

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
        
        List<Conversacion> chats = null;
        
        String id = (String)request.getParameter("id");
        String borrar = (String)request.getParameter("borrar");
        String filtro = (String)request.getParameter("filtro");
        
        if(borrar != null && borrar.equals("borrar")){
            Conversacion c = this.conversacionFacade.find(new Integer(id));
            for(Mensaje m : c.getMensajeList()){
                this.mensajeFacade.remove(m);
            }
            this.conversacionFacade.remove(c);
            Usuario u = c.getUsuario();
            Usuario to = c.getTeleoperador();
            List<Conversacion> lu = u.getConversacionList();
            lu.remove(c);
            u.setConversacionList(lu);
            List<Conversacion> lto = to.getConversacionList();
            lto.remove(c);
            to.setConversacionList(lto);
            this.usuarioFacade.edit(u);
            this.usuarioFacade.edit(to);
        }
        
        if(filtro != null){
            chats = this.conversacionFacade.findByCorreo(filtro);
        }
        
        if(chats == null){
            chats = this.conversacionFacade.findAll();
        }
        
        request.setAttribute("chats", chats);
        request.setAttribute("todosChats", this.conversacionFacade.findAll());
        
        RequestDispatcher rd = request.getRequestDispatcher("teleoperador.jsp");
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
