package com.teleexpertise.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Classe utilitaire pour gérer JPA/Hibernate
 */
public class JPAUtil {

    private static EntityManagerFactory entityManagerFactory;

    static {
        try {
            // Initialise l'EntityManagerFactory avec la configuration du persistence.xml
            entityManagerFactory = Persistence.createEntityManagerFactory("TeleExpertisePU");
            System.out.println("✅ EntityManagerFactory initialisé avec succès !");
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de l'initialisation de JPA : " + e.getMessage());
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }
    }

    /**
     * Récupère une instance d'EntityManager
     */
    public static EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    /**
     * Ferme l'EntityManagerFactory
     */
    public static void shutdown() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
            System.out.println("EntityManagerFactory fermé.");
        }
    }
}
