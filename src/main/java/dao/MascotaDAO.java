package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Collections;
import java.util.List;
import modelo.Mascota;
import soporte.JPAUtil;

public class MascotaDAO {

    public boolean guardar(Mascota m) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            if (m.getId() != 0) {
                em.merge(m);
            } else {
                em.persist(m);
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

    public List<Mascota> buscarPorCliente(int idCliente) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT m FROM Mascota m WHERE m.cliente.id = :idCliente", Mascota.class)
                    .setParameter("idCliente", idCliente)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    public Mascota buscarPorId(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Mascota.class, id);
        } finally {
            em.close();
        }
    }

    public boolean eliminar(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Mascota m = em.find(Mascota.class, id);
            if (m != null) {
                em.remove(m);
            }
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            return false;
        } finally {
            em.close();
        }
    }
}
