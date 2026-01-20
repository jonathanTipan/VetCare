package dao;

import dao.jpa.JPADAOFactory;

public abstract class DAOFactory {
    // Sería mejor por inyección de objetos
    protected static DAOFactory factory = new JPADAOFactory();

    public static DAOFactory getFactory() {
        return factory;
    }

    public abstract UsuarioDAO getUsuarioDAO();

    public abstract VeterinarioDAO getVeterinarioDAO();

    public abstract MascotaDAO getMascotaDAO();

    public abstract ConsultaDAO getConsultaDAO();

    public abstract ClienteDAO getClienteDAO();

    public abstract RecetaDAO getRecetaDAO();
}
