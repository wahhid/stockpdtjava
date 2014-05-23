/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jakc.stockpdt.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author root
 */
@Entity
@Table(name = "transseq", catalog = "opnam", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Transseq.findAll", query = "SELECT t FROM Transseq t"),
    @NamedQuery(name = "Transseq.findByIdseq", query = "SELECT t FROM Transseq t WHERE t.idseq = :idseq"),
    @NamedQuery(name = "Transseq.findBySiteid", query = "SELECT t FROM Transseq t WHERE t.siteid = :siteid"),
    @NamedQuery(name = "Transseq.findByPeriodeid", query = "SELECT t FROM Transseq t WHERE t.periodeid = :periodeid"),
    @NamedQuery(name = "Transseq.findByGondolaid", query = "SELECT t FROM Transseq t WHERE t.gondolaid = :gondolaid"),
    @NamedQuery(name = "Transseq.findBySequence", query = "SELECT t FROM Transseq t WHERE t.sequence = :sequence")})
public class Transseq implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "idseq")
    private Integer idseq;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "siteid")
    private String siteid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "periodeid")
    private String periodeid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "gondolaid")
    private String gondolaid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "sequence")
    private int sequence;

    public Transseq() {
    }

    public Transseq(Integer idseq) {
        this.idseq = idseq;
    }

    public Transseq(Integer idseq, String siteid, String periodeid, String gondolaid, int sequence) {
        this.idseq = idseq;
        this.siteid = siteid;
        this.periodeid = periodeid;
        this.gondolaid = gondolaid;
        this.sequence = sequence;
    }

    public Integer getIdseq() {
        return idseq;
    }

    public void setIdseq(Integer idseq) {
        this.idseq = idseq;
    }

    public String getSiteid() {
        return siteid;
    }

    public void setSiteid(String siteid) {
        this.siteid = siteid;
    }

    public String getPeriodeid() {
        return periodeid;
    }

    public void setPeriodeid(String periodeid) {
        this.periodeid = periodeid;
    }

    public String getGondolaid() {
        return gondolaid;
    }

    public void setGondolaid(String gondolaid) {
        this.gondolaid = gondolaid;
    }

    public int getSequence() {
        return sequence;
    }

    public void setSequence(int sequence) {
        this.sequence = sequence;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idseq != null ? idseq.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Transseq)) {
            return false;
        }
        Transseq other = (Transseq) object;
        if ((this.idseq == null && other.idseq != null) || (this.idseq != null && !this.idseq.equals(other.idseq))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.jakc.stockpdt.entity.Transseq[ idseq=" + idseq + " ]";
    }
    
}
