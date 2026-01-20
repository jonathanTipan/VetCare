package dao.jpa;

import java.util.Collections;
import java.util.List;

import dao.RecetaDAO;
import modelo.Receta;

public class JPARecetaDAO extends JPAGenericDAO<Receta, Integer> implements RecetaDAO {

    public JPARecetaDAO() {
        super(Receta.class);
    }

    @Override
    public List<Receta> listarRecetas(int idConsulta) {
        try {
            return em.createQuery("SELECT r FROM Receta r WHERE r.consulta.id = :id", Receta.class)
                    .setParameter("id", idConsulta)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

}
