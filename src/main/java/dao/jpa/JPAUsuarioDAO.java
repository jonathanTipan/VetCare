package dao.jpa;

import java.util.List;

import dao.UsuarioDAO;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import modelo.Usuario;

public class JPAUsuarioDAO extends JPAGenericDAO<Usuario, String> implements UsuarioDAO {

    public JPAUsuarioDAO() {
        super(Usuario.class);
    }

    @Override
    public Usuario autenticarse(String usuario, String clave) {
        try {
            TypedQuery<Usuario> query = em.createQuery(
                    "SELECT u FROM Usuario u WHERE u.usuario = :usuario AND u.clave = :clave AND u.estado = 'ACTIVO'",
                    Usuario.class);
            query.setParameter("usuario", usuario);
            query.setParameter("clave", clave);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<String> obtenerRoles() {
        return em.createNativeQuery("SELECT DISTINCT DTYPE FROM usuarios").getResultList();
    }

}
