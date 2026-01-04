package modelo;

import java.io.Serializable;
import java.util.Date;

public class Mascota implements Serializable {
    private static final long serialVersionUID = 1L;

    private String nombre;
    private String especie;
    private String raza;
    private Date fechaNac;
    private double peso;
    private Byte foto;

    public Mascota() {
    }

    public Mascota(String nombre, String especie, String raza, Date fechaNac, double peso) {
        super();
        this.nombre = nombre;
        this.especie = especie;
        this.raza = raza;
        this.fechaNac = fechaNac;
        this.peso = peso;
    }

    public Mascota(String nombre, String especie, String raza, Date fechaNac, double peso, Byte foto) {
        super();
        this.nombre = nombre;
        this.especie = especie;
        this.raza = raza;
        this.fechaNac = fechaNac;
        this.peso = peso;
        this.foto = foto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie = especie;
    }

    public String getRaza() {
        return raza;
    }

    public void setRaza(String raza) {
        this.raza = raza;
    }

    public Date getFechaNac() {
        return fechaNac;
    }

    public void setFechaNac(Date fechaNac) {
        this.fechaNac = fechaNac;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public Byte getFoto() {
        return foto;
    }

    public void setFoto(Byte foto) {
        this.foto = foto;
    }

    @Override
    public String toString() {
        return "Mascota [nombre=" + nombre + ", especie=" + especie + ", raza=" + raza + ", peso=" + peso + "]";
    }
}
