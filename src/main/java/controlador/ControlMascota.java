package controlador;

import java.io.IOException;
import java.text.SimpleDateFormat;

import dao.DAOFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Cliente;
import modelo.Mascota;
import modelo.Usuario;

@WebServlet("/ControlMascota")
public class ControlMascota extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ControlMascota() {
        super();
    }

    private void ruteador(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u == null || !(u instanceof Cliente)) {
            resp.sendRedirect(req.getContextPath() + "/Login.jsp");
            return;
        }

        String accion = req.getParameter("accion") != null ? req.getParameter("accion") : "ingresarModulo";
        String cedulaCliente = u.getCedula();

        switch (accion) {
            case "ingresarModulo":
                ingresarModulo(req, resp, cedulaCliente);
                break;
            case "iniciarRegistro":
                iniciarRegistro(req, resp);
                break;
            case "registrarMascota":
                registrarMascota(req, resp, (Cliente) u);
                break;
            case "iniciarEdicion":
                iniciarEdicion(req, resp, cedulaCliente);
                break;
            case "editarMascota":
                editarMascota(req, resp, cedulaCliente);
                break;
            case "eliminarMascota":
                eliminarMascota(req, resp, cedulaCliente);
                break;
            case "cancelar":
                cancelar(req, resp);
                break;
            default:
                ingresarModulo(req, resp, cedulaCliente);
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

    private void ingresarModulo(HttpServletRequest req, HttpServletResponse resp, String cedulaCliente)
            throws ServletException, IOException {
        req.setAttribute("mascotas", DAOFactory.getFactory().getMascotaDAO().listarMascotas(cedulaCliente));
        req.getRequestDispatcher("vista/GestionMascotas.jsp").forward(req, resp);
    }

    private void iniciarRegistro(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("vista/RegistroMascota.jsp").forward(req, resp);
    }

    private void registrarMascota(HttpServletRequest req, HttpServletResponse resp, Cliente cliente)
            throws ServletException, IOException {
        try {
            String fechaStr = req.getParameter("fechaNacimiento");
            String pesoStr = req.getParameter("peso");

            Mascota mascota = new Mascota();
            mascota.setCliente(cliente);
            mascota.setNombre(req.getParameter("nombre"));
            mascota.setEspecie(req.getParameter("especie"));
            mascota.setRaza(req.getParameter("raza"));
            mascota.setSexo(req.getParameter("sexo"));

            if (mascota.getNombre() == null || mascota.getNombre().trim().isEmpty() ||
                    mascota.getEspecie() == null || mascota.getEspecie().trim().isEmpty()) {
                throw new Exception("Nombre y especie son obligatorios");
            }

            if (fechaStr != null && !fechaStr.isEmpty())
                mascota.setFechaNacimiento(new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr));

            if (pesoStr != null && !pesoStr.isEmpty())
                mascota.setPeso(Double.parseDouble(pesoStr));

            try {
                DAOFactory.getFactory().getMascotaDAO().create(mascota);
                req.getSession().setAttribute("mensaje", "Mascota registrada exitosamente");
                resp.sendRedirect("ControlMascota?accion=ingresarModulo");
            } catch (Exception e) {
                req.setAttribute("mensaje", "No se pudo guardar la mascota en la base de datos");
                req.getRequestDispatcher("vista/RegistroMascota.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("mensaje", "Error al registrar la mascota: " + e.getMessage());
            req.getRequestDispatcher("vista/RegistroMascota.jsp").forward(req, resp);
        }
    }

    private void iniciarEdicion(HttpServletRequest req, HttpServletResponse resp, String cedulaCliente)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Mascota mascota = DAOFactory.getFactory().getMascotaDAO().getById(Integer.parseInt(idStr));
            if (mascota != null && mascota.getCliente().getCedula().equals(cedulaCliente)) {
                req.setAttribute("mascota", mascota);
                req.getRequestDispatcher("vista/EdicionMascota.jsp").forward(req, resp);
                return;
            } else {
                req.setAttribute("mensaje", "No tiene permiso para editar esta mascota");
            }
        }
        resp.sendRedirect("ControlMascota?accion=ingresarModulo");
    }

    private void editarMascota(HttpServletRequest req, HttpServletResponse resp, String cedulaCliente)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Mascota mascota = DAOFactory.getFactory().getMascotaDAO().getById(Integer.parseInt(idStr));

            if (mascota != null && mascota.getCliente().getCedula().equals(cedulaCliente)) {
                try {
                    String nombre = req.getParameter("nombre");
                    String especie = req.getParameter("especie");
                    String fechaStr = req.getParameter("fechaNacimiento");
                    String pesoStr = req.getParameter("peso");

                    if (nombre != null && !nombre.trim().isEmpty())
                        mascota.setNombre(nombre.trim());
                    if (especie != null && !especie.trim().isEmpty())
                        mascota.setEspecie(especie.trim());
                    mascota.setRaza(req.getParameter("raza"));
                    mascota.setSexo(req.getParameter("sexo"));

                    if (fechaStr != null && !fechaStr.isEmpty())
                        mascota.setFechaNacimiento(new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr));

                    if (pesoStr != null && !pesoStr.isEmpty())
                        mascota.setPeso(Double.parseDouble(pesoStr));

                    DAOFactory.getFactory().getMascotaDAO().update(mascota);
                    req.getSession().setAttribute("mensaje", "Mascota actualizada exitosamente");

                } catch (Exception e) {
                    e.printStackTrace();
                    req.getSession().setAttribute("mensaje", "Error al actualizar la mascota");
                }
            } else {
                req.getSession().setAttribute("mensaje", "No tiene permiso para editar esta mascota");
            }
        }
        resp.sendRedirect("ControlMascota?accion=ingresarModulo");
    }

    private void eliminarMascota(HttpServletRequest req, HttpServletResponse resp, String cedulaCliente)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Mascota mascota = DAOFactory.getFactory().getMascotaDAO().getById(Integer.parseInt(idStr));
            if (mascota != null && mascota.getCliente().getCedula().equals(cedulaCliente)) {
                try {
                    DAOFactory.getFactory().getMascotaDAO().deleteByID(mascota.getId());
                    req.getSession().setAttribute("mensaje", "Mascota eliminada exitosamente");
                } catch (Exception e) {
                    req.getSession().setAttribute("mensaje", "Error al eliminar mascota");
                }
            } else {
                req.getSession().setAttribute("mensaje", "No tiene permiso para eliminar esta mascota");
            }
        }
        resp.sendRedirect("ControlMascota?accion=ingresarModulo");
    }

    private void cancelar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("ControlMascota?accion=ingresarModulo");
    }
}
