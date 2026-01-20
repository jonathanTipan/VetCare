package dao;

import java.util.List;

import modelo.Consulta;

public interface ConsultaDAO extends GenericDAO<Consulta, Integer> {

    public List<Consulta> listarConsultas(String cedulaUsuario, boolean esVeterinario);

    public List<Object> listarHorariosDisponibles(java.util.Date fecha);

}
