package modelo;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

public class Cita implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idCita;
    private Date fecha;
    private Time hora;
    private String motivo;
    private String estado;
    private Consulta consulta;

    public Cita() {
    }

    public Cita(int idCita, Date fecha, Time hora, String motivo, String estado) {
        super();
        this.idCita = idCita;
        this.fecha = fecha;
        this.hora = hora;
        this.motivo = motivo;
        this.estado = estado;
    }

    public int getIdCita() {
        return idCita;
    }

    public void setIdCita(int idCita) {
        this.idCita = idCita;
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

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Consulta getConsulta() {
        return consulta;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }

    @Override
    public String toString() {
        return "Cita [idCita=" + idCita + ", fecha=" + fecha + ", estado=" + estado + "]";
    }
}
