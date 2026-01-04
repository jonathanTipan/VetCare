package controlador;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Mascota;
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Petición por GET - ControlMascota");
        req.getRequestDispatcher("vista/registrarMascota.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Petición por POST - ControlMascota");
        
        // Obtener parámetros del formulario
        String nombre = req.getParameter("nombre");
        String especie = req.getParameter("especie");
        String raza = req.getParameter("raza");
        
        // Parse date properly (assuming yyyy-MM-dd from HTML date input)
        String fechaNacStr = req.getParameter("fechaNac");
        java.util.Date fechaNac = new java.util.Date();
        try {
            if(fechaNacStr != null && !fechaNacStr.isEmpty()) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                fechaNac = sdf.parse(fechaNacStr);
            }
        } catch (java.text.ParseException e) {
            e.printStackTrace();
        }

        String pesoStr = req.getParameter("peso");
        double peso = (pesoStr != null && !pesoStr.isEmpty()) ? Double.parseDouble(pesoStr) : 0.0;
        
        Mascota m = new Mascota(nombre, especie, raza, fechaNac, peso);
        
        int idCliente = 1; // Default for now
        boolean exito = mascotaDAO.guardar(m, idCliente);
        
        if (exito) {
            req.setAttribute("mensaje", "Mascota registrada con éxito");
        } else {
             req.setAttribute("mensaje", "Error al registrar mascota");
        }
        
        // Forward back to form to show message
        req.getRequestDispatcher("vista/registrarMascota.jsp").forward(req, resp);
    }
}
