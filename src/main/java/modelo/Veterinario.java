package modelo;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "veterinarios")
@PrimaryKeyJoinColumn(name = "idusuario")
public class Veterinario extends Usuario {
    private static final long serialVersionUID = 1L;

    @Column(name = "identificacion")
    private String identificacion; // Specific field

    @Column(name = "telefono")
    private String telefono;

    @Column(name = "especialidad")
    private String especialidad;

    public Veterinario() {
        super();
        this.setRol("VETERINARIO");
    }

    public Veterinario(String nombre, String usuario, String clave, String identificacion) {
        super(nombre, usuario, clave, "VETERINARIO");
        this.identificacion = identificacion;
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public boolean validarCupo(Date fecha) {
        // Logic to check availability in DB could be here or in Service
        return true;
    }
}
