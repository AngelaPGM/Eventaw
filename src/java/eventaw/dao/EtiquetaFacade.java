/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Etiqueta;
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
public class EtiquetaFacade extends AbstractFacade<Etiqueta> {

    @PersistenceContext(unitName = "EventawPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EtiquetaFacade() {
        super(Etiqueta.class);
    }
    
    public Etiqueta findByNombre(String nombre) {
        Query q = em.createNamedQuery("Etiqueta.findByNombre");
        q.setParameter("nombre", nombre);
        List<Etiqueta> aux = q.getResultList();
        
        if(aux.isEmpty()) {
            return null;
        } else {
        return (Etiqueta) aux.get(0);
        }
    }
}
