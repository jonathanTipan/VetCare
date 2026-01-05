package controlador;

import java.io.IOException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Cita;
import modelo.Mascota;
import modelo.Usuario;
import modelo.Veterinario;
import dao.CitaDAO;

@WebServlet("/ControlAgendamiento")
public class ControlAgendamiento extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CitaDAO citaDAO;

    public ControlAgendamiento() {
        super();
        this.citaDAO = new CitaDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fechaStr = req.getParameter("fecha");
        String horaStr = req.getParameter("hora");
        String motivo = req.getParameter("motivo");
        String idMascotaStr = req.getParameter("idMascota");
        String idVeterinarioStr = req.getParameter("idVeterinario");

        Date fecha = new Date();
        Time hora = new Time(System.currentTimeMillis());
        try {
            if (fechaStr != null)
                fecha = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);
            if (horaStr != null) {
                if (horaStr.length() == 5)
                    horaStr += ":00";
                hora = Time.valueOf(horaStr);
            }
        } catch (Exception e) {
        }

        Cita c = new Cita();
        c.setFecha(fecha);
        c.setHora(hora);
        c.setMotivo(motivo);
        c.setEstado("AGENDADA");

        if (idMascotaStr != null) {
            Mascota m = new Mascota();
            m.setId(Integer.parseInt(idMascotaStr));
            c.setMascota(m);
        }

        if (idVeterinarioStr != null) {
            Veterinario v = new Veterinario();
            v.setId(Integer.parseInt(idVeterinarioStr));
            c.setVeterinario(v);
        }

        boolean saved = citaDAO.guardar(c);
        req.setAttribute("mensaje", saved ? "Cita agendada" : "Error al agendar");

        req.getRequestDispatcher("vista/agendarCita.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        HttpSession session = req.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        if ("listar".equals(accion)) {
            // Client: My Appointments
            req.setAttribute("citas", citaDAO.listarPorCliente(u.getId()));
            req.getRequestDispatcher("vista/misCitas.jsp").forward(req, resp);

        } else if ("agenda".equals(accion)) {
            // Vet: My Agenda
            // Assuming u.getId() corresponds to Usuario ID, and we have a way to find Vet
            // ID
            // In our model inheritance, Vet ID == User ID.
            req.setAttribute("citas", citaDAO.listarPorVeterinario(u.getId()));
            req.getRequestDispatcher("vista/misCitas.jsp").forward(req, resp); // Reuse or new view? Reuse for now.

        } else if ("formulario".equals(accion)) {
            // Prepare form for booking: Need pets list
            dao.MascotaDAO mascotaDAO = new dao.MascotaDAO();
            req.setAttribute("mascotas", mascotaDAO.buscarPorCliente(u.getId()));
            // We might also want list of Vets? For now, optional or auto-assigned.
            dao.UsuarioDAO usuarioDAO = new dao.UsuarioDAO();
            req.setAttribute("veterinarios", usuarioDAO.listarVeterinariosActivos());

            req.getRequestDispatcher("vista/agendarCita.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("vista/home-cliente.jsp");
        }
    }
}
