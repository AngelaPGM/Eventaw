/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Mensaje;
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
public class MensajeFacade extends AbstractFacade<Mensaje> {

    @PersistenceContext(unitName = "EventawPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MensajeFacade() {
        super(Mensaje.class);
    }
    
    public List<Mensaje> findByConver(Integer id){
        List<Mensaje> res;
        Query q;
        q = this.em.createQuery("SELECT m FROM Mensaje m WHERE m.conversacion.id = :id ORDER BY m.fecha DESC");
        q.setParameter("id", id);
        
        res = q.getResultList();

        if(res.isEmpty()){
            return null;
        } else {
            return res;
        }
    }
    
}