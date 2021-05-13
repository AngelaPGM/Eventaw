/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Evento;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author angep
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

        q = this.em.createQuery("SELECT e FROM Evento e WHERE e.titulo LIKE :titulo");
        q.setParameter("titulo", '%' + nombreEvento + '%');
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
}
