package modelo;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

public class Consulta implements Serializable {
    private static final long serialVersionUID = 1L;

    private Date fecha;
    private Time hora;
    private String sintomas;
    private String diagnostico;
    private String tratamiento;

    public Consulta() {
    }

    public Consulta(Date fecha, Time hora, String diagnostico, String tratamiento) {
        super();
        this.fecha = fecha;
        this.hora = hora;
        this.diagnostico = diagnostico;
        this.tratamiento = tratamiento;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Time getHora() {
        return hora;
    }

    public void setHora(Time hora) {
        this.hora = hora;
    }

    public String getSintomas() {
        return sintomas;
    }

    public void setSintomas(String sintomas) {
        this.sintomas = sintomas;
    }

    public String getDiagnostico() {
        return diagnostico;
    }

    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
    }

    public String getTratamiento() {
        return tratamiento;
    }

    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }

    @Override
    public String toString() {
        return "Consulta [fecha=" + fecha + ", hora=" + hora + ", diagnostico=" + diagnostico + "]";
    }
}
