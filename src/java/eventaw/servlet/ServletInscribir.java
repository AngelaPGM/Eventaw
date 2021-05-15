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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
@WebServlet(name = "ServletInscribir", urlPatterns = {"/ServletInscribir"})
public class ServletInscribir extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

    @EJB
    private EntradaFacade entradaFacade;

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
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario)session.getAttribute("user");
        String idevento = request.getParameter("idEvento");
        Integer numEntradas = new Integer(request.getParameter("numEntradas"));
        Evento evento;
        
        evento = this.eventoFacade.find(new Integer(idevento));
        
        for(int i=0; i<numEntradas; i++){
            Entrada entrada = new Entrada();
            
            String asientoSeleccionado = request.getParameter("asiento" + i);
            String[] partes = asientoSeleccionado.split(" ");
            String fila = partes[1];
            String asiento = partes[3];
            
            entrada.setId(0);
            entrada.setUsuario(usuario.getUsuarioevento());
            entrada.setEvento(evento);
            entrada.setNumfila(new Integer(fila));
            entrada.setAsientofila(new Integer(asiento));
            
            this.entradaFacade.create(entrada);
        
            usuario.getUsuarioevento().getEntradaList().add(entrada);
            evento.getEntradaList().add(entrada);
        }
        
        this.eventoFacade.edit(evento);
        this.usuarioFacade.edit(usuario);
        
        List<Evento> eventos = this.eventoFacade.findAll();
        List<Evento> aux = this.eventoFacade.findAll();
        String today = new SimpleDateFormat("dd/MM/yyyy").format(new Date());
        for(Evento e : eventos){
            if(!new SimpleDateFormat("dd/MM/yyyy").format(e.getFecha()).equals(today)){
                if(!e.getFecha().after(new Date())) aux.remove(e);
            }
        }
        eventos = aux;
        
        request.setAttribute("eventos", eventos);
        
        RequestDispatcher rd = request.getRequestDispatcher("inicio.jsp");
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
