package dao.jpa;

import dao.ClienteDAO;
import modelo.Cliente;

public class JPAClienteDAO extends JPAGenericDAO<Cliente, String> implements ClienteDAO {

    public JPAClienteDAO() {
        super(Cliente.class);
    }

}
