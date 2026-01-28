package recursos;

import java.util.List;

import dao.FactoryDAO;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import modelo.Veterinario;

@Path("/veterinarios")
public class RecursoVeterinario {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Veterinario> getVeterinarios() {
        return FactoryDAO.getFactory().getVeterinarioDAO().obtenerTodos();
    }

    @GET
    @Path("/{cedula}")
    @Produces(MediaType.APPLICATION_JSON)
    public Veterinario getVeterinario(@PathParam("cedula") String cedula) {
        return FactoryDAO.getFactory().getVeterinarioDAO().obtenerPorId(cedula);
    }

    @POST
    @Path("/add")
    @Consumes(MediaType.APPLICATION_JSON)
    public void guardarVeterinario(Veterinario v) {
        FactoryDAO.getFactory().getVeterinarioDAO().registrar(v);
    }

    @PUT
    @Path("/update")
    @Consumes(MediaType.APPLICATION_JSON)
    public void actualizarVeterinario(Veterinario v) {
        FactoryDAO.getFactory().getVeterinarioDAO().actualizar(v);
    }

    @PUT
    @Path("/deactivate/{cedula}")
    public void desactivarVeterinario(@PathParam("cedula") String cedula) {
        FactoryDAO.getFactory().getVeterinarioDAO().desactivarVeterinario(cedula);
    }
}
