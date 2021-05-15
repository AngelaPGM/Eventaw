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
@WebServlet(name = "ServletLogin", urlPatterns = {"/ServletLogin"})
public class ServletLogin extends HttpServlet {

    @EJB
    private EventoFacade eventoFacade;

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
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        Usuario usuario;
        String jsp = "";
        String errorLog = "";
        List<Evento> eventos;
        Date today = new Date();
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        HttpSession session = request.getSession();
        
        usuario = this.usuarioFacade.findByEmail(email);
        
        if(usuario != null){
            if(usuario.getContrasenya().equals(password)){
                if(null != usuario.getRol().getId()) switch (usuario.getRol().getId()) {
                    case 1:
                        jsp = "ServletListadoAdmin";
                        session.setAttribute("user", usuario);
                        break;
                    case 2:
                        jsp = "inicio.jsp";
                        session.setAttribute("user", usuario);
                        eventos = this.eventoFacade.findAll();
                        for(Evento e : this.eventoFacade.findAll()){
                            if(!formato.format(e.getFecha()).equals(formato.format(today))){
                                if(!e.getFecha().after(today)) eventos.remove(e);
                            }
                        }   
                        request.setAttribute("eventos", eventos);
                        break;
                    case 3:
                        jsp = "inicioCreador.jsp";
                        session.setAttribute("user", usuario);
                        break;
                    case 4:
                        jsp = "ServletTeleoperador";
                        session.setAttribute("user", usuario);
                        break;
                    case 5:
                        jsp = "ServletAnalistaEventos";
                        session.setAttribute("analista", usuario);
                        break;
                    default:
                        break;
                } 
            } else {
                jsp = "login.jsp";
                errorLog = "¡Contraseña incorrecta!";
            }
        } else {
            jsp = "login.jsp";
            errorLog = "¡Email incorrecto!";
        }
        
        request.setAttribute("errorLog", errorLog);
        
        RequestDispatcher rd = request.getRequestDispatcher(jsp);
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
