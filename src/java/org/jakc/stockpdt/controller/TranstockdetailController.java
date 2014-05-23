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
import org.jakc.stockpdt.entity.Transtockdetail;

/**
 *
 * @author root
 */
public class TranstockdetailController {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
    
    private EntityManager getEntityManager(){
        return emf.createEntityManager();
    }
  
    public void insertData(Transtockdetail o){
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
    
       public void updateData(Transtockdetail o){
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
        
    public void deleteData(Transtockdetail o){
        EntityManager em = this.getEntityManager();
        em.getTransaction().begin();
        try{
            em.remove(o);
            em.getTransaction().commit();
        }catch(Exception ex){
            em.getTransaction().rollback();
        }finally{
            em.close();
        }          
    }
    
    public Transtockdetail find(int transid,String productid){
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT t FROM Transtockdetail t WHERE t.transid=:transid AND t.productid=:productid";
        try{
            Query query = em.createQuery(strSQL)
                    .setParameter("transid", transid)
                    .setParameter("productid", productid);
            query.setHint("eclipselink.refresh", "true");
            return (Transtockdetail) query.getSingleResult();
        }catch(NoResultException ex){            
            return null;
        }finally{
            em.close();
        }
            
    }
    
    public List<Transtockdetail> getAll(){
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
