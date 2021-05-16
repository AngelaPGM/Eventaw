/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.dao;

import eventaw.entity.Usuario;
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
public class UsuarioFacade extends AbstractFacade<Usuario> {

    @PersistenceContext(unitName = "EventawPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioFacade() {
        super(Usuario.class);
    }
            public Usuario findByEmail(String email){
        Query q;
        List<Usuario> aux;
    
        q = this.em.createNamedQuery("Usuario.findByCorreo");
        q.setParameter("correo", email);
        aux = q.getResultList();
        
        if(aux.isEmpty()){
            return null;
        } else {
            return aux.get(0);
}
    }
    
    public List<Usuario> findFiltradoByRol(String rol){
        Query q;
        List<Usuario> res;

        q = this.em.createQuery("SELECT u FROM Usuario u WHERE u.rol.tipo LIKE :rol");
        q.setParameter("rol", '%' + rol + '%');
        res = q.getResultList();

        if(res.isEmpty()){
            return null;
        } else {
            return res;
        }
    }
    
    public List<Usuario> findFiltradoByEmail(String email){
        Query q;
        List<Usuario> res;

        q = this.em.createQuery("SELECT u FROM Usuario u WHERE u.correo LIKE :correo ");
        q.setParameter("correo", '%' + email + '%');
        res = q.getResultList();

        if(res.isEmpty()){
            return null;
        } else {
            return res;
        }
    }
}
