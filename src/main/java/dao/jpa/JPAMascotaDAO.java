package dao.jpa;

import java.util.Collections;
import java.util.List;

import dao.MascotaDAO;
import modelo.Mascota;

public class JPAMascotaDAO extends JPAGenericDAO<Mascota, Integer> implements MascotaDAO {

    public JPAMascotaDAO() {
        super(Mascota.class);
    }

    @Override
    public List<Mascota> obtenerPorCliente(String cedula) {
        try {
            return em.createQuery("SELECT m FROM Mascota m WHERE m.cliente.cedula = :cedula", Mascota.class)
                    .setParameter("cedula", cedula)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
