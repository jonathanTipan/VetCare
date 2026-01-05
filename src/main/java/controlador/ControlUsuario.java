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
            List<Usuario> lista = usuarioDAO.listarTodos();
            req.setAttribute("usuarios", lista);
            req.getRequestDispatcher("vista/gestionUsuarios.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("vista/home-admin.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implementar guardar/editar si es necesario
        doGet(req, resp);
    }
}
