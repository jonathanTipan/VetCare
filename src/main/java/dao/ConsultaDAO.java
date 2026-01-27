package dao;

import java.util.List;

import modelo.Consulta;

public interface ConsultaDAO extends GenericDAO<Consulta, Integer> {

    public List<Consulta> obtenerPorUsuario(modelo.Usuario u);

    public List<java.sql.Time> obtenerConsultasDisponibles(java.util.Date fecha, String idVeterinario);

    public void registrar(Consulta c);

    public void actualizar(Consulta c);

    public Consulta obtenerPorId(Integer id);

}
