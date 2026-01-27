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
    public List<Consulta> obtenerPorUsuario(modelo.Usuario usuario) {
        try {
            String jpql;
            if (usuario instanceof modelo.Veterinario) {
                // Listar todas las consultas para el veterinario
                jpql = "SELECT c FROM Consulta c LEFT JOIN FETCH c.mascota m LEFT JOIN FETCH m.cliente WHERE c.veterinario.cedula = :cedula OR c.veterinario IS NULL ORDER BY c.fecha, c.hora";
                return em.createQuery(jpql, Consulta.class)
                        .setParameter("cedula", usuario.getCedula())
                        .getResultList();
            } else if (usuario instanceof modelo.Cliente) {
                // Para clientes: sus consultas
                jpql = "SELECT c FROM Consulta c JOIN c.mascota m WHERE m.cliente.cedula = :cedula ORDER BY c.fecha, c.hora";
                return em.createQuery(jpql, Consulta.class)
                        .setParameter("cedula", usuario.getCedula())
                        .getResultList();
            } else if (usuario instanceof modelo.Administrador) {
                // Para administradores: todas las consultas
                jpql = "SELECT c FROM Consulta c LEFT JOIN FETCH c.mascota m LEFT JOIN FETCH m.cliente LEFT JOIN FETCH c.veterinario ORDER BY c.fecha, c.hora";
                return em.createQuery(jpql, Consulta.class).getResultList();
            }
            return Collections.emptyList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    @Override
    public List<java.sql.Time> obtenerConsultasDisponibles(java.util.Date fecha, String idVeterinario) {
        try {
            return em.createQuery(
                    "SELECT c.hora FROM Consulta c WHERE c.fecha = :fecha AND c.veterinario.cedula = :cedula AND c.estado = 'AGENDADA'",
                    java.sql.Time.class)
                    .setParameter("fecha", fecha)
                    .setParameter("cedula", idVeterinario)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

}
