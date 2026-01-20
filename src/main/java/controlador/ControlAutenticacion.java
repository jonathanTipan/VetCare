package controlador;

import java.io.IOException;

import dao.DAOFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;

@WebServlet("/ControlAutenticacion")
public class ControlAutenticacion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ControlAutenticacion() {
        super();
    }

    private void ruteador(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion") != null ? req.getParameter("accion") : "iniciar";
        switch (accion) {
            case "iniciar":
                iniciar(req, resp);
                break;
            case "ingresar":
                ingresar(req, resp);
                break;
            case "logout":
                logout(req, resp);
                break;
            default:
                iniciar(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.ruteador(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.ruteador(req, resp);
    }

    private void iniciar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        java.util.List<String> roles = DAOFactory.getFactory().getUsuarioDAO().obtenerRoles();
        req.setAttribute("roles", roles);
        req.getRequestDispatcher("vista/Login.jsp").forward(req, resp);
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect("ControlAutenticacion?accion=iniciar");
    }

    private void ingresar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String usuario = req.getParameter("usuario");
        String clave = req.getParameter("clave");
        String idRol = req.getParameter("rol"); // El rol seleccionado en el JSP

        Usuario u = DAOFactory.getFactory().getUsuarioDAO().autenticarse(usuario, clave);

        if (u != null) {
            String userRol = u.getRol(); // Obtenemos el rol real del usuario (DTYPE)

            // Validamos que el rol seleccionado coincida con el rol real del usuario
            if (idRol != null && idRol.equalsIgnoreCase(userRol)) {
                HttpSession session = req.getSession();
                session.setAttribute("usuario", u);
                session.setAttribute("rol", userRol);

                // Redireccion basada en el rol (match case insensitive or strictly equals)
                if ("Cliente".equalsIgnoreCase(userRol)) {
                    resp.sendRedirect("vista/HomeCliente.jsp");
                } else if ("Veterinario".equalsIgnoreCase(userRol)) {
                    resp.sendRedirect("vista/HomeVeterinario.jsp");
                } else if ("Administrador".equalsIgnoreCase(userRol)) {
                    resp.sendRedirect("vista/HomeAdministrador.jsp");
                } else {
                    // Fallback para roles desconocidos
                    req.setAttribute("mensaje", "Rol no reconocido o sin vista asignada.");
                    session.invalidate();
                    iniciar(req, resp);
                }
            } else {
                req.setAttribute("mensaje", "El usuario no pertenece al rol seleccionado.");
                iniciar(req, resp);
            }
        } else {
            req.setAttribute("mensaje", "Credenciales inválidas o cuenta inactiva");
            iniciar(req, resp);
        }
    }
}
