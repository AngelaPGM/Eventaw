/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.EtiquetaFacade;
import eventaw.dao.EventoFacade;
import eventaw.dao.UsuarioFacade;
import eventaw.entity.Etiqueta;
import eventaw.entity.Evento;
import eventaw.entity.Usuario;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
 * @author Gonzalo
 */
@WebServlet(name = "ServletGuardarEvento", urlPatterns = {"/ServletGuardarEvento"})
public class ServletGuardarEvento extends HttpServlet {

    @EJB
    private EtiquetaFacade etiquetaFacade;

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

        usuario = (Usuario) session.getAttribute("user");

        String error = "";
        String id = request.getParameter("id");
        String titulo = new String(request.getParameter("titulo").getBytes("ISO-8859-1"), "UTF8");
        String desc = new String(request.getParameter("desc").getBytes("ISO-8859-1"), "UTF8");
        String ciudad = new String(request.getParameter("ciudad").getBytes("ISO-8859-1"), "UTF8");
        String[] etiquetas = request.getParameterValues("etiquetas");
        String fecha = request.getParameter("fecha");
        String fechaCompra = request.getParameter("fechaCompra");
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        Date dateFecha = new Date();
        Date dateFechaCompra = new Date();

        try {
            dateFecha = formato.parse(fecha);
            dateFechaCompra = formato.parse(fechaCompra);
        } catch (ParseException ex) {
            Logger.getLogger(ServletGuardarEvento.class.getName()).log(Level.SEVERE, null, ex);
        }

        String precio = request.getParameter("precio");
        String aforo = request.getParameter("aforo");
        String max = request.getParameter("max");
        String numFilas = request.getParameter("numFilas");
        String asientos = request.getParameter("asientos");
        String idCreador = request.getParameter("creador");
        String nuevaEtiqueta = request.getParameter("nuevaEtiqueta");

        if (titulo.equals("") || desc.equals("") || fecha.equals("") || fechaCompra.equals("") || precio.equals("") || aforo.equals("") || max.equals("")) {
            error = "Hay campos obligatorios vacíos.";

        } else {
            if (nuevaEtiqueta.equals("") && etiquetas == null) {
                error = "Selecciona al menos una etiqueta";

            } else if (dateFechaCompra.after(dateFecha)) {
                error = "La fecha límite de compra no puede ser posterior a la fecha del evento.";

            } else {
                try {
                    if (id.equals("")) {
                        e = new Evento();
                        e.setId(0);
                        e.setTitulo(titulo);
                        e.setDescripcion(desc);
                        e.setCiudad(ciudad);
                        e.setFecha(new SimpleDateFormat("yyyy-MM-dd").parse(fecha));
                        e.setFechacompra(new SimpleDateFormat("yyyy-MM-dd").parse(fechaCompra));
                        e.setPrecio(new Double(precio));
                        e.setAforo(new Integer(aforo));
                        e.setMaxentradasusuario(new Integer(max));
                        if (!numFilas.equals("") && !asientos.equals("")) {
                            Integer x = new Integer(numFilas);
                            Integer y = new Integer(asientos);
                            if(x*y == new Integer(aforo)){
                                e.setNumfilas(new Integer(numFilas));
                                e.setAsientosfila(new Integer(asientos));
                            } else {
                                error = "El aforo ha de ser igual al nº filas por el nº de asientos por fila";
                            }
                        } else {
                            error = "Si rellena Nº filas o Asientos por fila, también ha de rellenar el otro";
                        }
                        List<Etiqueta> lista = new ArrayList();
                        if (!(nuevaEtiqueta.equals(""))) {
                            if (this.etiquetaFacade.findByNombre(nuevaEtiqueta) == null) { //No existe la etiqueta nueva
                                Etiqueta nueva = new Etiqueta();
                                nueva.setNombre(nuevaEtiqueta);

                                this.etiquetaFacade.create(nueva);
                                lista.add(nueva);
                            } else { //Ya existe la etiqueta
                                error = "Ya existe una etiqueta con ese nombre. Por favor, selecciónala.";
                            }

                        }
                        if (error.equals("")) {
                            Usuario creador = this.usuarioFacade.find(new Integer(idCreador));
                            e.setCreador(creador);

                            if (etiquetas != null) {
                                for (String etiqueta : etiquetas) {
                                    Etiqueta etiq = this.etiquetaFacade.findByNombre(etiqueta);
                                    lista.add(etiq);
                                }
                            }

                            e.setEtiquetaList(lista);

                            if (usuario.getId() == e.getCreador().getId()) {
                                usuario.getEventoList().add(e);
                            }

                            this.eventoFacade.create(e);
                            this.usuarioFacade.edit(usuario);
                        }

                    } else {
                        e = this.eventoFacade.find(new Integer(id));

                        if (usuario.getId() == e.getCreador().getId()) {
                            usuario.getEventoList().remove(e);
                        }

                        e.setTitulo(titulo);
                        e.setDescripcion(desc);
                        e.setCiudad(ciudad);
                        e.setFecha(new SimpleDateFormat("yyyy-MM-dd").parse(fecha));
                        e.setFechacompra(new SimpleDateFormat("yyyy-MM-dd").parse(fechaCompra));
                        e.setPrecio(new Double(precio));
                        e.setAforo(new Integer(aforo));
                        e.setMaxentradasusuario(new Integer(max));
                        if (!numFilas.equals("")) {
                            e.setNumfilas(new Integer(numFilas));
                        }
                        if (!asientos.equals("")) {
                            e.setAsientosfila(new Integer(asientos));
                        }

                        if (usuario.getId() == e.getCreador().getId()) {
                            usuario.getEventoList().add(e);
                        }

                        this.eventoFacade.edit(e);
                        this.usuarioFacade.edit(usuario);
                    }

                } catch (Exception exception) {
                    System.out.println("ERRORRRRRRRRRRRRRRRRRRRRRRR: " + exception.getMessage());
                }
            }

            session.setAttribute("user", usuario);

            if (!("".equals(error))) {
                if (id != null && !(id.equals(""))) {
                    e = this.eventoFacade.find(new Integer(id));
                }
                request.setAttribute("evento", e);
                request.setAttribute("error", error);
                request.setAttribute("etiquetas", this.etiquetaFacade.findAll());
                RequestDispatcher rd = request.getRequestDispatcher("formularioEvento.jsp");
                rd.forward(request, response);
            } else if (usuario.getRol().getId() == 1) {
                RequestDispatcher rd = request.getRequestDispatcher("ServletListadoAdmin");
                rd.forward(request, response);
            } else if (usuario.getRol().getId() == 3) {
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
