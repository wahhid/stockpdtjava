/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jakc.stockpdt.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author root
 */
@Entity
@Table(name = "stock", catalog = "opnam", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stock.findAll", query = "SELECT s FROM Stock s"),
    @NamedQuery(name = "Stock.findById", query = "SELECT s FROM Stock s WHERE s.id = :id"),
    @NamedQuery(name = "Stock.findBySiteid", query = "SELECT s FROM Stock s WHERE s.siteid = :siteid"),
    @NamedQuery(name = "Stock.findByPeriodeid", query = "SELECT s FROM Stock s WHERE s.periodeid = :periodeid"),
    @NamedQuery(name = "Stock.findByArticleid", query = "SELECT s FROM Stock s WHERE s.articleid = :articleid"),
    @NamedQuery(name = "Stock.findByQty", query = "SELECT s FROM Stock s WHERE s.qty = :qty"),
    @NamedQuery(name = "Stock.findByPendingqty", query = "SELECT s FROM Stock s WHERE s.pendingqty = :pendingqty"),
    @NamedQuery(name = "Stock.findByCreateddate", query = "SELECT s FROM Stock s WHERE s.createddate = :createddate"),
    @NamedQuery(name = "Stock.findByCreatedby", query = "SELECT s FROM Stock s WHERE s.createdby = :createdby"),
    @NamedQuery(name = "Stock.findByUpdateddate", query = "SELECT s FROM Stock s WHERE s.updateddate = :updateddate"),
    @NamedQuery(name = "Stock.findByUpdatedby", query = "SELECT s FROM Stock s WHERE s.updatedby = :updatedby")})
public class Stock implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "siteid")
    private String siteid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "periodeid")
    private int periodeid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "articleid")
    private String articleid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "qty")
    private double qty;
    @Basic(optional = false)
    @NotNull
    @Column(name = "pendingqty")
    private double pendingqty;
    @Basic(optional = false)
    @NotNull
    @Column(name = "createddate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createddate;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "createdby")
    private String createdby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "updateddate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateddate;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "updatedby")
    private String updatedby;

    public Stock() {
    }

    public Stock(Integer id) {
        this.id = id;
    }

    public Stock(Integer id, String siteid, int periodeid, String articleid, double qty, double pendingqty, Date createddate, String createdby, Date updateddate, String updatedby) {
        this.id = id;
        this.siteid = siteid;
        this.periodeid = periodeid;
        this.articleid = articleid;
        this.qty = qty;
        this.pendingqty = pendingqty;
        this.createddate = createddate;
        this.createdby = createdby;
        this.updateddate = updateddate;
        this.updatedby = updatedby;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSiteid() {
        return siteid;
    }

    public void setSiteid(String siteid) {
        this.siteid = siteid;
    }

    public int getPeriodeid() {
        return periodeid;
    }

    public void setPeriodeid(int periodeid) {
        this.periodeid = periodeid;
    }

    public String getArticleid() {
        return articleid;
    }

    public void setArticleid(String articleid) {
        this.articleid = articleid;
    }

    public double getQty() {
        return qty;
    }

    public void setQty(double qty) {
        this.qty = qty;
    }

    public double getPendingqty() {
        return pendingqty;
    }

    public void setPendingqty(double pendingqty) {
        this.pendingqty = pendingqty;
    }

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    public String getCreatedby() {
        return createdby;
    }

    public void setCreatedby(String createdby) {
        this.createdby = createdby;
    }

    public Date getUpdateddate() {
        return updateddate;
    }

    public void setUpdateddate(Date updateddate) {
        this.updateddate = updateddate;
    }

    public String getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(String updatedby) {
        this.updatedby = updatedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stock)) {
            return false;
        }
        Stock other = (Stock) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.jakc.stockpdt.entity.Stock[ id=" + id + " ]";
    }
    
}
