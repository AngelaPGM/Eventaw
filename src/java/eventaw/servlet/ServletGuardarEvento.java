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
import java.text.SimpleDateFormat;
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
@WebServlet(name = "ServletGuardarEvento", urlPatterns = {"/ServletGuardarEvento"})
public class ServletGuardarEvento extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

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
        
        Evento e = null;
        Usuario usuario;
        HttpSession session = request.getSession();
        
        usuario = (Usuario)session.getAttribute("user");
        
        String error = "";
        String id = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String desc = request.getParameter("desc");
        String ciudad = request.getParameter("ciudad");
        String fecha = request.getParameter("fecha");
        String fechaCompra = request.getParameter("fechaCompra");
        String precio = request.getParameter("precio");
        String aforo = request.getParameter("aforo");
        String max = request.getParameter("max");
        String numFilas = request.getParameter("numFilas");
        String asientos = request.getParameter("asientos");
        String idCreador = request.getParameter("creador");
        
        if(titulo==null || desc==null || fecha.equals("") || fechaCompra.equals("") || precio==null || aforo==null || max==null){
            error = "Hay campos obligatorios vacíos.";
            if(id != null){
                e = this.eventoFacade.find(new Integer(id));
            }
            request.setAttribute("evento", e);
            request.setAttribute("error", error);
            
            RequestDispatcher rd = request.getRequestDispatcher("formularioEvento.jsp");
            rd.forward(request, response);
        }else{
            try{
                if(id.equals("")){
                    e = new Evento();
                    e.setTitulo(titulo);
                    e.setDescripcion(desc);
                    e.setCiudad(ciudad);
                    e.setFecha(new SimpleDateFormat("yyyy-MM-dd").parse(fecha));
                    e.setFechacompra(new SimpleDateFormat("yyyy-MM-dd").parse(fechaCompra));
                    e.setPrecio(new Double(precio));
                    e.setAforo(new Integer(aforo));
                    e.setMaxentradasusuario(new Integer(max));
                    if(!numFilas.equals("")) e.setNumfilas(new Integer(numFilas));
                    if(!asientos.equals("")) e.setAsientosfila(new Integer(asientos));
                    Usuario creador = this.usuarioFacade.find(new Integer(idCreador));
                    e.setCreador(creador);
                    
                    if(usuario.getId() == e.getCreador().getId())usuario.getEventoList().add(e);
                    
                    this.eventoFacade.create(e);
                    this.usuarioFacade.edit(usuario);
                }else{
                    e = this.eventoFacade.find(new Integer(id));
                    
                    if(usuario.getId() == e.getCreador().getId())usuario.getEventoList().remove(e);
                    
                    e.setTitulo(titulo);
                    e.setDescripcion(desc);
                    e.setCiudad(ciudad);
                    e.setFecha(new SimpleDateFormat("yyyy-MM-dd").parse(fecha));
                    e.setFechacompra(new SimpleDateFormat("yyyy-MM-dd").parse(fechaCompra));
                    e.setPrecio(new Double(precio));
                    e.setAforo(new Integer(aforo));
                    e.setMaxentradasusuario(new Integer(max));
                    if(!numFilas.equals("")) e.setNumfilas(new Integer(numFilas));
                    if(!asientos.equals("")) e.setAsientosfila(new Integer(asientos));
                    
                    if(usuario.getId() == e.getCreador().getId())usuario.getEventoList().add(e);
                    
                    this.eventoFacade.edit(e);
                    this.usuarioFacade.edit(usuario);
                }
            }catch(Exception exception){
                log("Excepcion");
            }
            
            session.setAttribute("user", usuario);

            if(usuario.getRol().getId() == 1){
                RequestDispatcher rd = request.getRequestDispatcher("ServletListadoAdmin");
                rd.forward(request, response);
            } else if(usuario.getRol().getId() == 3) {
                request.setAttribute("eventos", usuario.getEventoList());
                RequestDispatcher rd = request.getRequestDispatcher("inicioCreador.jsp");
                rd.forward(request, response);
            }
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
