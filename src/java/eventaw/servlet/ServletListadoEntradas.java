/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.EntradaFacade;
import eventaw.entity.Entrada;
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
 * @author angep
 */
@WebServlet(name = "ServletListadoEntradas", urlPatterns = {"/ServletListadoEntradas"})
public class ServletListadoEntradas extends HttpServlet {

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
       String nombreEntrada = request.getParameter("buscador");
       String fechaInicio = request.getParameter("fechaInicio");
       String fechaFinal = request.getParameter("fechaFinal");
       
       List <Entrada> listaEntrada = new ArrayList<>();
       List <Entrada> listaE;
       HttpSession session = request.getSession();
       Usuario usuario = (Usuario) session.getAttribute("user");
       
       
       try{
            if(nombreEntrada !=null && nombreEntrada.length()>0 && !fechaInicio.equals("") && !fechaFinal.equals("")){//Filtrado
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                
                listaEntrada = this.entradaFacade.filterByNameAndId(nombreEntrada, usuario.getUsuarioevento().getId());
                listaE = this.entradaFacade.filterByNameAndId(nombreEntrada, usuario.getUsuarioevento().getId());
                
                if(listaE != null && !listaE.isEmpty()){
                    for(Entrada e : listaEntrada){
                        if(fechaIni.after(e.getEvento().getFecha()) || fechaFin.before(e.getEvento().getFecha())){
                            listaE.remove(e);
                        }
                    }
                    listaEntrada = listaE;
                }
                
            } else if(nombreEntrada !=null && nombreEntrada.length()>0 && !fechaInicio.equals("") && fechaFinal.equals("")) {// Nombre y Fecha Inicio
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                
                listaEntrada = this.entradaFacade.filterByNameAndId(nombreEntrada, usuario.getUsuarioevento().getId());
                listaE = this.entradaFacade.filterByNameAndId(nombreEntrada, usuario.getUsuarioevento().getId());
                
                if(listaE != null && !listaE.isEmpty()){
                    for(Entrada e : listaEntrada){
                        if(fechaIni.after(e.getEvento().getFecha())){
                            listaE.remove(e);
                        }
                    }
                    listaEntrada = listaE;
                }
                
            } else if(nombreEntrada !=null && nombreEntrada.length()>0 && fechaInicio.equals("") && !fechaFinal.equals("")) {// Nombre y Fecha Final
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                
                listaEntrada = this.entradaFacade.filterByNameAndId(nombreEntrada, usuario.getUsuarioevento().getId());
                listaE = this.entradaFacade.filterByNameAndId(nombreEntrada, usuario.getUsuarioevento().getId());
                
                if(listaE != null && !listaE.isEmpty()){
                    for(Entrada e : listaEntrada){
                        if(fechaFin.before(e.getEvento().getFecha())){
                            listaE.remove(e);
                        }
                    }
                    listaEntrada = listaE;
                }
                
            } else if(nombreEntrada !=null && nombreEntrada.length()>0 && fechaInicio.equals("") && fechaFinal.equals("")) {//Solo Nombre
                listaE = this.entradaFacade.filterByNameAndId(nombreEntrada, usuario.getUsuarioevento().getId());
                if(listaE != null && !listaE.isEmpty()){
                    listaEntrada = listaE;
                }
            } else if(nombreEntrada == "" && nombreEntrada.length()<=0 && !fechaInicio.equals("") && !fechaFinal.equals("")) {// Solo Fechas
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                listaEntrada = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
                listaE = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
                for(Entrada e : listaEntrada){
                    if(fechaIni.after(e.getEvento().getFecha()) || fechaFin.before(e.getEvento().getFecha())){
                        listaE.remove(e);
                    }
                }
                listaEntrada = listaE;    
            } else if(nombreEntrada == "" && nombreEntrada.length()<=0 && !fechaInicio.equals("") && fechaFinal.equals("")) {// Solo Fecha Inicio
                Date fechaIni = new SimpleDateFormat("yyyy-MM-dd").parse(fechaInicio);
                listaEntrada = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
                listaE = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
                for(Entrada e : listaEntrada){
                    if(fechaIni.after(e.getEvento().getFecha())){
                        listaE.remove(e);
                    }
                }
                listaEntrada = listaE;
            } else if(nombreEntrada == "" && nombreEntrada.length()<=0 && fechaInicio.equals("") && !fechaFinal.equals("")){// Solo Fecha Final
                Date fechaFin = new SimpleDateFormat("yyyy-MM-dd").parse(fechaFinal);
                listaEntrada = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
                listaE = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
                for(Entrada e : listaEntrada){
                    if(fechaFin.before(e.getEvento().getFecha())){
                        listaE.remove(e);
                    }
                }
                listaEntrada = listaE;
            }else{// Quiero mostrar todos
                listaEntrada = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
            
            }
       }catch(Exception e){
            listaEntrada = this.entradaFacade.findById(usuario.getUsuarioevento().getId());
       }
       
       request.setAttribute("entradas", listaEntrada);
       
       RequestDispatcher rd = request.getRequestDispatcher("misEntradas.jsp?filtrado=1");
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
