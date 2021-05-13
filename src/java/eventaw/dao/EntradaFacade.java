/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Entrada;
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
public class EntradaFacade extends AbstractFacade<Entrada> {

    @PersistenceContext(unitName = "EventawPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EntradaFacade() {
        super(Entrada.class);
    }
    
    public List<Entrada> findById(Integer id){
        Query q;
        List<Entrada> aux;

        q = this.em.createQuery("select e from Entrada e where e.usuario.id = :id");
        q.setParameter("id", id);
        aux = q.getResultList();

        if(aux.isEmpty()){
            return null;
        } else {
            return aux;
        }
    }

    public List<Entrada> filterByNameAndId (String nombreEntrada, Integer usuarioId){
        Query q;
        List<Entrada> aux;

        q = this.em.createQuery("SELECT e FROM Entrada e WHERE e.evento.titulo LIKE :entrada AND e.usuario.id = :usuarioId");
        q.setParameter("entrada", '%' + nombreEntrada + '%');
        q.setParameter("usuarioId", usuarioId);
        aux = q.getResultList();
        if(aux.isEmpty()){
            return aux;
        } else {
            return q.getResultList();
        }
    }
}
