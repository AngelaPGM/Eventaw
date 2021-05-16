/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.AnalisisFacade;
import eventaw.entity.Analisis;
import eventaw.entity.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
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
 * @author rafa
 */
@WebServlet(name = "ServletGuardarAnalisis", urlPatterns = {"/ServletGuardarAnalisis"})
public class ServletGuardarAnalisis extends HttpServlet {

    @EJB
    private AnalisisFacade analisisFacade;

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
        /*
        HttpSession session = request.getSession();
        Analisis a = (Analisis) session.getAttribute("id");
        */
        String id = request.getParameter("id");
        Analisis a;
        
        String nombre = request.getParameter("nombreAnalisis");
        String fechaMayor = request.getParameter("fechaMayor");
        String fechaMenor = request.getParameter("fechaMenor");
        String fechaIgual = request.getParameter("fechaIgual");
        String precioMayor = request.getParameter("precioMayor");
        String precioMenor = request.getParameter("precioMenor");
        String precioIgual = request.getParameter("precioIgual");
        //CiudadEvento
        String edadMayor = request.getParameter("edadMayor");
        String edadMenor = request.getParameter("edadMenor");
        String edadIgual = request.getParameter("edadIgual");
        //CiudadUsuario
        String sexo = request.getParameter("sexo");
        if(sexo == null) sexo = "";
        
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        
        if(id != null){  //Edita
            a = this.analisisFacade.find(new Integer(id));
            
            if(!(nombre == null || nombre.isEmpty())) a.setNombre(nombre);
            try {
                if(!(fechaMayor == null)) a.setFechamayor(formato.parse(fechaMayor));
                if(!(fechaMenor == null)) a.setFechamayor(formato.parse(fechaMenor));
                if(!(fechaIgual == null)) a.setFechamayor(formato.parse(fechaIgual));
            } catch (ParseException ex) {
            }
            if(!(precioMayor == null || precioMayor.isEmpty())) a.setPreciomayor(new Integer(precioMayor));
            if(!(precioMenor == null || precioMenor.isEmpty())) a.setPreciomenor(new Integer(precioMenor));
            if(!(precioIgual == null || precioIgual.isEmpty())) a.setPrecioigual(new Integer(precioIgual));
            //
            if(!(edadMayor == null || edadMayor.isEmpty())) a.setEdadmayor(new Integer(edadMayor));
            if(!(edadMenor == null || edadMenor.isEmpty())) a.setEdadmenor(new Integer(edadMenor));
            if(!(edadIgual == null || edadIgual.isEmpty())) a.setEdadigual(new Integer(edadIgual));
            
            this.analisisFacade.edit(a);
        }else{          //Crea
            a = new Analisis();
            
            if(!(nombre == null || nombre.isEmpty())) a.setNombre(nombre);
            try {
                if(!(fechaMayor == null)) a.setFechamayor(formato.parse(fechaMayor));
                if(!(fechaMenor == null)) a.setFechamayor(formato.parse(fechaMenor));
                if(!(fechaIgual == null)) a.setFechamayor(formato.parse(fechaIgual));
            } catch (ParseException ex) {
            }
            if(!(precioMayor == null || precioMayor.isEmpty())) a.setPreciomayor(new Integer(precioMayor));
            if(!(precioMenor == null || precioMenor.isEmpty())) a.setPreciomenor(new Integer(precioMenor));
            if(!(precioIgual == null || precioIgual.isEmpty())) a.setPrecioigual(new Integer(precioIgual));
            //
            if(!(edadMayor == null || edadMayor.isEmpty())) a.setEdadmayor(new Integer(edadMayor));
            if(!(edadMenor == null || edadMenor.isEmpty())) a.setEdadmenor(new Integer(edadMenor));
            if(!(edadIgual == null || edadIgual.isEmpty())) a.setEdadigual(new Integer(edadIgual));
            
            this.analisisFacade.create(a);
            id = a.getAnalisisid()+"";
        }
        
        String rdTo = "ServletEditarAnalisis?id=" + id;
        RequestDispatcher rd = request.getRequestDispatcher(rdTo);
        //RequestDispatcher rd = request.getRequestDispatcher("ServletAnalistaEventos");
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
