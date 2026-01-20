package prueba;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import soporte.JPAUtil;
import modelo.Administrador;
import modelo.Cliente;
import modelo.Usuario;
import modelo.Veterinario;

public class TestJPA {

    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("PRUEBA DE CONEXIÓN JPA Y DATOS INICIALES");
        System.out.println("========================================");

        EntityManager em = null;
        EntityTransaction tx = null;

        try {
            // 1. Obtener la conexión
            System.out.println("Intentando conectar con la base de datos...");
            em = JPAUtil.getEntityManager();
            System.out.println("✓ Conexión establecida (EntityManager open: " + em.isOpen() + ")");

            tx = em.getTransaction();
            tx.begin();

        

            tx.commit();
            System.out.println("\n✓ Transacción finalizada exitosamente.");
            System.out.println("\n========================================");
            System.out.println("PRUEBA EXITOSA");
            System.out.println("========================================");

        } catch (Exception e) {
            System.out.println("\n❌ ERROR EN LA PRUEBA:");
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                tx.rollback();
                System.out.println("Transacción revertida.");
            }
        } finally {
            if (em != null) {
                em.close();
            }
            // Cerrar la factory para terminar el programa
            JPAUtil.shutdown();
        }
    }
}
