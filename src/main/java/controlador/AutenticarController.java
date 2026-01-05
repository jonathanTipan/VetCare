package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;
import dao.UsuarioDAO;

@WebServlet("/AutenticarController")
public class AutenticarController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UsuarioDAO usuarioDAO;

    public AutenticarController() {
        super();
        this.usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if ("login".equals(accion)) {
            login(req, resp);
        } else if ("logout".equals(accion)) {
            logout(req, resp);
        } else {
            login(req, resp); // Default to login attempt
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if ("logout".equals(accion)) {
            logout(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String usuario = req.getParameter("usuario");
        String clave = req.getParameter("clave");

        Usuario u = usuarioDAO.validarCredenciales(usuario, clave);

        if (u != null) {
            HttpSession session = req.getSession();
            session.setAttribute("usuario", u);
            session.setAttribute("rol", u.getRol());

            // Redirect based on role or to dashboard
            // Redirect based on role or to dashboard
            // Index.jsp handles routing based on session role
            resp.sendRedirect("index.jsp");
        } else {
            req.setAttribute("mensaje", "Credenciales inválidas o cuenta inactiva");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect("login.jsp");
    }
}
