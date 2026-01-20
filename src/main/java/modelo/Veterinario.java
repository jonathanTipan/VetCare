package modelo;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;

@Entity
public class Veterinario extends Usuario {
    // Veterinario inherits cedula from Usuario
    private static final long serialVersionUID = 1L;

    @Column(name = "especialidad")
    private String especialidad;

    @Column(name = "numeroLicencia")
    private String numeroLicencia;

    @Column(name = "telefono")
    private String telefono;

    @OneToMany(mappedBy = "veterinario", fetch = FetchType.LAZY)
    private List<Consulta> consultas;

    public Veterinario() {
        super();
        this.consultas = new ArrayList<>();

    }

    public Veterinario(String cedula, String nombre, String apellido, String usuario, String clave,
            String especialidad, String numeroLicencia, String telefono) {
        super(cedula, nombre, apellido, usuario, clave);
        this.especialidad = especialidad;
        this.numeroLicencia = numeroLicencia;
        this.telefono = telefono;
        this.consultas = new ArrayList<>();

    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public String getNumeroLicencia() {
        return numeroLicencia;
    }

    public void setNumeroLicencia(String numeroLicencia) {
        this.numeroLicencia = numeroLicencia;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    @JsonIgnore
    public List<Consulta> getConsultas() {
        return consultas;
    }

    public void setConsultas(List<Consulta> consultas) {
        this.consultas = consultas;
    }

}
