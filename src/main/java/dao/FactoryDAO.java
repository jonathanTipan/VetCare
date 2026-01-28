package dao;

import dao.jpa.JPAFactoryDAO;

public abstract class FactoryDAO {
    // Sería mejor por inyección de objetos
    protected static FactoryDAO factory = new JPAFactoryDAO();

    public static FactoryDAO getFactory() {
        return factory;
    }

    public abstract UsuarioDAO getUsuarioDAO();

    public abstract VeterinarioDAO getVeterinarioDAO();

    public abstract MascotaDAO getMascotaDAO();

    public abstract ConsultaDAO getConsultaDAO();

    public abstract ClienteDAO getClienteDAO();

    public abstract RecetaDAO getRecetaDAO();
}
