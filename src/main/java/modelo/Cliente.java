package modelo;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Cliente extends Usuario {
    private static final long serialVersionUID = 1L;

    @OneToMany(mappedBy = "cliente", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Mascota> mascotas;

    public Cliente() {
        super();
        this.mascotas = new ArrayList<>();
    }

    public Cliente(String cedula, String nombre, String apellido, String usuario, String clave) {
        super(cedula, nombre, apellido, usuario, clave);
        this.mascotas = new ArrayList<>();
    }

    public List<Mascota> getMascotas() {
        return mascotas;
    }

    public void setMascotas(List<Mascota> mascotas) {
        this.mascotas = mascotas;
    }

    public void agregarMascota(Mascota m) {
        if (this.mascotas == null) {
            this.mascotas = new ArrayList<>();
        }
        this.mascotas.add(m);
        m.setCliente(this);
    }
}
