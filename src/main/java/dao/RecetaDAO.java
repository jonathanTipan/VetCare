package dao;

import java.util.List;

import modelo.Receta;

public interface RecetaDAO extends GenericDAO<Receta, Integer> {

    public List<Receta> listarRecetas(int idConsulta);

}
