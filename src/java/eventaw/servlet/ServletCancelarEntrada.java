/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.EntradaFacade;
import eventaw.dao.EventoFacade;
import eventaw.dao.UsuarioFacade;
import eventaw.entity.Entrada;
import eventaw.entity.Evento;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pepe
 */
@WebServlet(name = "ServletCancelarEntrada", urlPatterns = {"/ServletCancelarEntrada"})
public class ServletCancelarEntrada extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

    @EJB
    private EventoFacade eventoFacade;

    @EJB
    private EntradaFacade entradaFacade;

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
        String idEntrada = request.getParameter("idEntrada");
        Entrada entrada;
        Usuario usuario;
        Evento evento;
        
        entrada = this.entradaFacade.find(new Integer(idEntrada));
        usuario = entrada.getUsuario();
        evento = entrada.getEvento();
        
        usuario.getEntradaList().remove(entrada);
        evento.getEntradaList().remove(entrada);
        
        this.entradaFacade.remove(entrada);
        this.eventoFacade.edit(evento);
        this.usuarioFacade.edit(usuario);
        
        HttpSession session = request.getSession();
        session.setAttribute("user", usuario);
        
        response.sendRedirect("misEntradas.jsp");
        //RequestDispatcher rd = request.getRequestDispatcher("misEntradas.jsp");
        //rd.forward(request, response);
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
