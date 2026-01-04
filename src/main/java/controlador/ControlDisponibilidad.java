package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ControlDisponibilidad")
public class ControlDisponibilidad extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ControlDisponibilidad() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // AJAX check maybe?
        String fecha = req.getParameter("fecha");
        if (fecha != null) {
            System.out.println("Verificando fecha: " + fecha);
        }
        boolean disponible = true; // Logic stub

        resp.getWriter().append("{\"disponible\": " + disponible + "}");
    }
}
