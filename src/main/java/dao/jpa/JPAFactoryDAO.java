package dao.jpa;

import dao.ClienteDAO;
import dao.ConsultaDAO;
import dao.DAOFactory;
import dao.MascotaDAO;
import dao.RecetaDAO;
import dao.UsuarioDAO;
import dao.VeterinarioDAO;

public class JPAFactoryDAO extends DAOFactory {

    @Override
    public UsuarioDAO getUsuarioDAO() {
        return new JPAUsuarioDAO();
    }

    @Override
    public VeterinarioDAO getVeterinarioDAO() {
        return new JPAVeterinarioDAO();
    }

    @Override
    public MascotaDAO getMascotaDAO() {
        return new JPAMascotaDAO();
    }

    @Override
    public ConsultaDAO getConsultaDAO() {
        return new JPAConsultaDAO();
    }

    @Override
    public ClienteDAO getClienteDAO() {
        return new JPAClienteDAO();
    }

    @Override
    public RecetaDAO getRecetaDAO() {
        return new JPARecetaDAO();
    }

}
