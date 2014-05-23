/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jakc.stockpdt.controller;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;
import org.jakc.stockpdt.entity.Employee;

/**
 *
 * @author root
 */
public class EmployeeController {
    
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("StockPDTPU");
    
    public EmployeeController(){
        
    }
    
    private EntityManager getEntityManager(){
        return this.emf.createEntityManager();
    }
    
    public Employee CheckLogin(String username,String password){
        System.out.println(password);
        EntityManager em = this.getEntityManager();
        String strSQL = "SELECT e FROM Employee e WHERE e.nik=:nik AND e.password=:password";
        //String strSQL = "SELECT e FROM Employee e WHERE e.nik=:nik";
        try{
            Query query = em.createQuery(strSQL).setParameter("nik", username).setParameter("password", password);
            //Query query = em.createQuery(strSQL).setParameter("nik", username);                        
            query.setHint("eclipselink.refresh", "true");
            Employee o =  (Employee) query.getSingleResult();
            return o;
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }finally{
            em.close();
        }
    }
}
