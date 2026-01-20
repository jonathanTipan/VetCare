package controlador;

import java.io.IOException;

import dao.DAOFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Consulta;
import modelo.Receta;
import modelo.Usuario;
import modelo.Veterinario;

@WebServlet("/ControlRecetas")
public class ControlRecetas extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ControlRecetas() {
        super();
    }

    private void ruteador(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u == null || !(u instanceof Veterinario)) {
            resp.sendRedirect(req.getContextPath() + "/Login.jsp");
            return;
        }

        String accion = req.getParameter("accion") != null ? req.getParameter("accion") : "ingresarModulo";

        switch (accion) {
            case "ingresarModulo":
                ingresarModulo(req, resp);
                break;
            case "iniciarRegistro":
                iniciarRegistro(req, resp);
                break;
            case "registrarReceta":
                registrarReceta(req, resp);
                break;
            case "cancelar":
                cancelar(req, resp);
                break;
            default:
                ingresarModulo(req, resp);
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.ruteador(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.ruteador(req, resp);
    }

    private void ingresarModulo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Redirige a la agenda/citas por defecto
        resp.sendRedirect(req.getContextPath() + "/ControlCita?accion=ingresarModulo");
    }

    private void iniciarRegistro(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idConsultaStr = req.getParameter("idConsulta");

        if (idConsultaStr != null) {
            try {
                int idConsulta = Integer.parseInt(idConsultaStr);
                Consulta consulta = DAOFactory.getFactory().getConsultaDAO().getById(idConsulta);
                if (consulta != null) {
                    req.setAttribute("consulta", consulta);
                    req.getRequestDispatcher("vista/prescripcionMedicamentos.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/ControlCita?accion=ingresarModulo");
    }

    private void registrarReceta(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idConsultaStr = req.getParameter("idConsulta");

        if (idConsultaStr == null) {
            resp.sendRedirect(req.getContextPath() + "/ControlCita?accion=ingresarModulo");
            return;
        }

        try {
            int idConsulta = Integer.parseInt(idConsultaStr);
            Consulta consulta = DAOFactory.getFactory().getConsultaDAO().getById(idConsulta);

            if (consulta == null) {
                resp.sendRedirect(req.getContextPath() + "/ControlCita?accion=ingresarModulo");
                return;
            }

            Receta receta = new Receta();
            receta.setConsulta(consulta);
            receta.setMedicamento(req.getParameter("medicamento"));
            receta.setDosis(req.getParameter("dosis"));
            receta.setFrecuencia(req.getParameter("frecuencia"));
            receta.setDuracion(req.getParameter("duracion"));
            receta.setFecha(new java.util.Date());
            receta.setEstado("ACTIVA");

            try {
                DAOFactory.getFactory().getRecetaDAO().create(receta);
                req.getSession().setAttribute("mensaje", "Receta generada exitosamente");
                resp.sendRedirect(req.getContextPath() + "/ControlCita?accion=ingresarModulo");
            } catch (Exception e) {
                req.setAttribute("mensaje", "Error al guardar la receta");
                req.setAttribute("consulta", consulta);
                req.getRequestDispatcher("vista/prescripcionMedicamentos.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/ControlCita?accion=ingresarModulo");
        }
    }

    private void cancelar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/ControlCita?accion=ingresarModulo");
    }
}
