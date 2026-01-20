package modelo;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "usuarios")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(length = 20)
    // Primary Key (Cedula)
    private String cedula;

    @Column(nullable = false)
    private String usuario;

    @Column(nullable = false)
    private String clave;

    @Column(length = 20)
    private String estado = "ACTIVO";

    @Column(nullable = false)
    private String nombre;

    @Column(nullable = false)
    private String apellido;

    public Usuario() {
    }

    public Usuario(String cedula, String nombre, String apellido, String usuario, String clave) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.apellido = apellido;
        this.usuario = usuario;
        this.clave = clave;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getRol() {
        return this.getClass().getSimpleName();
    }

    @Override
    public String toString() {
        return "Usuario [cedula=" + cedula + ", nombre=" + nombre + ", apellido=" + apellido + "]";
    }
}
