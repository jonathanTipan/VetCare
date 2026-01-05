package controlador;

import java.io.IOException;
import java.util.Date;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Cliente;
import modelo.Mascota;
import modelo.Usuario;
import dao.MascotaDAO;

@WebServlet("/ControlMascota")
public class ControlMascota extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MascotaDAO mascotaDAO;

    public ControlMascota() {
        super();
        this.mascotaDAO = new MascotaDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u == null || !"CLIENTE".equals(u.getRol())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // We assume Usuario is instance of Cliente because of JOINED inheritance and
        // logic
        // But session might hold just the parent object depending on how Hibernate
        // loaded it.
        // Safer to treat logic: if we have ID, we can set it.
        // Wait, if Hibernate loaded it, it SHOULD be the subclass instance (Cliente).

        String accion = req.getParameter("accion");
        if ("eliminar".equals(accion)) {
            eliminar(req, resp);
            return;
        }

        String nombre = req.getParameter("nombre");
        String especie = req.getParameter("especie");
        String raza = req.getParameter("raza");

        Date fechaNac = new Date();
        try {
            String f = req.getParameter("fechaNac");
            if (f != null && !f.isEmpty()) {
                fechaNac = new SimpleDateFormat("yyyy-MM-dd").parse(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        double peso = 0.0;
        try {
            peso = Double.parseDouble(req.getParameter("peso"));
        } catch (NumberFormatException e) {
        }

        Mascota m = new Mascota(nombre, especie, raza, fechaNac, peso);

        // Link to Cliente
        // If 'u' is actually a proxy or just Usuario, we might need to fetch the
        // Cliente proxy.
        // For now, let's assume 'u' is accessible as Cliente or we create a dummy with
        // ID.
        // To be safe with JPA, we should find the reference or use the object if it's
        // managed.
        // Since 'u' is detached (from session), we can use it if we merge or just set
        // ID if we had FK field.
        // But we have object reference.

        if (u instanceof Cliente) {
            m.setCliente((Cliente) u);
        } else {
            // Fallback: This shouldn't happen if login loaded correctly,
            // but if it did, we might need to 'load' the client by ID.
            // For this example, let's assume casting works or fail.
            // Actually, creating a new Cliente with just ID might work for setting FK.
            Cliente c = new Cliente();
            c.setId(u.getId());
            m.setCliente(c);
        }

        boolean exito = mascotaDAO.guardar(m);

        if (exito) {
            req.setAttribute("mensaje", "Mascota guardada");
        } else {
            req.setAttribute("mensaje", "Error al guardar");
        }

        // Refresh list before forwarding
        if (u != null) {
            req.setAttribute("mascotas", mascotaDAO.buscarPorCliente(u.getId()));
        }

        req.getRequestDispatcher("vista/misMascotas.jsp").forward(req, resp);
    }

    private void eliminar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        mascotaDAO.eliminar(id);
        resp.sendRedirect("ControlMascota?accion=listar");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // List pets logic usually goes here
        HttpSession session = req.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (u != null) {
            req.setAttribute("mascotas", mascotaDAO.buscarPorCliente(u.getId()));
        }
        req.getRequestDispatcher("vista/misMascotas.jsp").forward(req, resp);
    }
}
