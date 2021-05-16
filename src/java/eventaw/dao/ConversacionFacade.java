/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Conversacion;
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
public class ConversacionFacade extends AbstractFacade<Conversacion> {

    @PersistenceContext(unitName = "EventawPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ConversacionFacade() {
        super(Conversacion.class);
    }
    
    public List<Conversacion> findByCorreo(String filtro){
        List<Conversacion> res;
        Query q;
        q = this.em.createQuery("SELECT c FROM Conversacion c WHERE c.usuario.correo LIKE :f OR c.teleoperador.correo LIKE :f");
        q.setParameter("f", '%' + filtro + '%');
        res = q.getResultList();

        if(res.isEmpty()){
            return null;
        } else {
            return res;
        }
    }
    
}