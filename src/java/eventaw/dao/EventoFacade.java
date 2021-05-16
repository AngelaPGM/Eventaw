/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Evento;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author rafa
 */
@Stateless
public class EventoFacade extends AbstractFacade<Evento> {

    @PersistenceContext(unitName = "EventawPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EventoFacade() {
        super(Evento.class);
    }
    public List<Evento> findByCreator(Integer idCreador){
        Query q;
        List<Evento> aux;
    
        q = this.em.createQuery("select e from Evento e where e.creador.id = :idCreador");
        q.setParameter("idCreador", idCreador);
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
}
    }
    
    public List<Evento> filterByName(String nombreEvento){
        Query q;
        List<Evento> aux;

        q = this.em.createQuery("SELECT e FROM Evento e WHERE lower(e.titulo) LIKE lower(:titulo)");
        q.setParameter("titulo", '%' + nombreEvento + '%');
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
    
    public List<Evento> findByCreatorAndName(Integer idCreador, String nombreEvento){
        Query q;
        List<Evento> aux;

        q = this.em.createQuery("select e from Evento e where e.creador.id = :idCreador and lower(e.titulo) LIKE lower(:titulo)");
        q.setParameter("idCreador", idCreador);
        q.setParameter("titulo", '%' + nombreEvento + '%');
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
    
    public List<Evento> findFiltradoByEmail(String filtro){
        Query q;
        List<Evento> aux;

        q = this.em.createQuery("SELECT e FROM Evento e WHERE lower(e.creador.correo) LIKE lower(:correo)");
        q.setParameter("correo", '%' + filtro + '%');
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
    
    public List<Evento> findFiltradoByTitulo(String filtro){
        Query q;
        List<Evento> aux;

        q = this.em.createQuery("SELECT e FROM Evento e WHERE lower(e.titulo) LIKE lower(:titulo)");
        q.setParameter("titulo", '%' + filtro + '%');
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
    
    public List<Evento> findFiltradoByCiudad(String filtro){
        Query q;
        List<Evento> aux;

        q = this.em.createQuery("SELECT e FROM Evento e WHERE lower(e.ciudad) LIKE lower(:ciudad)");
        q.setParameter("ciudad", '%' + filtro + '%');
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
    
    public List<Evento> findFiltradoByFecha(Date filtro){
        Query q;
        List<Evento> aux;

        q = this.em.createQuery("SELECT e FROM Evento e WHERE lower(e.fecha) = lower(:fecha)");
        q.setParameter("fecha", filtro);
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
    
    public List<Evento> eventosPorFiltro(Date fechamayor, Date fechamenor, Date fechaigual, Integer preciomayor, Integer preciomenor, Integer precioigual, String ciudadevento){
        List<Evento> res = null;
        
        int filtrosAct = 0;
        String strQ = "SELECT e FROM Evento e ";
        
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        
        if(fechamayor != null){
            filtrosAct++;
            //fechamayor = formato.parse(fechamayor);
        }
        if(fechamenor != null){
            filtrosAct++;
        }
        if(fechaigual != null){
            filtrosAct++;
        }
        if(preciomayor != null){
            filtrosAct++;
        }
        if(preciomenor != null){
            filtrosAct++;
        }
        if(precioigual != null){
            filtrosAct++;
        }
        if(ciudadevento != null){
            filtrosAct++;
        }
        
        
        if(filtrosAct > 0){
            strQ+="WHERE ";
            if(fechamayor != null){
                strQ+="e.fecha > :fechamayor ";
                filtrosAct--;
                if(filtrosAct > 0){
                    strQ+=" AND ";
                }
            }
            if(fechamenor != null){
                strQ+="e.fecha < :fechamenor ";
                filtrosAct--;
                if(filtrosAct > 0){
                    strQ+=" AND ";
                }
            }
            if(fechaigual != null){
                strQ+="e.fecha = :fechaigual ";
                filtrosAct--;
                if(filtrosAct > 0){
                    strQ+=" AND ";
                }
            }
            if(preciomayor != null){
                strQ+="e.precio > :preciomayor ";
                filtrosAct--;
                if(filtrosAct > 0){
                    strQ+=" AND";
                }
            }
            if(preciomenor != null){
                strQ+="e.precio < :preciomenor ";
                filtrosAct--;
                if(filtrosAct > 0){
                    strQ+=" AND ";
                }
            }
            if(precioigual != null){
                strQ+="e.precio = :precioigual ";
                filtrosAct--;
                if(filtrosAct > 0){
                    strQ+=" AND ";
                }
            }
            if(ciudadevento != null){
                strQ+="e.ciudad > :ciudadevento ";
                filtrosAct--;
                //En teoria no se ejecuta este if, por ser el ultimo, pero lo dejo por si añado mas filtros
                if(filtrosAct > 0){
                    strQ+=" AND ";
                }
            }
            Query q;
            List<Evento> aux;

            q = this.em.createQuery(strQ);
            q.setParameter("fechamayor", fechamayor);
            q.setParameter("fechamenor", fechamenor);
            q.setParameter("fechaigual", fechaigual);
            q.setParameter("preciomayor", preciomayor+"");
            q.setParameter("preciomenor", preciomenor+"");
            q.setParameter("precioigual", precioigual+"");
            q.setParameter("ciudadevento", ciudadevento);

            res = q.getResultList();
        }else{
            res = this.findAll();
        }
        
        return res;
    }
}
