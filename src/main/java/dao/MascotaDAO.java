package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import modelo.Mascota;
import soporte.ConexionBDD;

public class MascotaDAO {
    public boolean guardar(Mascota m, int idCliente) {
        Connection conn = ConexionBDD.getInstance().conectar();
        String sql = "INSERT INTO Mascota (nombre, especie, raza, fechaNac, peso, foto, idCliente) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, m.getNombre());
            pstmt.setString(2, m.getEspecie());
            pstmt.setString(3, m.getRaza());
            // Conversión de Date util a sql
            pstmt.setDate(4, new java.sql.Date(m.getFechaNac().getTime()));
            pstmt.setDouble(5, m.getPeso());
            pstmt.setBytes(6, new byte[] {}); // Placeholder for Byte/Blob, assuming empty for now or null
            pstmt.setInt(7, idCliente);

            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
