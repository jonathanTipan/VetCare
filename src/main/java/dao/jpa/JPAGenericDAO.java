package dao.jpa;

import java.util.List;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import soporte.JPAUtil;

public class JPAGenericDAO<T, ID> implements GenericDAO<T, ID> {
    private Class<T> persistentClass;
    protected EntityManager em;

    public JPAGenericDAO(Class<T> persistentClass) {
        this.persistentClass = persistentClass;
        this.em = JPAUtil.getEntityManager();
    }

    @Override
    public void registrar(T entity) {
        em.getTransaction().begin();
        try {
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(">>>> ERROR:JPAGenericDAO:registrar " + e);
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
        }
    }

    @Override
    public T obtenerPorId(ID id) {
        return em.find(persistentClass, id);
    }

    @Override
    public void actualizar(T entity) {
        em.getTransaction().begin();
        try {
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(">>>> ERROR:JPAGenericDAO:actualizar " + e);
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
        }

    }

    @Override
    public void eliminar(T entity) {
        em.getTransaction().begin();
        try {
            em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(">>>> ERROR:JPAGenericDAO:eliminar " + e);
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
        }

    }

    @Override
    public void eliminarPorId(ID id) {
        T entity = this.obtenerPorId(id);
        if (entity != null)
            this.eliminar(entity);

    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> obtenerTodos() {
        // Se crea un criterio de consulta
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.persistentClass);
        // Se establece la clausula FROM
        Root<T> root = criteriaQuery.from(this.persistentClass);
        // Se establece la clausula SELECT
        criteriaQuery.select(root);

        Query query = em.createQuery(criteriaQuery);
        return query.getResultList();
    }

}
