package dao.jpa;

import java.util.List;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
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
    public void create(T entity) {
        em.getTransaction().begin();
        try {
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(">>>> ERROR:JPAGenericDAO:create " + e);
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
        }
    }

    @Override
    public T getById(ID id) {
        return em.find(persistentClass, id);
    }

    @Override
    public void update(T entity) {
        em.getTransaction().begin();
        try {
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(">>>> ERROR:JPAGenericDAO:update " + e);
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
        }

    }

    @Override
    public void delete(T entity) {
        em.getTransaction().begin();
        try {
            em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(">>>> ERROR:JPAGenericDAO:delete " + e);
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
        }

    }

    @Override
    public void deleteByID(ID id) {
        T entity = this.getById(id);
        if (entity != null)
            this.delete(entity);

    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> get(String[] attributes, String[] values) {
        // Se crea un criterio de consulta
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.persistentClass);
        // Se establece la clausula FROM
        Root<T> root = criteriaQuery.from(this.persistentClass);
        // Se establece la clausula SELECT
        criteriaQuery.select(root);
        // Se configuran los predicados, combinados por AND
        Predicate predicate = criteriaBuilder.conjunction();
        for (int i = 0; i < attributes.length; i++) {
            Predicate sig = criteriaBuilder.like(root.get(attributes[i]).as(String.class), values[i]);
            predicate = criteriaBuilder.and(predicate, sig);
        }
        // Se establece el WHERE
        criteriaQuery.where(predicate);

        Query query = em.createQuery(criteriaQuery);
        return query.getResultList();

    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> get(String[] attributes, String[] values, String order, int index, int size) {
        // Se crea un criterio de consulta
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.persistentClass);
        // Se establece la clausula FROM
        Root<T> root = criteriaQuery.from(this.persistentClass);
        // Se establece la clausula SELECT
        criteriaQuery.select(root);
        // Se configuran los predicados, combinados por AND
        Predicate predicate = criteriaBuilder.conjunction();
        for (int i = 0; i < attributes.length; i++) {
            Predicate sig = criteriaBuilder.like(root.get(attributes[i]).as(String.class), values[i]);
            predicate = criteriaBuilder.and(predicate, sig);
        }
        // Se establece el WHERE
        criteriaQuery.where(predicate);
        // Se establece el orden
        if (order != null)
            criteriaQuery.orderBy(criteriaBuilder.asc(root.get(order)));
        // Se crea el resultado
        if (index >= 0 && size > 0) {
            TypedQuery<T> tq = em.createQuery(criteriaQuery);
            tq.setFirstResult(index);
            tq.setMaxResults(size); // Se realiza la query
            return tq.getResultList();
        } else {
            // Se realiza la query
            Query query = em.createQuery(criteriaQuery);
            return query.getResultList();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> get() {
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
