package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import modelo.Consulta;
import modelo.Cita;
import soporte.JPAUtil;

public class ConsultaDAO {

    public boolean guardar(Consulta consulta) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            // Save consultation
            em.persist(consulta);

            // Update appointment status to ATENDIDA
            Cita c = consulta.getCita();
            if (c != null) {
                // Merge Cita if detached, though cascading might handle it if set up right.
                // Safest to just find and set.
                Cita managedCita = em.find(Cita.class, c.getIdCita());
                if (managedCita != null) {
                    managedCita.setEstado("ATENDIDA");
                    managedCita.setConsulta(consulta);
                }
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
}
