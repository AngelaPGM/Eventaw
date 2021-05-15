/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.EventoFacade;
import eventaw.entity.Evento;
import eventaw.entity.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
@WebServlet(name = "ServletListadoEventos", urlPatterns = {"/ServletListadoEventos"})
public class ServletListadoEventos extends HttpServlet {

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
       String nombreEvento = request.getParameter("buscador");
       String fechaInicio = request.getParameter("fechaInicio");
       String fechaFinal = request.getParameter("fechaFinal");
       
       List <Evento> listaEvento = new ArrayList<>();
       List <Evento> listaE;
       HttpSession session = request.getSession();
       Usuario usuario = (Usuario) session.getAttribute("user");
       
       
       try{
            if(nombreEvento !=null && nombreEvento.length()>0 && !fechaInicio.equals("") && !fechaFinal.equals("")){//Filtrado
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                
                listaEvento = this.eventoFacade.findByCreatorAndName(usuario.getId(), nombreEvento);
                listaE = this.eventoFacade.findByCreatorAndName(usuario.getId(), nombreEvento);
                
                if(listaE != null && !listaE.isEmpty()){
                    for(Evento e : listaEvento){
                        if(fechaIni.after(e.getFecha()) || fechaFin.before(e.getFecha())){
                            listaE.remove(e);
                        }
                    }
                    listaEvento = listaE;
                }
                
            } else if (nombreEvento !=null && nombreEvento.length()>0 && !fechaInicio.equals("") && fechaFinal.equals("")) {// Nombre y Fecha Inicio
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                
                listaEvento = this.eventoFacade.findByCreatorAndName(usuario.getId(), nombreEvento);
                listaE = this.eventoFacade.findByCreatorAndName(usuario.getId(), nombreEvento);
                
                if(listaE != null && !listaE.isEmpty()){
                    for(Evento e : listaEvento){
                        if(fechaIni.after(e.getFecha())){
                            listaE.remove(e);
                        }
                    }
                    listaEvento = listaE;
                }
                
            } else if(nombreEvento !=null && nombreEvento.length()>0 && fechaInicio.equals("") && !fechaFinal.equals("")) {// Nombre y Fecha Final
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                
                listaEvento = this.eventoFacade.findByCreatorAndName(usuario.getId(), nombreEvento);
                listaE = this.eventoFacade.findByCreatorAndName(usuario.getId(), nombreEvento);
                
                if(listaE != null && !listaE.isEmpty()){
                    for(Evento e : listaEvento){
                        if(fechaFin.before(e.getFecha())){
                            listaE.remove(e);
                        }
                    }
                    listaEvento = listaE;
                }
            } else if(nombreEvento !=null && nombreEvento.length()>0 && fechaInicio.equals("") && fechaFinal.equals("")) {//Solo Nombre
                listaE = this.eventoFacade.findByCreatorAndName(usuario.getId(), nombreEvento);
                if(listaE != null && !listaE.isEmpty()){
                    listaEvento = listaE;
                }
            } else if(nombreEvento == "" && nombreEvento.length()<=0 && !fechaInicio.equals("") && !fechaFinal.equals("")) {// Solo Fechas
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                listaEvento = this.eventoFacade.findByCreator(usuario.getId());
                listaE = this.eventoFacade.findByCreator(usuario.getId());
                for(Evento e : listaEvento){
                    if(fechaIni.after(e.getFecha()) || fechaFin.before(e.getFecha())){
                        listaE.remove(e);
                    }
                }
                listaEvento = listaE;    
            } else if(nombreEvento == "" && nombreEvento.length()<=0 && !fechaInicio.equals("") && fechaFinal.equals("")) {// Solo Fecha Inicio
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                listaEvento = this.eventoFacade.findByCreator(usuario.getId());
                listaE = this.eventoFacade.findByCreator(usuario.getId());
                for(Evento e : listaEvento){
                    if(fechaIni.after(e.getFecha())){
                        listaE.remove(e);
                    }
                }
                listaEvento = listaE;
            } else if(nombreEvento == "" && nombreEvento.length()<=0 && fechaInicio.equals("") && !fechaFinal.equals("")){// Solo Fecha Final
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                listaEvento = this.eventoFacade.findByCreator(usuario.getId());
                listaE = this.eventoFacade.findByCreator(usuario.getId());
                for(Evento e : listaEvento){
                    if(fechaFin.before(e.getFecha())){
                        listaE.remove(e);
                    }
                }
                listaEvento = listaE;
            }else{// Quiero mostrar todos
                listaEvento = this.eventoFacade.findByCreator(usuario.getId());
            
            }
       }catch(Exception e){
            listaEvento = this.eventoFacade.findByCreator(usuario.getId());
       }
       
       request.setAttribute("eventos", listaEvento);
       
       RequestDispatcher rd = request.getRequestDispatcher("inicioCreador.jsp");
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
