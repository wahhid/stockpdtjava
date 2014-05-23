/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jakc.stockpdt.controller;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import org.jakc.stockpdt.entity.Product;

/**
 *
 * @author root
 */
public class ProductController {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
    
   
    private EntityManager getEntityManager(){
        return this.emf.createEntityManager();
    }    
    
    public Product getProductByID(String ean){
        EntityManager em = this.getEntityManager();
        try{
            return (Product) em.createNamedQuery("Product.findByEan").setParameter("ean",ean).getSingleResult();
        }catch(NoResultException ex){
            return null;
        }finally{
            em.close();
        }
    }
    
}
