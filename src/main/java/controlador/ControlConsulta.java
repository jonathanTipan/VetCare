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
import modelo.Usuario;
import modelo.Veterinario;

@WebServlet("/ControlConsulta")
public class ControlConsulta extends HttpServlet {
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
            case "registrarAtencion":
                registrarAtencion(req, resp, u);
                break;
            case "cancelarConsulta":
                cancelarConsulta(req, resp, u);
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

    private void ingresarModulo(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        boolean esVeterinario = (u instanceof Veterinario);
        List<Consulta> consultas = DAOFactory.getFactory().getConsultaDAO().listarConsultas(u.getCedula(),
                esVeterinario);
        req.setAttribute("consultas", consultas);
        req.getRequestDispatcher("vista/GestionConsultas.jsp").forward(req, resp);
    }

    private void iniciarAgendamiento(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        if (u instanceof Cliente) {
            req.setAttribute("mascotas", DAOFactory.getFactory().getMascotaDAO().listarMascotas(u.getCedula()));
            req.setAttribute("veterinarios", DAOFactory.getFactory().getVeterinarioDAO().get());
            req.getRequestDispatcher("vista/AgendarConsulta.jsp").forward(req, resp);
        } else {
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
            String cedulaVeterinario = req.getParameter("idVeterinario");

            consulta.setMotivo(req.getParameter("motivo"));
            consulta.setEstado("AGENDADA");

            // Fecha
            if (fechaStr != null && !fechaStr.isEmpty()) {
                consulta.setFecha(new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr));
            } else {
                consulta.setFecha(new Date());
            }

            // Hora
            if (horaStr != null && !horaStr.isEmpty()) {
                if (horaStr.length() == 5)
                    horaStr += ":00";
                consulta.setHora(Time.valueOf(horaStr));
            }

            // Mascota
            if (idMascotaStr != null) {
                Mascota mascota = DAOFactory.getFactory().getMascotaDAO().getById(Integer.parseInt(idMascotaStr));
                if (u instanceof Cliente && mascota != null
                        && !mascota.getCliente().getCedula().equals(u.getCedula())) {
                    throw new Exception("No tiene permiso para agendar a esta mascota");
                }
                consulta.setMascota(mascota);
            }

            // Veterinario
            if (cedulaVeterinario != null && !cedulaVeterinario.isEmpty()) {
                consulta.setVeterinario(DAOFactory.getFactory().getVeterinarioDAO().getById(cedulaVeterinario));
            }

            try {
                DAOFactory.getFactory().getConsultaDAO().create(consulta);
                req.getSession().setAttribute("mensaje", "Consulta agendada exitosamente");
                resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
            } catch (Exception e) {
                req.setAttribute("mensaje", "Error al agendar consulta");
                iniciarAgendamiento(req, resp, u);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("mensaje", "Error: " + e.getMessage());
            iniciarAgendamiento(req, resp, u);
        }
    }

    private void iniciarAtencion(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        String idStr = req.getParameter("idConsulta");
        if (idStr != null && !idStr.isEmpty()) {
            Consulta c = DAOFactory.getFactory().getConsultaDAO().getById(Integer.parseInt(idStr));
            if (c != null) {
                req.setAttribute("consulta", c);
                req.getRequestDispatcher("vista/RegistroConsulta.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
    }

    private void registrarAtencion(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        try {
            int idConsulta = Integer.parseInt(req.getParameter("idConsulta"));
            Consulta consulta = DAOFactory.getFactory().getConsultaDAO().getById(idConsulta);

            if (consulta != null) {
                consulta.setSintomas(req.getParameter("sintomas"));
                consulta.setDiagnostico(req.getParameter("diagnostico"));
                consulta.setTratamiento(req.getParameter("tratamiento"));
                consulta.setObservaciones(req.getParameter("observaciones"));
                consulta.setEstado("ATENDIDA");

                try {
                    DAOFactory.getFactory().getConsultaDAO().update(consulta);
                    req.getSession().setAttribute("mensaje", "Consulta registrada exitosamente");
                    resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
                } catch (Exception e) {
                    req.setAttribute("mensaje", "Error al guardar atención");
                    req.setAttribute("consulta", consulta);
                    req.getRequestDispatcher("vista/RegistroConsulta.jsp").forward(req, resp);
                }
            } else {
                resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
        }
    }

    private void cancelarConsulta(HttpServletRequest req, HttpServletResponse resp, Usuario u)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                DAOFactory.getFactory().getConsultaDAO().deleteByID(Integer.parseInt(idStr));
                req.getSession().setAttribute("mensaje", "Consulta cancelada");
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect("ControlConsulta?accion=ingresarModulo");
    }
}
