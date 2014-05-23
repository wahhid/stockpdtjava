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
import org.jakc.stockpdt.entity.Periode;

/**
 *
 * @author root
 */
public class PeriodeController {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
    
    public PeriodeController(){
        
    }
    
    private EntityManager getEntityManager(){
        return emf.createEntityManager();
    }
    
    public List<Periode> getAll(){
        EntityManager em = this.getEntityManager();
        try{
            Query query = em.createNamedQuery("Periode.findAll");
            query.setHint("eclipselink.refresh", "true");
            return query.getResultList();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }
    
    public List<Periode> getBySites(String siteid){
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT p FROM Periode p WHERE p.siteid=:siteid AND p.status=:status";
        try{
            Query query = em.createQuery(strSQL)                    
                    .setParameter("siteid", siteid)
                    .setParameter("status", true);
            query.setHint("eclipselink.refresh", "true");
            return query.getResultList();
        }catch(NoResultException ex){
            ex.printStackTrace();
            return null;
        }finally{
            em.close();
        }
    }
    
    public Periode getByPeriodeid(String periodeid){
        EntityManager em = this.getEntityManager();
        try{
            Query query = em.createNamedQuery("Periode.findByPeriodeid").setParameter("periodeid", periodeid);
            query.setHint("eclipselink.refresh", true);
            return (Periode) query.getSingleResult();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }
}
