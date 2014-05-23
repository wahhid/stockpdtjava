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
import org.jakc.stockpdt.entity.Site;

/**
 *
 * @author root
 */
public class SiteController {
   private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
    
   private EntityManager getEntityManager(){
        return emf.createEntityManager();
    }
  
    public List<Site> getAll(){
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT s FROM Site s WHERE s.deleted=0";
        try{
            //Query query = em.createNamedQuery("Site.findAll");
            Query query = em.createQuery(strSQL);
            query.setHint("eclipselink.refresh", "true");            
            return query.getResultList();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }    
}
