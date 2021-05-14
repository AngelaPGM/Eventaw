/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.ConversacionFacade;
import eventaw.dao.MensajeFacade;
import eventaw.dao.UsuarioFacade;
import eventaw.entity.Conversacion;
import eventaw.entity.Mensaje;
import eventaw.entity.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.AsyncContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author https://www.oracle.com/webfolder/technetwork/tutorials/obe/java/async-servlet/async-servlets.html
 */
@WebServlet(urlPatterns = {"/shoutServlet"}, asyncSupported=true)
public class ShoutServlet extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

    @EJB
    private ConversacionFacade conversacionFacade;

    @EJB
    private MensajeFacade mensajeFacade;
    
    private List<AsyncContext> contexts = new LinkedList<>();
    private static final Logger LOG = Logger.getLogger(ShoutServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final AsyncContext asyncContext = request.startAsync(request, response);
        asyncContext.setTimeout(10 * 60 * 1000);
        contexts.add(asyncContext);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<AsyncContext> asyncContexts = new ArrayList<>(this.contexts);
        this.contexts.clear();
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String message = request.getParameter("message");
        Date fecha = new Date();
        
        //Guardar mensaje en la bbdd
        Usuario emisor = this.usuarioFacade.findByEmail(name);
        Mensaje m = new Mensaje(1);
        m.setEmisor(emisor);
        m.setContenido(message);
        m.setFecha(fecha);
        Conversacion c = this.conversacionFacade.find(new Integer(id));
        m.setConversacion(c);
        this.mensajeFacade.create(m);
        
        List<Mensaje> l = c.getMensajeList();
        l.add(m);
        c.setMensajeList(l);
        this.conversacionFacade.edit(c);

        String fechaF = new SimpleDateFormat("dd/MM/yyyy hh:mm").format(fecha);
        
        String htmlMessage = "<p><b>" + name + " </b>" + fechaF + "<br/>" + message + "</p>";
        
        ServletContext application = request.getServletContext();
        
        if (application.getAttribute("messages") == null) {
            application.setAttribute("messages", htmlMessage);
        } else {
            String currentMessages = (String) application.getAttribute("messages");
            application.setAttribute("messages", htmlMessage + currentMessages);
        }
        
        for (AsyncContext asyncContext : asyncContexts) {
            try (PrintWriter writer = asyncContext.getResponse().getWriter()) {
                writer.println(htmlMessage);
                writer.flush();
                asyncContext.complete();
            } catch (Exception ex) {
                LOG.severe("Se ha producido la siguiente excepcion: " + ex.getMessage());
            }
        }

    }
}

