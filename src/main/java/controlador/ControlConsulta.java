package controlador;

import java.io.IOException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import dao.DAOFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Cliente;
import modelo.Consulta;
import modelo.Mascota;
import modelo.Receta;
import modelo.Usuario;
import modelo.Veterinario;

@WebServlet("/ControlConsulta")
public class ControlConsulta extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ControlConsulta() {
        super();
    }

    private void ruteador(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/vista/Login.jsp");
            return;
        }

        String accion = req.getParameter("accion") != null ? req.getParameter("accion") : "ingresarModulo";

        switch (accion) {
            case "ingresarModulo":
                ingresarModulo(req, resp, u);
                break;
            case "iniciarAgendamiento":
                iniciarAgendamiento(req, resp, u);
                break;
            case "agendarConsulta":
                agendarConsulta(req, resp, u);
                break;
            case "iniciarAtencion":
                iniciarAtencion(req, resp, u);
                break;
            case "atenderConsulta":
                atenderConsulta(req, resp, u);
                break;
            case "iniciarPrescripcion":
                iniciarPrescripcion(req, resp, u);
                break;
            case "registrarReceta":
            case "guardarReceta":
                registrarReceta(req, resp, u);
                break;
            case "cancelar":
                cancelar(req, resp, u);
                break;
            case "cancelarPrescripcion":
                cancelarPrescripcion(req, resp, u);
                break;
            case "buscarDisponibilidad":
                buscarDisponibilidad(req, resp, u);
                break;
            default:
                ingresarModulo(req, resp, u);
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

    // --- Logic Methods ---

    private void ingresarModulo(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        List<Consulta> consultas = DAOFactory.getFactory().getConsultaDAO().obtenerPorUsuario(u);
        req.setAttribute("consultas", consultas);
        req.getRequestDispatcher("vista/GestionConsultas.jsp").forward(req, resp);
    }

    private void iniciarAgendamiento(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        if (u instanceof Cliente) {
            req.setAttribute("veterinarios", DAOFactory.getFactory().getVeterinarioDAO().obtenerTodos());
            req.setAttribute("mascotas", DAOFactory.getFactory().getMascotaDAO().obtenerPorCliente(u.getCedula()));
            req.getRequestDispatcher("vista/AgendamientoConsulta.jsp").forward(req, resp);
        } else {
            req.setAttribute("mensaje", "Acción no permitida");
            resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
        }
    }

    private void agendarConsulta(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        try {
            Consulta consulta = new Consulta();
            String fechaStr = req.getParameter("fecha");
            String horaStr = req.getParameter("hora");
            String idMascotaStr = req.getParameter("idMascota");
            String cedula = req.getParameter("idVeterinario");

            consulta.setMotivo(req.getParameter("motivo"));
            consulta.setEstado("AGENDADA");

            consulta.setFecha((fechaStr != null && !fechaStr.isEmpty())
                    ? new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr)
                    : new Date());

            if (horaStr == null || horaStr.isEmpty()) {
                throw new Exception("Debe seleccionar una hora para la consulta");
            }

            horaStr = (horaStr.length() == 5) ? horaStr + ":00" : horaStr;
            consulta.setHora(Time.valueOf(horaStr));

            if (idMascotaStr != null) {
                Mascota mascota = DAOFactory.getFactory().getMascotaDAO().obtenerPorId(Integer.parseInt(idMascotaStr));
                if (u instanceof Cliente && mascota != null
                        && !mascota.getCliente().getCedula().equals(u.getCedula())) {
                    throw new Exception("No tiene permiso para agendar a esta mascota");
                }
                consulta.setMascota(mascota);
            }

            consulta.setVeterinario((cedula != null && !cedula.isEmpty())
                    ? DAOFactory.getFactory().getVeterinarioDAO().obtenerPorId(cedula)
                    : null);

            DAOFactory.getFactory().getConsultaDAO().registrar(consulta);
            req.getSession().setAttribute("mensaje", "Consulta agendada exitosamente");
            resp.sendRedirect("ControlConsulta?accion=ingresarModulo");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("mensaje", "Error al agendar: " + e.getMessage());
            iniciarAgendamiento(req, resp, u);
        }
    }

    private void iniciarAtencion(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        String id = req.getParameter("idConsulta");
        if (id != null && !id.isEmpty()) {
            Consulta c = DAOFactory.getFactory().getConsultaDAO().obtenerPorId(Integer.parseInt(id));
            if (c != null) {
                req.getSession().setAttribute("consultaEnAtencion", c);
                req.setAttribute("consulta", c);
                req.getRequestDispatcher("vista/RegistroConsulta.jsp").forward(req, resp);
                return;
            }
        }
        req.getSession().setAttribute("mensaje", "Consulta no encontrada");
        resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
    }

    private void atenderConsulta(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("idConsulta"));
            Consulta c = DAOFactory.getFactory().getConsultaDAO().obtenerPorId(id);

            if (c != null) {
                c.setSintomas(req.getParameter("sintomas"));
                c.setDiagnostico(req.getParameter("diagnostico"));
                c.setTratamiento(req.getParameter("tratamiento"));
                c.setObservaciones(req.getParameter("observaciones"));
                c.setEstado("ATENDIDA");

                DAOFactory.getFactory().getConsultaDAO().actualizar(c);
                req.getSession().setAttribute("mensaje", "Consulta finalizada exitosamente");
                resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("mensaje", "Error al finalizar consulta");
            resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
        }
    }

    private void iniciarPrescripcion(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        String idStr = req.getParameter("idConsulta");
        if (idStr != null) {
            try {
                int idConsulta = Integer.parseInt(idStr);
                Consulta c = DAOFactory.getFactory().getConsultaDAO().obtenerPorId(idConsulta);

                if (c != null) {
                    // Preservar datos del formulario
                    c.setSintomas(req.getParameter("sintomas"));
                    c.setDiagnostico(req.getParameter("diagnostico"));
                    c.setTratamiento(req.getParameter("tratamiento"));
                    c.setObservaciones(req.getParameter("observaciones"));

                    req.setAttribute("consulta", c);
                    req.getRequestDispatcher("vista/PrescripcionReceta.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        req.getSession().setAttribute("mensaje", "Consulta no encontrada");
        resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
    }

    private void registrarReceta(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {

        if (!(u instanceof Veterinario)) {
            req.getSession().setAttribute("mensaje", "No autorizado");
            resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
            return;
        }

        String id = req.getParameter("idConsulta");

        try {
            int idConsulta = Integer.parseInt(id);
            Consulta consulta = DAOFactory.getFactory().getConsultaDAO().obtenerPorId(idConsulta);

            if (consulta != null) {
                Receta receta = new Receta();
                receta.setConsulta(consulta);
                receta.setMedicamento(req.getParameter("medicamento"));
                receta.setDosis(req.getParameter("dosis"));
                receta.setFrecuencia(req.getParameter("frecuencia"));
                receta.setDuracion(req.getParameter("duracion"));

                DAOFactory.getFactory().getRecetaDAO().registrar(receta);

                req.setAttribute("mensaje", "Receta guardada correctamente");

                // Recargar datos previos y redirigir a vista de atención (sin perder datos)
                consulta.setSintomas(req.getParameter("sintomas"));
                consulta.setDiagnostico(req.getParameter("diagnostico"));
                consulta.setTratamiento(req.getParameter("tratamiento"));
                consulta.setObservaciones(req.getParameter("observaciones"));

                req.setAttribute("consulta", consulta);
                req.getRequestDispatcher("vista/RegistroConsulta.jsp").forward(req, resp);

            } else {
                req.setAttribute("mensaje", "Consulta no encontrada");
                req.getRequestDispatcher("vista/PrescripcionReceta.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("mensaje", "Error al guardar receta: " + e.getMessage());
            req.getRequestDispatcher("vista/PrescripcionReceta.jsp").forward(req, resp);
        }
    }

    private void cancelarPrescripcion(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        String id = req.getParameter("idConsulta");
        try {
            int idConsulta = Integer.parseInt(id);
            Consulta consulta = DAOFactory.getFactory().getConsultaDAO().obtenerPorId(idConsulta);

            if (consulta != null) {
                // Restaurar datos
                consulta.setSintomas(req.getParameter("sintomas"));
                consulta.setDiagnostico(req.getParameter("diagnostico"));
                consulta.setTratamiento(req.getParameter("tratamiento"));
                consulta.setObservaciones(req.getParameter("observaciones"));

                req.setAttribute("consulta", consulta);
                req.getRequestDispatcher("vista/RegistroConsulta.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
        }
    }

    private void cancelar(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
    }

    private void buscarDisponibilidad(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        String fechaStr = req.getParameter("fecha");
        String cedula = req.getParameter("idVeterinario");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (fechaStr == null || fechaStr.isEmpty() || cedula == null || cedula.isEmpty()) {
            resp.getWriter().write("[]");
            return;
        }

        try {
            Date fechaUtil = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);
            java.sql.Date fecha = new java.sql.Date(fechaUtil.getTime());

            List<java.sql.Time> occupiedSlots = DAOFactory.getFactory().getConsultaDAO()
                    .obtenerConsultasDisponibles(fecha, cedula);

            int startHour = 8;
            int endHour = 16;

            java.util.List<String> allSlots = new java.util.ArrayList<>();
            for (int h = startHour; h < endHour; h++) {
                allSlots.add(String.format("%02d:00", h));
                allSlots.add(String.format("%02d:30", h));
            }

            java.util.Set<String> occupiedSet = new java.util.HashSet<>();
            for (Object obj : occupiedSlots) {
                if (obj != null) {
                    String t = obj.toString();
                    if (t.length() >= 5) {
                        occupiedSet.add(t.substring(0, 5));
                    }
                }
            }

            java.util.List<String> available = new java.util.ArrayList<>();
            for (String slot : allSlots) {
                if (!occupiedSet.contains(slot)) {
                    available.add(slot);
                }
            }

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < available.size(); i++) {
                json.append("\"").append(available.get(i)).append("\"");
                if (i < available.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");

            resp.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("[\"Error: " + e.getMessage() + "\"]");
        }
    }
}
