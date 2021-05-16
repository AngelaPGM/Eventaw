/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.entity;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author rafa
 */
@Entity
@Table(name = "ANALISIS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Analisis.findAll", query = "SELECT a FROM Analisis a")
    , @NamedQuery(name = "Analisis.findByAnalisisid", query = "SELECT a FROM Analisis a WHERE a.analisisid = :analisisid")
    , @NamedQuery(name = "Analisis.findByNombre", query = "SELECT a FROM Analisis a WHERE a.nombre = :nombre")
    , @NamedQuery(name = "Analisis.findByFechamayor", query = "SELECT a FROM Analisis a WHERE a.fechamayor = :fechamayor")
    , @NamedQuery(name = "Analisis.findByFechamenor", query = "SELECT a FROM Analisis a WHERE a.fechamenor = :fechamenor")
    , @NamedQuery(name = "Analisis.findByFechaigual", query = "SELECT a FROM Analisis a WHERE a.fechaigual = :fechaigual")
    , @NamedQuery(name = "Analisis.findByPreciomayor", query = "SELECT a FROM Analisis a WHERE a.preciomayor = :preciomayor")
    , @NamedQuery(name = "Analisis.findByPreciomenor", query = "SELECT a FROM Analisis a WHERE a.preciomenor = :preciomenor")
    , @NamedQuery(name = "Analisis.findByPrecioigual", query = "SELECT a FROM Analisis a WHERE a.precioigual = :precioigual")
    , @NamedQuery(name = "Analisis.findByCiudadevento", query = "SELECT a FROM Analisis a WHERE a.ciudadevento = :ciudadevento")
    , @NamedQuery(name = "Analisis.findByCiudadusuario", query = "SELECT a FROM Analisis a WHERE a.ciudadusuario = :ciudadusuario")
    , @NamedQuery(name = "Analisis.findByEdadmayor", query = "SELECT a FROM Analisis a WHERE a.edadmayor = :edadmayor")
    , @NamedQuery(name = "Analisis.findByEdadmenor", query = "SELECT a FROM Analisis a WHERE a.edadmenor = :edadmenor")
    , @NamedQuery(name = "Analisis.findByEdadigual", query = "SELECT a FROM Analisis a WHERE a.edadigual = :edadigual")
    , @NamedQuery(name = "Analisis.findBySexo", query = "SELECT a FROM Analisis a WHERE a.sexo = :sexo")})
public class Analisis implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ANALISISID")
    private Integer analisisid;
    @Size(max = 30)
    @Column(name = "NOMBRE")
    private String nombre;
    @Column(name = "FECHAMAYOR")
    @Temporal(TemporalType.DATE)
    private Date fechamayor;
    @Column(name = "FECHAMENOR")
    @Temporal(TemporalType.DATE)
    private Date fechamenor;
    @Column(name = "FECHAIGUAL")
    @Temporal(TemporalType.DATE)
    private Date fechaigual;
    @Column(name = "PRECIOMAYOR")
    private Integer preciomayor;
    @Column(name = "PRECIOMENOR")
    private Integer preciomenor;
    @Column(name = "PRECIOIGUAL")
    private Integer precioigual;
    @Size(max = 45)
    @Column(name = "CIUDADEVENTO")
    private String ciudadevento;
    @Size(max = 45)
    @Column(name = "CIUDADUSUARIO")
    private String ciudadusuario;
    @Column(name = "EDADMAYOR")
    private Integer edadmayor;
    @Column(name = "EDADMENOR")
    private Integer edadmenor;
    @Column(name = "EDADIGUAL")
    private Integer edadigual;
    @Size(max = 1)
    @Column(name = "SEXO")
    private String sexo;

    public Analisis() {
    }

    public Analisis(Integer analisisid) {
        this.analisisid = analisisid;
    }

    public Integer getAnalisisid() {
        return analisisid;
    }

    public void setAnalisisid(Integer analisisid) {
        this.analisisid = analisisid;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFechamayor() {
        return fechamayor;
    }

    public void setFechamayor(Date fechamayor) {
        this.fechamayor = fechamayor;
    }

    public Date getFechamenor() {
        return fechamenor;
    }

    public void setFechamenor(Date fechamenor) {
        this.fechamenor = fechamenor;
    }

    public Date getFechaigual() {
        return fechaigual;
    }

    public void setFechaigual(Date fechaigual) {
        this.fechaigual = fechaigual;
    }

    public Integer getPreciomayor() {
        return preciomayor;
    }

    public void setPreciomayor(Integer preciomayor) {
        this.preciomayor = preciomayor;
    }

    public Integer getPreciomenor() {
        return preciomenor;
    }

    public void setPreciomenor(Integer preciomenor) {
        this.preciomenor = preciomenor;
    }

    public Integer getPrecioigual() {
        return precioigual;
    }

    public void setPrecioigual(Integer precioigual) {
        this.precioigual = precioigual;
    }

    public String getCiudadevento() {
        return ciudadevento;
    }

    public void setCiudadevento(String ciudadevento) {
        this.ciudadevento = ciudadevento;
    }

    public String getCiudadusuario() {
        return ciudadusuario;
    }

    public void setCiudadusuario(String ciudadusuario) {
        this.ciudadusuario = ciudadusuario;
    }

    public Integer getEdadmayor() {
        return edadmayor;
    }

    public void setEdadmayor(Integer edadmayor) {
        this.edadmayor = edadmayor;
    }

    public Integer getEdadmenor() {
        return edadmenor;
    }

    public void setEdadmenor(Integer edadmenor) {
        this.edadmenor = edadmenor;
    }

    public Integer getEdadigual() {
        return edadigual;
    }

    public void setEdadigual(Integer edadigual) {
        this.edadigual = edadigual;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (analisisid != null ? analisisid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Analisis)) {
            return false;
        }
        Analisis other = (Analisis) object;
        if ((this.analisisid == null && other.analisisid != null) || (this.analisisid != null && !this.analisisid.equals(other.analisisid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "eventaw.entity.Analisis[ analisisid=" + analisisid + " ]";
    }
    
}
