package dao;

import modelo.Veterinario;

public interface VeterinarioDAO extends GenericDAO<Veterinario, String> {

    public boolean desactivarVeterinario(String cedula);

    public boolean validarDuplicado(String cedula);

}
