package controlador;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Cita;
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Petición por GET - ControlAgendamiento");
        req.getRequestDispatcher("vista/agendarCita.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Petición por POST - ControlAgendamiento");

        String fechaStr = req.getParameter("fecha");
        String horaStr = req.getParameter("hora");
        String motivo = req.getParameter("motivo");

        Date fecha = new Date();
        java.sql.Time hora = new java.sql.Time(System.currentTimeMillis());

        try {
            if (fechaStr != null && !fechaStr.isEmpty()) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                fecha = sdf.parse(fechaStr);
            }
            if (horaStr != null && !horaStr.isEmpty()) {
                // Simplistic parsing for HH:mm or HH:mm:ss
                // java.sql.Time.valueOf wants HH:mm:ss
                if (horaStr.length() == 5)
                    horaStr += ":00";
                hora = java.sql.Time.valueOf(horaStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Cita c = new Cita();
        c.setFecha(fecha);
        c.setHora(hora);
        c.setMotivo(motivo);
        c.setEstado("Pendiente");

        boolean saved = citaDAO.guardar(c);

        if (saved) {
            req.setAttribute("mensaje", "Cita agendada correctamente");
        } else {
            req.setAttribute("mensaje", "Error al agendar cita");
        }

        req.getRequestDispatcher("vista/agendarCita.jsp").forward(req, resp);
    }

    private boolean validar(Date f) {
        return f != null;
    }
}
