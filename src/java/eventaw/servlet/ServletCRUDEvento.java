/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.EventoFacade;
import eventaw.dao.UsuarioFacade;
import eventaw.entity.Evento;
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
 * @author Gonzalo
 */
@WebServlet(name = "ServletCRUDEvento", urlPatterns = {"/ServletCRUDEvento"})
public class ServletCRUDEvento extends HttpServlet {


    @EJB
    private EventoFacade eventoFacade;



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
        
        Evento evento = null;
        String error = "";
        
        String borrar = request.getParameter("borrar");
        String id = request.getParameter("id");
        
        if(borrar!=null){
            if(borrar.equals("borrado")){
                Integer eID = new Integer(id);
                evento = this.eventoFacade.find(eID);
                this.eventoFacade.remove(evento);
                response.sendRedirect("ServletListadoAdmin");
            }
        }else{
            if(id != null){
                Integer eID = new Integer(id);
                evento = this.eventoFacade.find(eID);
            }
            request.setAttribute("evento", evento);
            request.setAttribute("error", error);

            RequestDispatcher rd = request.getRequestDispatcher("formularioEvento.jsp");
            rd.forward(request, response);
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
