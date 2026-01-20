package dao.jpa;

import java.util.Collections;
import java.util.List;

import dao.ConsultaDAO;
import modelo.Consulta;

public class JPAConsultaDAO extends JPAGenericDAO<Consulta, Integer> implements ConsultaDAO {

    public JPAConsultaDAO() {
        super(Consulta.class);
    }

    @Override
    public List<Consulta> listarConsultas(String cedulaUsuario, boolean esVeterinario) {
        try {
            String jpql;
            if (esVeterinario) {
                // Listar todas las consultas (agendadas o atendidas) para el veterinario
                // Opcional: filtrar solo las asignadas a él o todas
                jpql = "SELECT c FROM Consulta c LEFT JOIN FETCH c.mascota m LEFT JOIN FETCH m.cliente WHERE c.veterinario.cedula = :cedula OR c.veterinario IS NULL ORDER BY c.fecha, c.hora";
            } else {
                // Para clientes: sus consultas
                jpql = "SELECT c FROM Consulta c JOIN c.mascota m WHERE m.cliente.cedula = :cedula ORDER BY c.fecha, c.hora";
            }
            return em.createQuery(jpql, Consulta.class)
                    .setParameter("cedula", cedulaUsuario)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Object> listarHorariosDisponibles(java.util.Date fecha) {
        try {
            return em.createQuery(
                    "SELECT c.hora FROM Consulta c WHERE c.fecha = :fecha AND c.estado = 'AGENDADA'",
                    Object.class)
                    .setParameter("fecha", fecha)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

}
