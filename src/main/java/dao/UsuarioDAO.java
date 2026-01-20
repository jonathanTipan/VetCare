package dao;

import java.util.List;

import modelo.Usuario;

public interface UsuarioDAO extends GenericDAO<Usuario, String> {

    public Usuario autenticarse(String usuario, String clave);

    public List<String> obtenerRoles();

}
