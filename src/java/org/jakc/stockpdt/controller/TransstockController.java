/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jakc.stockpdt.controller;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;
import org.jakc.stockpdt.entity.Transstock;

/**
 *
 * @author root
 */
public class TransstockController {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
    
    private EntityManager getEntityManager(){
        return emf.createEntityManager();
    }
  
    public Transstock insertData(Transstock o){
        EntityManager em = this.getEntityManager();
        em.getTransaction().begin();
        try{
            em.persist(o);
            em.getTransaction().commit();
            return o;
        }catch(Exception ex){            
            ex.printStackTrace();
            em.getTransaction().rollback();
            return null;
        }finally{
            em.close();
        }
    }
    
    
    public Transstock updateData(Transstock o){
        EntityManager em = this.getEntityManager();
        em.getTransaction().begin();
        try{
            em.merge(o);
            em.getTransaction().commit();
            return o;
        }catch(Exception ex){
            em.getTransaction().rollback();
            return null;
        }finally{
            em.close();
        }
    }
    
    public Transstock findTransstock(String siteid, String periodeid, String gondolaid){
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT t FROM Transstock t WHERE t.siteid=:siteid AND t.periodeid=:periodeid AND t.gondolaid=:gondolaid";
        try{
            Query query = em.createQuery(strSQL)
                    .setParameter("siteid", siteid)
                    .setParameter("periodeid", periodeid)
                    .setParameter("gondolaid", gondolaid);
            query.setHint("eclipselink.refresh", "true");
            return (Transstock) query.getSingleResult();                    
        }catch(NoResultException ex){
            ex.printStackTrace();
            return null;
        }finally{
            em.close();
        }
    }
    
    public List<Transstock> getAll(){
    EntityManager em = this.getEntityManager();
        try{
            Query query = em.createNamedQuery("Transstock.findAll");
            query.setHint("eclipselink.refresh", "true");
            return query.getResultList();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }        
}
