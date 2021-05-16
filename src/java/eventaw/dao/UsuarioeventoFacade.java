/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Usuarioevento;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author rafa
 */
@Stateless
public class UsuarioeventoFacade extends AbstractFacade<Usuarioevento> {

    @PersistenceContext(unitName = "EventawPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioeventoFacade() {
        super(Usuarioevento.class);
    }
    
}
