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
import org.jakc.stockpdt.entity.Gondola;

/**
 *
 * @author root
 */
public class GondolaController {
    
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
 
    public GondolaController(){
        
    }
    
    private EntityManager getEntityManager(){
        return emf.createEntityManager();
    }
    
    public void close(String gondolaid,boolean status){
        EntityManager em = this.getEntityManager();
        Gondola gondola = this.find(gondolaid);
        if(gondola != null){
            em.getTransaction().begin();
            try{
                gondola.setStatus(status);
                em.merge(gondola);
                em.getTransaction().commit();
            }catch(Exception ex){
                
            }finally{
                em.close();
            }
        }        
    }
    
    public Gondola find(String gondolaid){
        EntityManager em = this.getEntityManager();
        try{
            Query query  = em.createNamedQuery("Gondola.findByGondolaid").setParameter("gondolaid", gondolaid);
            query.setHint("eclipselink.refresh", "true");
            return (Gondola) query.getSingleResult();
        }catch(NoResultException ex){
            ex.printStackTrace();
            return null;
        }finally{
            em.close();
        }
    }
    
    public Gondola findBySite(String siteid,String gondolaid){
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT g FROM Gondola g WHERE g.siteid=:siteid AND g.gondolaid=:gondolaid AND g.deleted=:deleted";
        try{
            Query query = em.createQuery(strSQL)
                    .setParameter("siteid", siteid)
                    .setParameter("gondolaid", gondolaid)
                    .setParameter("deleted", false);         
            query.setHint("eclipselink.refresh", "true");
            return (Gondola) query.getSingleResult();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }
    
    
    public List<Gondola> getAll(){
        EntityManager em = this.getEntityManager();        
        try{
            Query query = em.createNamedQuery("Gondola.findByDeleted").setParameter("deleted", false);
            query.setHint("eclipselink.refresh", "true");
            return query.getResultList();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }
    
    public List<Gondola> getBySites(String siteid){
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT g FROM Gondola g WHERE g.siteid=:siteid AND g.deleted=:deleted";
        try{
            Query query = em.createQuery(strSQL)
                    .setParameter("siteid", siteid)
                    .setParameter("deleted", false);
            query.setHint("eclipselink.refresh", "true");
            return query.getResultList();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }    
    
}
