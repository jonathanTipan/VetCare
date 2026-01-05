package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Consulta;
import modelo.Cita;
import dao.ConsultaDAO;

@WebServlet("/ControlConsulta")
public class ControlConsulta extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConsultaDAO consultaDAO;

    public ControlConsulta() {
        super();
        this.consultaDAO = new ConsultaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if ("formulario".equals(accion)) {
            // Forward to the JSP form
            req.getRequestDispatcher("vista/registrarConsulta.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("vista/home-veterinario.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sintomas = req.getParameter("sintomas");
        String diagnostico = req.getParameter("diagnostico");
        String tratamiento = req.getParameter("tratamiento");
        String observaciones = req.getParameter("observaciones");
        String idCitaStr = req.getParameter("idCita");

        Consulta c = new Consulta();
        c.setSintomas(sintomas);
        c.setDiagnostico(diagnostico);
        c.setTratamiento(tratamiento);
        c.setObservaciones(observaciones);

        if (idCitaStr != null && !idCitaStr.isEmpty()) {
            Cita cita = new Cita();
            cita.setIdCita(Integer.parseInt(idCitaStr));
            c.setCita(cita);
        }

        boolean exito = consultaDAO.guardar(c);

        req.setAttribute("mensaje", exito ? "Consulta registrada" : "Error al registrar");
        req.getRequestDispatcher("vista/registrarConsulta.jsp").forward(req, resp);
    }
}
