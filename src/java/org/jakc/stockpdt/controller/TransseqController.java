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
import org.jakc.stockpdt.entity.Transseq;

/**
 *
 * @author root
 */
public class TransseqController {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
    
    private EntityManager getEntityManager(){
        return emf.createEntityManager();
    }
    
    
    public void create(Transseq o){
        EntityManager em = this.getEntityManager();
        em.getTransaction().begin();
        try{
            em.persist(o);
            em.getTransaction().commit();
        }catch(Exception ex){
            em.getTransaction().rollback();
        }finally{
            em.close();
        }
    }
    
    public void update(Transseq o){
        EntityManager em = this.getEntityManager();
        em.getTransaction().begin();
        try{
            em.merge(o);
            em.getTransaction().commit();
        }catch(Exception ex){
            em.getTransaction().rollback();
        }finally{
            em.close();
        }
    }
    
    public Transseq getLast(String siteid, String periodeid, String gondolaid){        
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT t FROM Transseq t WHERE t.siteid=:siteid AND t.periodeid=:periodeid AND t.gondolaid=:gondolaid ORDER BY t.sequence ";
        try{
            Query query = em.createQuery(strSQL)
                    .setParameter("siteid", siteid)
                    .setParameter("periodeid", periodeid)
                    .setParameter("gondolaid", gondolaid);
            query.setHint("eclipselink.refresh", "true");
            query.setMaxResults(1);
            return (Transseq) query.getSingleResult();                               
        }catch(NoResultException ex){            
            return null;
        }finally{
            em.close();
        }
    }
}
