package com.teleexpertise.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class TestConnection {
    public static void main(String[] args) {
        try {
            System.out.println("Test de connexion à la base de données...");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("teleexpertise-pu");
            EntityManager em = emf.createEntityManager();

            System.out.println("✓ Connexion JPA réussie !");

            em.close();
            emf.close();

        } catch (Exception e) {
            System.err.println("✗ Erreur de connexion : " + e.getMessage());
            e.printStackTrace();
        }
    }
}
