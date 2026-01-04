package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import modelo.Consulta;
import soporte.ConexionBDD;

public class ConsultaDAO {
    public boolean guardarConsulta(Consulta c) {
        Connection conn = ConexionBDD.getInstance().conectar();
        String sql = "INSERT INTO Consulta (fecha, hora, sintomas, diagnostico, tratamiento) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, new java.sql.Date(c.getFecha().getTime()));
            pstmt.setTime(2, c.getHora());
            pstmt.setString(3, c.getSintomas());
            pstmt.setString(4, c.getDiagnostico());
            pstmt.setString(5, c.getTratamiento());

            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
