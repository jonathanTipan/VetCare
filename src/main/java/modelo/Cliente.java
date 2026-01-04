package modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Cliente implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idCliente;
    private String nombre;
    private List<Mascota> mascotas;

    public Cliente() {
        this.mascotas = new ArrayList<>();
    }

    public Cliente(int idCliente, String nombre) {
        super();
        this.idCliente = idCliente;
        this.nombre = nombre;
        this.mascotas = new ArrayList<>();
    }

    public int getIdentificacion() {
        return idCliente;
    }

    public void agregarMascota(Mascota m) {
        this.mascotas.add(m);
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public List<Mascota> getMascotas() {
        return mascotas;
    }

    public void setMascotas(List<Mascota> mascotas) {
        this.mascotas = mascotas;
    }

    @Override
    public String toString() {
        return "Cliente [idCliente=" + idCliente + ", nombre=" + nombre + "]";
    }
}
