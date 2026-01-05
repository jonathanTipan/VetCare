package prueba;

import jakarta.persistence.EntityManager;
import soporte.JPAUtil;
import modelo.Usuario;

public class TestJPA {
    public static void main(String[] args) {
        System.out.println("Iniciando prueba de conexión JPA...");
        EntityManager em = JPAUtil.getEntityManager();

        try {
            System.out.println("EntityManager obtenido: " + em.isOpen());

            // Intenta una operación simple para forzar la generación de tablas
            em.getTransaction().begin();
            System.out.println("Transacción iniciada. Hibernate debería crear las tablas ahora si hbm2ddl=update.");

            // Verificar si hay usuarios
            long count = em.createQuery("SELECT COUNT(u) FROM Usuario u", Long.class).getSingleResult();
            System.out.println("Número de usuarios existentes: " + count);

            if (count == 0) {
                System.out.println("Creando usuario ADMIN de prueba...");
                Usuario admin = new Usuario("Administrador", "admin", "admin", "ADMIN");
                em.persist(admin);
                System.out.println("Usuario ADMIN creado.");
            }

            em.getTransaction().commit();
            System.out.println("Prueba finalizada con ÉXITO.");

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            System.out.println("Prueba FALLÓ.");
        } finally {
            em.close();
            JPAUtil.shutdown();
        }
    }
}
