package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import modelo.Usuario;
import modelo.Veterinario;
import soporte.JPAUtil;

public class UsuarioDAO {

    public Usuario validarCredenciales(String usuario, String clave) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Usuario> query = em.createQuery(
                    "SELECT u FROM Usuario u WHERE u.usuario = :usuario AND u.clave = :clave AND u.estado = 'ACTIVO'",
                    Usuario.class);
            query.setParameter("usuario", usuario);
            query.setParameter("clave", clave);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public boolean guardar(Usuario usuario) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(usuario);
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

    public boolean actualizar(Usuario usuario) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(usuario);
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

    public Usuario buscarPorId(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public List<Veterinario> listarVeterinarios() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT v FROM Veterinario v", Veterinario.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Veterinario> listarVeterinariosActivos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT v FROM Veterinario v WHERE v.estado = 'ACTIVO'", Veterinario.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public boolean desactivar(int idUsuario) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Usuario u = em.find(Usuario.class, idUsuario);
            if (u != null) {
                u.setEstado("INACTIVO");
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

    public java.util.List<Usuario> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM Usuario u ORDER BY u.nombre", Usuario.class).getResultList();
        } finally {
            em.close();
        }
    }
}
