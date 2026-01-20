package dao.jpa;

import dao.VeterinarioDAO;
import jakarta.persistence.NoResultException;
import modelo.Veterinario;

public class JPAVeterinarioDAO extends JPAGenericDAO<Veterinario, String> implements VeterinarioDAO {

    public JPAVeterinarioDAO() {
        super(Veterinario.class);
    }

    @Override
    public boolean desactivarVeterinario(String cedula) {
        em.getTransaction().begin();
        try {
            Veterinario v = em.find(Veterinario.class, cedula);
            if (v != null) {
                if ("INACTIVO".equals(v.getEstado())) {
                    if (em.getTransaction().isActive())
                        em.getTransaction().rollback();
                    return false; // Ya está inactivo
                }
                v.setEstado("INACTIVO");
                em.merge(v);
                em.getTransaction().commit();
                return true;
            } else {
                if (em.getTransaction().isActive())
                    em.getTransaction().rollback();
                return false; // No existe
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean validarDuplicado(String cedula) {
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(v) FROM Veterinario v WHERE v.cedula = :cedula",
                    Long.class)
                    .setParameter("cedula", cedula)
                    .getSingleResult();
            return count > 0;
        } catch (NoResultException e) {
            return false;
        }
    }

}
