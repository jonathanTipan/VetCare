package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import soporte.ConexionBDD;

public class CitaDAO {
    public boolean actualizarEstado(int idCita, String estado) {
        Connection conn = ConexionBDD.getInstance().conectar();
        String sql = "UPDATE Cita SET estado = ? WHERE idCita = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, estado);
            pstmt.setInt(2, idCita);

            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean guardar(modelo.Cita c) {
        Connection conn = ConexionBDD.getInstance().conectar();
        String sql = "INSERT INTO Cita (fecha, hora, motivo, estado) VALUES (?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, new java.sql.Date(c.getFecha().getTime()));
            pstmt.setTime(2, c.getHora());
            pstmt.setString(3, c.getMotivo());
            pstmt.setString(4, "Pendiente");

            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
