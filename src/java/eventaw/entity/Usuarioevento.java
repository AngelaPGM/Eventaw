/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author angep
 */
@Entity
@Table(name = "USUARIOEVENTO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuarioevento.findAll", query = "SELECT u FROM Usuarioevento u")
    , @NamedQuery(name = "Usuarioevento.findById", query = "SELECT u FROM Usuarioevento u WHERE u.id = :id")
    , @NamedQuery(name = "Usuarioevento.findByNombre", query = "SELECT u FROM Usuarioevento u WHERE u.nombre = :nombre")
    , @NamedQuery(name = "Usuarioevento.findByApellido1", query = "SELECT u FROM Usuarioevento u WHERE u.apellido1 = :apellido1")
    , @NamedQuery(name = "Usuarioevento.findByApellido2", query = "SELECT u FROM Usuarioevento u WHERE u.apellido2 = :apellido2")
    , @NamedQuery(name = "Usuarioevento.findByDomicilio", query = "SELECT u FROM Usuarioevento u WHERE u.domicilio = :domicilio")
    , @NamedQuery(name = "Usuarioevento.findByCiudad", query = "SELECT u FROM Usuarioevento u WHERE u.ciudad = :ciudad")
    , @NamedQuery(name = "Usuarioevento.findByFechanacimiento", query = "SELECT u FROM Usuarioevento u WHERE u.fechanacimiento = :fechanacimiento")
    , @NamedQuery(name = "Usuarioevento.findBySexo", query = "SELECT u FROM Usuarioevento u WHERE u.sexo = :sexo")})
public class Usuarioevento implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "NOMBRE")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "APELLIDO1")
    private String apellido1;
    @Size(max = 45)
    @Column(name = "APELLIDO2")
    private String apellido2;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "DOMICILIO")
    private String domicilio;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "CIUDAD")
    private String ciudad;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FECHANACIMIENTO")
    @Temporal(TemporalType.DATE)
    private Date fechanacimiento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1)
    @Column(name = "SEXO")
    private String sexo;
    @JoinColumn(name = "IDUSUARIO", referencedColumnName = "ID")
    @OneToOne(optional = false)
    private Usuario idusuario;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "usuario")
    private List<Entrada> entradaList;

    public Usuarioevento() {
    }

    public Usuarioevento(Integer id) {
        this.id = id;
    }

    public Usuarioevento(Integer id, String nombre, String apellido1, String domicilio, String ciudad, Date fechanacimiento, String sexo) {
        this.id = id;
        this.nombre = nombre;
        this.apellido1 = apellido1;
        this.domicilio = domicilio;
        this.ciudad = ciudad;
        this.fechanacimiento = fechanacimiento;
        this.sexo = sexo;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido1() {
        return apellido1;
    }

    public void setApellido1(String apellido1) {
        this.apellido1 = apellido1;
    }

    public String getApellido2() {
        return apellido2;
    }

    public void setApellido2(String apellido2) {
        this.apellido2 = apellido2;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public Date getFechanacimiento() {
        return fechanacimiento;
    }

    public void setFechanacimiento(Date fechanacimiento) {
        this.fechanacimiento = fechanacimiento;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public Usuario getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Usuario idusuario) {
        this.idusuario = idusuario;
    }

    @XmlTransient
    public List<Entrada> getEntradaList() {
        return entradaList;
    }

    public void setEntradaList(List<Entrada> entradaList) {
        this.entradaList = entradaList;
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
        if (!(object instanceof Usuarioevento)) {
            return false;
        }
        Usuarioevento other = (Usuarioevento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "eventaw.entity.Usuarioevento[ id=" + id + " ]";
    }
    
}
