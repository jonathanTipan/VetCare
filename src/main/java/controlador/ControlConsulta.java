package controlador;

import java.io.IOException;
import java.sql.Time;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Consulta;
import dao.ConsultaDAO;
import dao.CitaDAO;

@WebServlet("/ControlConsulta")
public class ControlConsulta extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConsultaDAO consultaDAO;
    private CitaDAO citaDAO;

    public ControlConsulta() {
        super();
        this.consultaDAO = new ConsultaDAO();
        this.citaDAO = new CitaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("vista/registrarConsulta.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Extract params
        String diagnostico = req.getParameter("diagnostico");
        String tratamiento = req.getParameter("tratamiento");
        String sintomas = req.getParameter("sintomas");

        int idCita = 0;
        try {
            idCita = Integer.parseInt(req.getParameter("idCita"));
        } catch (NumberFormatException e) {
            // Handle error
        }

        Consulta c = new Consulta(new Date(), new Time(System.currentTimeMillis()), diagnostico, tratamiento);
        c.setSintomas(sintomas);

        boolean guardado = consultaDAO.guardarConsulta(c);
        if (guardado) {
            citaDAO.actualizarEstado(idCita, "Atendida");
            req.setAttribute("mensaje", "Consulta registrada con éxito");
        } else {
            req.setAttribute("mensaje", "Error al registrar consulta");
        }

        req.getRequestDispatcher("vista/registrarConsulta.jsp").forward(req, resp);
    }
}
