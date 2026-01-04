package modelo;

import java.io.Serializable;
import java.util.Date;

public class Veterinario implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idVet;
    private String nombre;

    public Veterinario() {
    }

    public Veterinario(int idVet, String nombre) {
        super();
        this.idVet = idVet;
        this.nombre = nombre;
    }

    public int getIdVet() {
        return idVet;
    }

    public void setIdVet(int idVet) {
        this.idVet = idVet;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public boolean validarCupo(Date fecha) {
        // Validation logic
        return true;
    }

    @Override
    public String toString() {
        return "Veterinario [idVet=" + idVet + ", nombre=" + nombre + "]";
    }
}
