package com.teleexpertise.util;

import com.teleexpertise.dao.UserDAO;
import com.teleexpertise.dao.PatientDAO;
import com.teleexpertise.dao.ConsultationDAO;
import com.teleexpertise.dao.ActeTechniqueDAO;
import com.teleexpertise.model.*;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class DataInitializer {

    public static void main(String[] args) {
        try {
            System.out.println("🚀 Initialisation des données de test...");

            UserDAO userDAO = new UserDAO();
            PatientDAO patientDAO = new PatientDAO();
            ConsultationDAO consultationDAO = new ConsultationDAO();
            ActeTechniqueDAO acteTechniqueDAO = new ActeTechniqueDAO();

            // 1. Créer des utilisateurs
            System.out.println("📝 Création des utilisateurs...");

            // Généraliste
            User generaliste = new User(
                "dr.martin",
                BCrypt.hashpw("123456", BCrypt.gensalt()),
                "Martin",
                "Jean",
                "jean.martin@teleexpertise.com",
                Role.GENERALISTE
            );
            userDAO.save(generaliste);

            // Spécialistes
            User cardiologue = new User(
                "dr.durand",
                BCrypt.hashpw("123456", BCrypt.gensalt()),
                "Durand",
                "Marie",
                "marie.durand@teleexpertise.com",
                Role.SPECIALISTE
            );
            userDAO.save(cardiologue);

            // Infirmier
            User infirmier = new User(
                "inf.bernard",
                BCrypt.hashpw("123456", BCrypt.gensalt()),
                "Bernard",
                "Paul",
                "paul.bernard@teleexpertise.com",
                Role.INFIRMIER
            );
            userDAO.save(infirmier);

            // 2. Créer des patients
            System.out.println("👥 Création des patients...");

            Patient patient1 = new Patient(
                "Dupont",
                "Sophie",
                LocalDate.of(1985, 5, 15),
                "1234567890123"
            );
            patient1.setAdresse("123 Rue de la Paix, Paris");
            patient1.setTelephone("0123456789");
            patient1.setEnAttente(true);
            patient1.setStatut("EN_ATTENTE");
            patientDAO.create(patient1);

            Patient patient2 = new Patient(
                "Moreau",
                "Pierre",
                LocalDate.of(1978, 12, 3),
                "9876543210987"
            );
            patient2.setAdresse("456 Avenue des Champs, Lyon");
            patient2.setTelephone("0987654321");
            patient2.setEnAttente(false);
            patient2.setStatut("CONSULTATION_TERMINEE");
            patientDAO.create(patient2);

            // 3. Créer des consultations
            System.out.println("🩺 Création des consultations...");

            Consultation consultation1 = new Consultation(
                patient1,
                generaliste,
                "Douleur thoracique"
            );
            consultation1.setObservations("Patient se plaint de douleurs thoraciques depuis 2 jours");
            consultation1.setStatut(StatutConsultation.EN_COURS);
            consultation1.setExamenClinique("Auscultation cardiaque normale, tension artérielle élevée");
            consultationDAO.save(consultation1);

            Consultation consultation2 = new Consultation(
                patient2,
                generaliste,
                "Contrôle de routine"
            );
            consultation2.setObservations("Contrôle annuel");
            consultation2.setStatut(StatutConsultation.TERMINEE);
            consultation2.setDiagnostic("Bilan de santé normal");
            consultation2.setTraitement("Aucun traitement spécifique");
            consultation2.setDateCloture(LocalDateTime.now().minusDays(1));
            consultationDAO.save(consultation2);

            // 4. Créer des actes techniques
            System.out.println("🔬 Création des actes techniques...");

            ActeTechnique acte1 = new ActeTechnique(
                consultation1,
                TypeActeTechnique.ELECTROCARDIOGRAMME,
                generaliste
            );
            acte1.setDescription("ECG de repos pour investigation douleur thoracique");
            acte1.setCout(50.0);
            acteTechniqueDAO.save(acte1);

            ActeTechnique acte2 = new ActeTechnique(
                consultation1,
                TypeActeTechnique.ANALYSE_SANG,
                infirmier
            );
            acte2.setDescription("Bilan lipidique et glycémique");
            acte2.setCout(35.0);
            acteTechniqueDAO.save(acte2);

            ActeTechnique acte3 = new ActeTechnique(
                consultation2,
                TypeActeTechnique.ANALYSE_URINE,
                infirmier
            );
            acte3.setDescription("Analyse d'urine de routine");
            acte3.setCout(25.0);
            acte3.setResultats("Résultats normaux - pas d'anomalie détectée");
            acteTechniqueDAO.save(acte3);

            System.out.println("✅ Données de test créées avec succès !");
            System.out.println("\n📋 Résumé des données créées :");
            System.out.println("• 3 utilisateurs (1 généraliste, 1 spécialiste, 1 infirmier)");
            System.out.println("• 2 patients");
            System.out.println("• 2 consultations");
            System.out.println("• 3 actes techniques");
            System.out.println("\n🔑 Comptes de connexion :");
            System.out.println("• Généraliste: dr.martin / 123456");
            System.out.println("• Spécialiste: dr.durand / 123456");
            System.out.println("• Infirmier: inf.bernard / 123456");

        } catch (Exception e) {
            System.err.println("❌ Erreur lors de l'initialisation des données : " + e.getMessage());
            e.printStackTrace();
        }
    }
}
