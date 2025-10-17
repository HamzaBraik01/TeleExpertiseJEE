package com.teleexpertise.util;

import com.teleexpertise.model.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Classe utilitaire pour initialiser la base de données avec des données de test
 */
public class DatabaseSeeder {

    public static void main(String[] args) {
        System.out.println("🌱 Démarrage du seed de la base de données...");

        try {
            seedSpecialistes();
            System.out.println("✅ Seed terminé avec succès !");
        } catch (Exception e) {
            System.err.println("❌ Erreur lors du seed : " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void seedSpecialistes() {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            // Vérifier si des spécialistes existent déjà
            Long count = em.createQuery("SELECT COUNT(m) FROM Medecin m WHERE m.user.role = :role", Long.class)
                    .setParameter("role", Role.SPECIALISTE)
                    .getSingleResult();

            if (count > 0) {
                System.out.println("⚠️ Des spécialistes existent déjà dans la base. Nombre : " + count);
                System.out.println("ℹ️ Ajout de nouveaux spécialistes...");
            }

            List<MedecinData> specialistesData = getSpecialistesData();
            int added = 0;

            for (MedecinData data : specialistesData) {
                // Vérifier si l'email existe déjà
                Long existingUser = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class)
                        .setParameter("email", data.email)
                        .getSingleResult();

                if (existingUser > 0) {
                    System.out.println("⏩ Utilisateur déjà existant : " + data.email);
                    continue;
                }

                // Créer l'utilisateur
                User user = new User();
                user.setNom(data.nom);
                user.setPrenom(data.prenom);
                user.setEmail(data.email);
                user.setUsername(data.email); // Utiliser l'email comme username
                user.setPassword(BCrypt.hashpw("password123", BCrypt.gensalt()));
                user.setRole(Role.SPECIALISTE);
                user.setActive(true);
                user.setCreatedAt(LocalDateTime.now());

                em.persist(user);
                em.flush(); // Pour obtenir l'ID généré

                // Créer le médecin spécialiste
                Medecin medecin = new Medecin();
                medecin.setUser(user);
                medecin.setSpecialite(data.specialite);
                medecin.setTarifConsultation(data.tarif);
                medecin.setDureeConsultation(data.duree);
                medecin.setDiplomes(data.diplomes);
                medecin.setExperience(data.experience);
                medecin.setNumeroOrdre(data.numeroOrdre);
                medecin.setDisponible(true);

                em.persist(medecin);
                added++;

                System.out.println("➕ Ajouté : Dr. " + data.prenom + " " + data.nom +
                                 " (" + data.specialite.getNom() + ")");
            }

            transaction.commit();
            System.out.println("\n✅ " + added + " spécialiste(s) ajouté(s) avec succès !");

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors du seed des spécialistes", e);
        } finally {
            em.close();
        }
    }

    private static List<MedecinData> getSpecialistesData() {
        List<MedecinData> data = new ArrayList<>();

        // Cardiologie
        data.add(new MedecinData(
            "BENALI", "Sara", "sara.benali@teleexpertise.ma",
            "0612345678", "123 Rue Mohammed V, Casablanca",
            Specialite.CARDIOLOGIE, 500.0, 45,
            "Doctorat en Cardiologie - Université Mohammed V",
            "15 ans d'expérience en cardiologie interventionnelle",
            "ORD-CARD-001"
        ));

        data.add(new MedecinData(
            "BENCHEKROUN", "Omar", "omar.benchekroun@teleexpertise.ma",
            "0667890123", "33 Rue Imam Malik, Fès",
            Specialite.CARDIOLOGIE, 480.0, 45,
            "Doctorat en Cardiologie - Université Sidi Mohammed Ben Abdellah",
            "13 ans d'expérience spécialisée en rythmologie",
            "ORD-CARD-006"
        ));

        // Dermatologie
        data.add(new MedecinData(
            "ALAMI", "Karim", "karim.alami@teleexpertise.ma",
            "0623456789", "45 Avenue Hassan II, Rabat",
            Specialite.DERMATOLOGIE, 400.0, 30,
            "Doctorat en Dermatologie - Université Hassan II",
            "10 ans d'expérience en dermatologie esthétique et médicale",
            "ORD-DERM-002"
        ));

        data.add(new MedecinData(
            "IDRISSI", "Amina", "amina.idrissi@teleexpertise.ma",
            "0678901234", "56 Boulevard Moulay Youssef, Meknès",
            Specialite.DERMATOLOGIE, 420.0, 35,
            "Doctorat en Dermatologie - Université Moulay Ismail",
            "11 ans d'expérience spécialisée en dermatologie pédiatrique",
            "ORD-DERM-007"
        ));

        // Pneumologie
        data.add(new MedecinData(
            "TAHIRI", "Fatima", "fatima.tahiri@teleexpertise.ma",
            "0634567890", "78 Boulevard Zerktouni, Marrakech",
            Specialite.PNEUMOLOGIE, 450.0, 40,
            "Doctorat en Pneumologie - Université Cadi Ayyad",
            "12 ans d'expérience en pathologies respiratoires",
            "ORD-PNEU-003"
        ));

        // Neurologie
        data.add(new MedecinData(
            "CHRAIBI", "Ahmed", "ahmed.chraibi@teleexpertise.ma",
            "0645678901", "12 Rue de Fès, Tanger",
            Specialite.NEUROLOGIE, 550.0, 50,
            "Doctorat en Neurologie - Université Mohammed VI",
            "18 ans d'expérience en neurologie clinique",
            "ORD-NEUR-004"
        ));

        data.add(new MedecinData(
            "BERRADA", "Youssef", "youssef.berrada@teleexpertise.ma",
            "0689012345", "21 Avenue Mohammed VI, Oujda",
            Specialite.NEUROLOGIE, 520.0, 45,
            "Doctorat en Neurologie - Université Mohammed Premier",
            "16 ans d'expérience spécialisée en épilepsie",
            "ORD-NEUR-008"
        ));

        // Pédiatrie (au lieu de Pédiatrie qui n'existe pas)
        data.add(new MedecinData(
            "LAMRANI", "Nadia", "nadia.lamrani@teleexpertise.ma",
            "0656789012", "90 Avenue des FAR, Agadir",
            Specialite.RHUMATOLOGIE, 350.0, 35,
            "Doctorat en Rhumatologie - Université Ibn Zohr",
            "8 ans d'expérience en rhumatologie générale",
            "ORD-RHUM-005"
        ));

        // Psychiatrie
        data.add(new MedecinData(
            "FASSI", "Salma", "salma.fassi@teleexpertise.ma",
            "0698765432", "67 Avenue des Nations Unies, Casablanca",
            Specialite.PSYCHIATRIE, 500.0, 50,
            "Doctorat en Psychiatrie - Université Hassan II",
            "14 ans d'expérience en psychiatrie adulte",
            "ORD-PSY-009"
        ));

        // Orthopédie (ORTHOPÉDIE avec accent)
        data.add(new MedecinData(
            "TAZI", "Mehdi", "mehdi.tazi@teleexpertise.ma",
            "0676543210", "89 Boulevard Anfa, Casablanca",
            Specialite.ORTHOPÉDIE, 600.0, 40,
            "Doctorat en Orthopédie - Université Mohammed V",
            "17 ans d'expérience en chirurgie orthopédique",
            "ORD-ORTHO-010"
        ));

        return data;
    }

    // Classe interne pour stocker les données des spécialistes
    private static class MedecinData {
        String nom, prenom, email, telephone, adresse;
        Specialite specialite;
        Double tarif;
        Integer duree;
        String diplomes, experience, numeroOrdre;

        MedecinData(String nom, String prenom, String email, String telephone, String adresse,
                   Specialite specialite, Double tarif, Integer duree,
                   String diplomes, String experience, String numeroOrdre) {
            this.nom = nom;
            this.prenom = prenom;
            this.email = email;
            this.telephone = telephone;
            this.adresse = adresse;
            this.specialite = specialite;
            this.tarif = tarif;
            this.duree = duree;
            this.diplomes = diplomes;
            this.experience = experience;
            this.numeroOrdre = numeroOrdre;
        }
    }
}
