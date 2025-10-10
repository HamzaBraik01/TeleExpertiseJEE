package com.teleexpertise.util;

import jakarta.persistence.EntityManager;

/**
 * Classe pour tester la connexion à la base de données et créer les tables
 */
public class DatabaseInitializer {

    public static void main(String[] args) {
        System.out.println("🚀 Initialisation de la base de données TeleExpertise...");

        EntityManager entityManager = null;

        try {
            // Cette ligne va déclencher la création des tables grâce à hibernate.hbm2ddl.auto=update
            entityManager = JPAUtil.getEntityManager();

            System.out.println("✅ Connexion à la base de données établie avec succès !");
            System.out.println("✅ Tables créées/mises à jour automatiquement par Hibernate !");

            // Test simple de la connexion
            entityManager.getTransaction().begin();

            // Vérification que la transaction fonctionne
            System.out.println("✅ Transaction de test démarrée avec succès !");

            entityManager.getTransaction().rollback(); // On annule car c'est juste un test
            System.out.println("✅ Transaction de test annulée - tout fonctionne !");

        } catch (Exception e) {
            System.err.println("❌ Erreur lors de l'initialisation : " + e.getMessage());
            e.printStackTrace();

            if (entityManager != null && entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            JPAUtil.shutdown();
        }

        System.out.println("🎯 Initialisation terminée. Vérifiez votre base de données MySQL !");
    }
}
