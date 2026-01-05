package controlador;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;
import modelo.Veterinario;
import dao.UsuarioDAO;

@WebServlet("/ControlUsuario")
public class ControlUsuario extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UsuarioDAO usuarioDAO;

    public ControlUsuario() {
        super();
        this.usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        HttpSession session = req.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u == null || !"ADMIN".equals(u.getRol())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        if ("listar".equals(accion)) {
            // Filter by Role: VETERINARIO
            List<Veterinario> lista = usuarioDAO.listarVeterinarios();
            req.setAttribute("veterinarios", lista);
            req.getRequestDispatcher("vista/gestionVeterinarios.jsp").forward(req, resp);

        } else if ("formulario".equals(accion)) {
            // Show form for Register/Edit
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                Usuario userToEdit = usuarioDAO.buscarPorId(Integer.parseInt(idStr));
                if (userToEdit instanceof Veterinario) {
                    req.setAttribute("veterinario", userToEdit);
                }
            }
            req.getRequestDispatcher("vista/registrarVeterinario.jsp").forward(req, resp);

        } else if ("desactivar".equals(accion)) {
            // Deactivate logic
            int id = Integer.parseInt(req.getParameter("id"));
            usuarioDAO.desactivar(id);
            resp.sendRedirect("ControlUsuario?accion=listar");

        } else {
            resp.sendRedirect("vista/home-admin.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String nombre = req.getParameter("nombre");
        String identificacion = req.getParameter("identificacion");
        String usuario = req.getParameter("usuario");
        String especialidad = req.getParameter("especialidad");
        String telefono = req.getParameter("telefono");
        String clave = req.getParameter("clave"); // Optional if editing?

        Veterinario v = new Veterinario();
        if (idStr != null && !idStr.isEmpty()) {
            // Edit
            v = (Veterinario) usuarioDAO.buscarPorId(Integer.parseInt(idStr));
            v.setNombre(nombre);
            v.setIdentificacion(identificacion);
            v.setUsuario(usuario);
            v.setEspecialidad(especialidad);
            v.setTelefono(telefono);
            // Only update password if provided
            if (clave != null && !clave.trim().isEmpty()) {
                v.setClave(clave);
            }
            usuarioDAO.actualizar(v);
        } else {
            // Create
            v.setNombre(nombre);
            v.setIdentificacion(identificacion);
            v.setUsuario(usuario);
            v.setClave(clave); // Required for new
            v.setEspecialidad(especialidad);
            v.setTelefono(telefono);
            v.setRol("VETERINARIO");
            v.setEstado("ACTIVO");
            usuarioDAO.guardar(v);
        }

        resp.sendRedirect("ControlUsuario?accion=listar");
    }
}
