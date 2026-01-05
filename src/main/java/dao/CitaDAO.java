package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Date;
import java.util.List;
import modelo.Cita;
import soporte.JPAUtil;

public class CitaDAO {

    public boolean guardar(Cita c) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            if (c.getIdCita() != 0) {
                em.merge(c);
            } else {
                em.persist(c);
            }
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * List appointments by veterinarian
     */
    public List<Cita> listarPorVeterinario(int idVeterinario) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Cita c WHERE c.veterinario.id = :idVet", Cita.class)
                    .setParameter("idVet", idVeterinario)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * List appointments by client (through pets)
     */
    public List<Cita> listarPorCliente(int idCliente) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Cita c WHERE c.mascota.cliente.id = :idCliente", Cita.class)
                    .setParameter("idCliente", idCliente)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Cita buscarPorId(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Cita.class, id);
        } finally {
            em.close();
        }
    }
}
