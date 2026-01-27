package controlador;

import java.io.IOException;
import java.util.List;

import dao.DAOFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Veterinario;

@WebServlet("/ControlVeterinario")
public class ControlVeterinario extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ControlVeterinario() {
        super();
    }

    private void ruteador(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion") != null ? req.getParameter("accion") : "ingresarModulo";

        switch (accion) {
            case "ingresarModulo":
                ingresarModulo(req, resp);
                break;
            case "iniciarRegistro":
                iniciarRegistro(req, resp);
                break;
            case "registrarVeterinario":
                registrarVeterinario(req, resp);
                break;
            case "iniciarEdicion":
                iniciarEdicion(req, resp);
                break;
            case "editarVeterinario":
                editarVeterinario(req, resp);
                break;
            case "desactivarVeterinario":
                desactivarVeterinario(req, resp);
                break;
            case "iniciarDesactivacion":
                iniciarDesactivacion(req, resp);
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
        List<Veterinario> lista = DAOFactory.getFactory().getVeterinarioDAO().obtenerTodos();
        req.setAttribute("veterinarios", lista);
        req.getRequestDispatcher("vista/GestionVeterinarios.jsp").forward(req, resp);
    }

    private void iniciarRegistro(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("vista/RegistroVeterinario.jsp").forward(req, resp);
    }

    private void registrarVeterinario(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Veterinario v = new Veterinario();
        v.setNombre(req.getParameter("nombre"));
        v.setApellido(req.getParameter("apellido"));
        v.setCedula(req.getParameter("cedula"));
        v.setUsuario(req.getParameter("usuario"));
        v.setEspecialidad(req.getParameter("especialidad"));
        v.setNumeroLicencia(req.getParameter("numeroLicencia"));
        v.setTelefono(req.getParameter("telefono"));
        v.setClave(req.getParameter("clave"));
        v.setEstado("ACTIVO");

        if (DAOFactory.getFactory().getVeterinarioDAO().validarDuplicado(v.getCedula())) {
            req.setAttribute("veterinario", v);
            req.setAttribute("mensaje", "El veterinario con esta cédula o usuario ya existe.");
            req.getRequestDispatcher("vista/RegistroVeterinario.jsp").forward(req, resp);
            return;
        }

        try {
            DAOFactory.getFactory().getVeterinarioDAO().registrar(v);
            req.getSession().setAttribute("mensaje", "Veterinario registrado exitosamente");
            resp.sendRedirect("ControlVeterinario?accion=ingresarModulo");
        } catch (Exception e) {
            req.setAttribute("mensaje", "Error al registrar el veterinario");
            req.getRequestDispatcher("vista/RegistroVeterinario.jsp").forward(req, resp);
        }
    }

    private void iniciarEdicion(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cedula = req.getParameter("cedula");
        Veterinario veterinario = (cedula != null && !cedula.isEmpty())
                ? DAOFactory.getFactory().getVeterinarioDAO().obtenerPorId(cedula)
                : null;

        if (veterinario != null) {
            req.setAttribute("veterinario", veterinario);
            req.getRequestDispatcher("vista/EdicionVeterinario.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("ControlVeterinario?accion=ingresarModulo");
        }
    }

    private void editarVeterinario(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Veterinario v = new Veterinario();
        v.setCedula(req.getParameter("cedula"));
        v.setNombre(req.getParameter("nombre"));
        v.setApellido(req.getParameter("apellido"));
        v.setUsuario(req.getParameter("usuario"));
        v.setEspecialidad(req.getParameter("especialidad"));
        v.setNumeroLicencia(req.getParameter("numeroLicencia"));
        v.setTelefono(req.getParameter("telefono"));
        String clave = req.getParameter("clave");

        // Validación simple
        // Validación simple
        if (datosIncompletos(v)) {
            req.setAttribute("veterinario", v);
            req.setAttribute("mensaje", "Campos están incompletos");
            req.getRequestDispatcher("vista/EdicionVeterinario.jsp").forward(req, resp);
            return;
        }

        Veterinario vBD = DAOFactory.getFactory().getVeterinarioDAO().obtenerPorId(v.getCedula());
        if (vBD != null) {
            vBD.setNombre(v.getNombre());
            vBD.setApellido(v.getApellido());
            vBD.setEspecialidad(v.getEspecialidad());
            vBD.setNumeroLicencia(v.getNumeroLicencia());
            vBD.setTelefono(v.getTelefono());
            vBD.setUsuario(v.getUsuario());
            if (clave != null && !clave.trim().isEmpty()) {
                vBD.setClave(clave);
            }

            try {
                DAOFactory.getFactory().getVeterinarioDAO().actualizar(vBD);
                req.getSession().setAttribute("mensaje", "Actualización exitosa");
            } catch (Exception e) {
                req.getSession().setAttribute("mensaje", "Error al actualizar veterinario");
            }
        }
        resp.sendRedirect("ControlVeterinario?accion=ingresarModulo");
    }

    private void desactivarVeterinario(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String cedula = req.getParameter("cedula");
        if (cedula != null && !cedula.isEmpty()) {
            boolean resultado = DAOFactory.getFactory().getVeterinarioDAO().desactivarVeterinario(cedula);
            if (resultado) {
                req.getSession().setAttribute("mensaje", "Veterinario desactivado exitosamente");
            } else {
                req.getSession().setAttribute("mensaje", "Error: El veterinario no existe o ya está inactivo");
            }
        }
        resp.sendRedirect("ControlVeterinario?accion=ingresarModulo");
    }

    private void iniciarDesactivacion(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String cedula = req.getParameter("cedula");
        Veterinario veterinario = (cedula != null && !cedula.isEmpty())
                ? DAOFactory.getFactory().getVeterinarioDAO().obtenerPorId(cedula)
                : null;

        if (veterinario != null) {
            req.setAttribute("mensajeConfirmacion",
                    "¿Está seguro que desea desactivar al veterinario " + veterinario.getNombre() + " "
                            + veterinario.getApellido() + "?");
            req.setAttribute("cedulaDesactivar", cedula);
            ingresarModulo(req, resp); // Reuse logic to list veterinarians
        } else {
            resp.sendRedirect("ControlVeterinario?accion=ingresarModulo");
        }
    }

    private void cancelar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("ControlVeterinario?accion=ingresarModulo");
    }

    private boolean datosIncompletos(Veterinario v) {
        return v.getNombre() == null || v.getNombre().trim().isEmpty() ||
                v.getApellido() == null || v.getApellido().trim().isEmpty() ||
                v.getEspecialidad() == null || v.getEspecialidad().trim().isEmpty() ||
                v.getUsuario() == null || v.getUsuario().trim().isEmpty() ||
                v.getNumeroLicencia() == null || v.getNumeroLicencia().trim().isEmpty();
    }
}
