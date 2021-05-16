/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.EventoFacade;
import eventaw.dao.UsuarioFacade;
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


@WebServlet(name = "ServletListadoAdmin", urlPatterns = {"/ServletListadoAdmin"})
public class ServletListadoAdmin extends HttpServlet {

    @EJB
    private EventoFacade eventoFacade;

    @EJB
    private UsuarioFacade usuarioFacade;

   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException {
       
       String filtrado = request.getParameter("filtradoUsuario");
       String tipoFiltrado = request.getParameter("tipofiltrado");
       
       String filtradoEvento = request.getParameter("filtradoEvento");
       String tipoFiltrado2 = request.getParameter("tipofiltrado2");
       
       List <Usuario> listaUsuario = new ArrayList<>();
       List <Usuario> listaU;
       
       List <Evento> listaEventos = new ArrayList<>();
       List <Evento> listaE = null;
       
       if(filtrado !=null && filtrado.length()>0){//Filtrado
           try{
           listaEventos = this.eventoFacade.findAll();
               
           if(tipoFiltrado.equals("id")){
               if(this.usuarioFacade.find(new Integer(filtrado)) != null){
                    
                   listaUsuario.add(this.usuarioFacade.find(new Integer(filtrado)));
               }
           }else if (tipoFiltrado.equals("email")){
                listaU = this.usuarioFacade.findFiltradoByEmail(filtrado);
           if(listaU != null && !listaU.isEmpty()){
                listaUsuario = listaU;
                   }
           }else{//ROL
               
                listaU = this.usuarioFacade.findFiltradoByRol(filtrado);
                if(listaU != null && !listaU.isEmpty()){
                    listaUsuario = listaU;
                }
           }
           }catch(Exception e){
               listaUsuario = this.usuarioFacade.findAll();
               listaEventos = this.eventoFacade.findAll();
           }
       }else if(filtradoEvento !=null && filtradoEvento.length()>0){
            
           try{
               
           listaUsuario = this.usuarioFacade.findAll();
               
           if(tipoFiltrado2.equals("id")){
                if(this.eventoFacade.find(new Integer(filtradoEvento)) != null){
                    listaEventos.add(this.eventoFacade.find(new Integer(filtradoEvento)));
                }
           }else if (tipoFiltrado2.equals("email")){
                listaE = this.eventoFacade.findFiltradoByEmail(filtradoEvento);
           }else if(tipoFiltrado2.equals("titulo")){
                listaE = this.eventoFacade.findFiltradoByTitulo(filtradoEvento);
           }else if(tipoFiltrado2.equals("ciudad")){
                listaE = this.eventoFacade.findFiltradoByCiudad(filtradoEvento);
           }else{//Fecha
               Date f = new SimpleDateFormat("dd/MM/yyyy").parse(filtradoEvento);
                listaE = this.eventoFacade.findFiltradoByFecha(f);
           }
           if(listaE != null && !listaE.isEmpty()){
                    listaEventos = listaE;
           }
           }catch(Exception e){
               listaUsuario = this.usuarioFacade.findAll();
               listaEventos = this.eventoFacade.findAll();
           }
            
       }else{
           listaUsuario = this.usuarioFacade.findAll();
           listaEventos = this.eventoFacade.findAll();
       }
       
       request.setAttribute("listaUsuario", listaUsuario);
       request.setAttribute("listaEventos", listaEventos);
       
       RequestDispatcher rd = request.getRequestDispatcher("paginaAdministrador.jsp");
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
