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
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Pepe
 */
@Entity
@Table(name = "USUARIOEVENTO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuarioevento.findAll", query = "SELECT u FROM Usuarioevento u")
    , @NamedQuery(name = "Usuarioevento.findByIdusuario", query = "SELECT u FROM Usuarioevento u WHERE u.idusuario = :idusuario")
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
    @Column(name = "IDUSUARIO")
    private Integer idusuario;
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
    @JoinColumn(name = "IDUSUARIO", referencedColumnName = "ID", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Usuario usuario;

    public Usuarioevento() {
    }

    public Usuarioevento(Integer idusuario) {
        this.idusuario = idusuario;
    }

    public Usuarioevento(Integer idusuario, String nombre, String apellido1, String domicilio, String ciudad, Date fechanacimiento, String sexo) {
        this.idusuario = idusuario;
        this.nombre = nombre;
        this.apellido1 = apellido1;
        this.domicilio = domicilio;
        this.ciudad = ciudad;
        this.fechanacimiento = fechanacimiento;
        this.sexo = sexo;
    }

    public Integer getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Integer idusuario) {
        this.idusuario = idusuario;
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

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idusuario != null ? idusuario.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Usuarioevento)) {
            return false;
        }
        Usuarioevento other = (Usuarioevento) object;
        if ((this.idusuario == null && other.idusuario != null) || (this.idusuario != null && !this.idusuario.equals(other.idusuario))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "eventaw.entity.Usuarioevento[ idusuario=" + idusuario + " ]";
    }
    
}
