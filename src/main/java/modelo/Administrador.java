package modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;

@Entity
public class Administrador extends Usuario {
    private static final long serialVersionUID = 1L;

    @Column(name = "departamento")
    private String departamento;

    public Administrador() {
        super();
    }

    public Administrador(String cedula, String nombre, String apellido, String usuario, String clave,
            String departamento) {
        super(cedula, nombre, apellido, usuario, clave);
        this.departamento = departamento;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    @Override
    public String toString() {
        return "Administrador [departamento=" + departamento + ", toString()=" + super.toString() + "]";
    }
}
