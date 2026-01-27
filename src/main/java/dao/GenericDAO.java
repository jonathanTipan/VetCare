package dao;

import java.util.List;

public interface GenericDAO<T, ID> {

    public T obtenerPorId(ID id);

    public List<T> obtenerTodos();

    public void registrar(T entity);

    public void actualizar(T entity);

    public void eliminar(T entity);

    public void eliminarPorId(ID id);

}