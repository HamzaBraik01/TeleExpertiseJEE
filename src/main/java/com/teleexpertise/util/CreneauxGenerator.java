package com.teleexpertise.util;

import com.teleexpertise.dao.CreneauDAO;
import com.teleexpertise.dao.MedecinDAO;
import com.teleexpertise.model.Creneau;
import com.teleexpertise.model.Medecin;
import com.teleexpertise.model.Role;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

/**
 * Utilitaire pour générer des créneaux pour tous les spécialistes
 * Conformément aux exigences : créneaux de 30 minutes fixes prédéfinis
 */
public class CreneauxGenerator {

    public static void main(String[] args) {
        System.out.println("🕐 Démarrage de la génération des créneaux pour tous les spécialistes...\n");

        try {
            genererCreneauxPourTousLesSpecialistes();
            System.out.println("\n✅ Génération terminée avec succès !");
        } catch (Exception e) {
            System.err.println("\n❌ Erreur lors de la génération : " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Génère des créneaux pour tous les spécialistes existants dans la base
     */
    public static void genererCreneauxPourTousLesSpecialistes() {
        MedecinDAO medecinDAO = new MedecinDAO();
        CreneauDAO creneauDAO = new CreneauDAO();

        // Récupérer tous les spécialistes
        List<Medecin> specialistes = medecinDAO.findAllSpecialistes();

        if (specialistes.isEmpty()) {
            System.out.println("⚠️ Aucun spécialiste trouvé dans la base de données.");
            System.out.println("💡 Exécutez d'abord DatabaseSeeder pour ajouter des spécialistes.");
            return;
        }

        System.out.println("📋 " + specialistes.size() + " spécialiste(s) trouvé(s)\n");

        int totalCreneaux = 0;

        for (Medecin specialiste : specialistes) {
            System.out.println("👨‍⚕️ Génération pour Dr. " +
                specialiste.getUser().getPrenom() + " " +
                specialiste.getUser().getNom() +
                " (" + specialiste.getSpecialite().getNom() + ")");

            // Vérifier si le spécialiste a déjà des créneaux
            Long creneauxExistants = compterCreneauxExistants(specialiste.getId());

            if (creneauxExistants > 0) {
                System.out.println("   ℹ️ Déjà " + creneauxExistants + " créneau(x) existant(s) - Ignoré");
                continue;
            }

            try {
                int creneauxCrees = genererCreneauxPourSpecialiste(specialiste, creneauDAO);
                totalCreneaux += creneauxCrees;
                System.out.println("   ✅ " + creneauxCrees + " créneaux générés");
            } catch (Exception e) {
                System.err.println("   ❌ Erreur : " + e.getMessage());
            }
        }

        System.out.println("\n📊 Résumé : " + totalCreneaux + " créneaux créés au total");
    }

    /**
     * Génère des créneaux pour un spécialiste donné
     * Créneaux de 30 minutes conformément aux exigences
     */
    private static int genererCreneauxPourSpecialiste(Medecin specialiste, CreneauDAO creneauDAO) {
        LocalDateTime maintenant = LocalDateTime.now();
        int creneauxCrees = 0;

        // Générer des créneaux pour les 14 prochains jours (2 semaines)
        for (int jour = 1; jour <= 14; jour++) {
            LocalDateTime date = maintenant.plusDays(jour);

            // Créneaux du matin : 09h00 à 12h00 (par tranches de 30 min)
            creneauxCrees += creerCreneaux(specialiste, date,
                LocalTime.of(9, 0), LocalTime.of(12, 0), creneauDAO);

            // Créneaux de l'après-midi : 14h00 à 18h00 (par tranches de 30 min)
            creneauxCrees += creerCreneaux(specialiste, date,
                LocalTime.of(14, 0), LocalTime.of(18, 0), creneauDAO);
        }

        return creneauxCrees;
    }

    /**
     * Crée des créneaux de 30 minutes dans une plage horaire donnée
     */
    private static int creerCreneaux(Medecin specialiste, LocalDateTime date,
                                     LocalTime heureDebut, LocalTime heureFin,
                                     CreneauDAO creneauDAO) {
        int count = 0;
        LocalTime heureCourante = heureDebut;

        while (heureCourante.isBefore(heureFin)) {
            LocalTime heureFinCreneau = heureCourante.plusMinutes(30);

            // Créer le créneau
            LocalDateTime dateCreneau = date.toLocalDate().atTime(heureCourante);
            Creneau creneau = new Creneau(specialiste, heureCourante, heureFinCreneau, dateCreneau);
            creneau.setDisponible(true);
            creneau.setReserve(false);

            creneauDAO.save(creneau);
            count++;

            heureCourante = heureFinCreneau;
        }

        return count;
    }

    /**
     * Compte les créneaux existants pour un spécialiste
     */
    private static Long compterCreneauxExistants(Long specialisteId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(c) FROM Creneau c WHERE c.medecin.id = :id",
                Long.class);
            query.setParameter("id", specialisteId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    /**
     * Méthode utilitaire pour supprimer tous les créneaux (pour tests)
     */
    public static void supprimerTousLesCreneaux() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("DELETE FROM Creneau").executeUpdate();
            em.getTransaction().commit();
            System.out.println("✅ Tous les créneaux ont été supprimés");
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    /**
     * Affiche les statistiques des créneaux
     */
    public static void afficherStatistiques() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Total créneaux
            Long total = em.createQuery("SELECT COUNT(c) FROM Creneau c", Long.class)
                .getSingleResult();

            // Créneaux disponibles
            Long disponibles = em.createQuery(
                "SELECT COUNT(c) FROM Creneau c WHERE c.disponible = true AND c.reserve = false",
                Long.class).getSingleResult();

            // Créneaux réservés
            Long reserves = em.createQuery(
                "SELECT COUNT(c) FROM Creneau c WHERE c.reserve = true",
                Long.class).getSingleResult();

            System.out.println("\n📊 Statistiques des créneaux :");
            System.out.println("   Total : " + total);
            System.out.println("   Disponibles : " + disponibles);
            System.out.println("   Réservés : " + reserves);

        } finally {
            em.close();
        }
    }
}

