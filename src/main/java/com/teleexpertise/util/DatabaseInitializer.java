package com.teleexpertise.util;

import com.teleexpertise.model.Role;
import com.teleexpertise.model.User;
import jakarta.persistence.EntityManager;

public class DatabaseInitializer {

    public static void main(String[] args) {
        System.out.println("🚀 Initialisation de la base de données TeleExpertise...");

        EntityManager entityManager = null;

        try {
            entityManager = JPAUtil.getEntityManager();
            entityManager.getTransaction().begin();

            System.out.println("✅ Connexion établie — insertion des utilisateurs de test...");

            // === Utilisateur 1 : Médecin Généraliste ===
            User generaliste = new User(
                    "dr_saad",
                    PasswordUtil.hashPassword("Saad@123"), // mot de passe haché !
                    "Saad",
                    "El Amrani",
                    "dr.saad@example.com",
                    Role.GENERALISTE
            );

            // === Utilisateur 2 : Infirmier ===
            User infirmier = new User(
                    "nurse_amina",
                    PasswordUtil.hashPassword("Amina@123"),
                    "Amina",
                    "Bouzid",
                    "amina.nurse@example.com",
                    Role.INFIRMIER
            );

            // === Utilisateur 3 : Spécialiste ===
            User specialiste = new User(
                    "dr_youssef",
                    PasswordUtil.hashPassword("Youssef@123"),
                    "Youssef",
                    "Tazi",
                    "dr.youssef@example.com",
                    Role.SPECIALISTE
            );

            // Sauvegarde des utilisateurs
            entityManager.persist(generaliste);
            entityManager.persist(infirmier);
            entityManager.persist(specialiste);

            entityManager.getTransaction().commit();
            System.out.println("✅ Données insérées avec succès !");

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

        System.out.println("🎯 Initialisation terminée. Vérifiez votre base MySQL !");
    }
}
