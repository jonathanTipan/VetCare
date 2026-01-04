package modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class HistorialClinico implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idHistorial;
    private List<Consulta> consultas;

    public HistorialClinico() {
        this.consultas = new ArrayList<>();
    }

    public HistorialClinico(int idHistorial) {
        super();
        this.idHistorial = idHistorial;
        this.consultas = new ArrayList<>();
    }

    public int getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(int idHistorial) {
        this.idHistorial = idHistorial;
    }

    public List<Consulta> getConsultas() {
        return consultas;
    }

    public void setConsultas(List<Consulta> consultas) {
        this.consultas = consultas;
    }

    public void asociarConsulta(Consulta c) {
        this.consultas.add(c);
    }

    @Override
    public String toString() {
        return "HistorialClinico [idHistorial=" + idHistorial + "]";
    }
}
