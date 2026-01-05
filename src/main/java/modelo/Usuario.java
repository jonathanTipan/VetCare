package modelo;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "usuarios")
@Inheritance(strategy = InheritanceType.JOINED)
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id; // Unified ID

    @Column(nullable = false)
    private String nombre;

    @Column(unique = true, nullable = false)
    private String usuario; // Username/Email

    @Column(nullable = false)
    private String clave;

    @Column(nullable = false)
    private String rol; // "CLIENTE", "VETERINARIO", "ADMIN"

    @Column(length = 20)
    private String estado = "ACTIVO"; // "ACTIVO", "INACTIVO"

    // Default Constructor
    public Usuario() {
    }

    public Usuario(String nombre, String usuario, String clave, String rol) {
        this.nombre = nombre;
        this.usuario = usuario;
        this.clave = clave;
        this.rol = rol;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
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

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    @Override
    public String toString() {
        return "Usuario [id=" + id + ", nombre=" + nombre + ", rol=" + rol + "]";
    }
}
