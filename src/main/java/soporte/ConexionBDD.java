package soporte;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBDD {

    private static ConexionBDD instancia;
    private String servidor;
    private String usuario;
    private String clave;
    private String nombreBdd;
    private Connection conn;

    private ConexionBDD() {
        // Valores por defecto o leer de configuración
        this.servidor = "jdbc:mysql://localhost:3306/";
        this.nombreBdd = "veterinaria_db";
        this.usuario = "root";
        this.clave = "password"; // Cambiar según entorno
    }

    public static ConexionBDD getInstance() {
        if (instancia == null) {
            instancia = new ConexionBDD();
        }
        return instancia;
    }

    public Connection conectar() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(servidor + nombreBdd, usuario, clave);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public void cerrar() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
