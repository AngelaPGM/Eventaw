/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.AnalisisFacade;
import eventaw.dao.EventoFacade;
import eventaw.entity.Analisis;
import eventaw.entity.Evento;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author rafa
 */
@WebServlet(name = "ServletEditarAnalisis", urlPatterns = {"/ServletEditarAnalisis"})
public class ServletEditarAnalisis extends HttpServlet {

    @EJB
    private AnalisisFacade analisisFacade;

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
        
        String id = request.getParameter("id");
        List<Evento> listaEventos = null;
        
        if(id != null){ //Editar
            Analisis a = this.analisisFacade.find(new Integer(id));
            request.setAttribute("analisis", a);
        
            listaEventos = this.eventoFacade.eventosPorFiltro(a.getFechamayor(), a.getFechamenor(), a.getFechaigual(), a.getPreciomayor(), a.getPreciomenor(), a.getPrecioigual(), a.getCiudadevento());
        }
        
        if(listaEventos == null){
            listaEventos = this.eventoFacade.findAll();
        }
        request.setAttribute("listaEventos", listaEventos);

        
        //GET ANYOS
        List<Evento> aux = this.eventoFacade.findAll();
        List<Integer> anyos = null;
        for(Evento e: aux){
            anyos.add(e.getFecha().getYear());
        }
        request.setAttribute("anyos", anyos);
                
        RequestDispatcher rd = request.getRequestDispatcher("analisis.jsp");
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
