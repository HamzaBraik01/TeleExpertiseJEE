package com.teleexpertise.service;

import com.teleexpertise.dao.ActeTechniqueDAO;
import com.teleexpertise.dao.ConsultationDAO;
import com.teleexpertise.dao.PatientDAO;
import com.teleexpertise.model.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class ConsultationService {

    private ConsultationDAO consultationDAO;
    private ActeTechniqueDAO acteTechniqueDAO;
    private PatientDAO patientDAO;

    public ConsultationService() {
        this.consultationDAO = new ConsultationDAO();
        this.acteTechniqueDAO = new ActeTechniqueDAO();
        this.patientDAO = new PatientDAO();
    }


    public Consultation creerConsultation(Long patientId, User medecin, String motif, String observations) {
        Optional<Patient> patientOpt = patientDAO.findById(patientId);
        if (!patientOpt.isPresent()) {
            throw new IllegalArgumentException("Patient introuvable avec l'ID: " + patientId);
        }

        Patient patient = patientOpt.get();

        if (!"EN_ATTENTE".equals(patient.getStatut())) {
            throw new IllegalStateException("Le patient n'est pas en attente de consultation");
        }

        Consultation consultation = new Consultation(patient, medecin, motif);
        consultation.setObservations(observations);
        consultation.setStatut(StatutConsultation.EN_COURS);

        consultationDAO.save(consultation);

        patient.setStatut("EN_CONSULTATION");
        patientDAO.update(patient);

        return consultation;
    }


    public ActeTechnique ajouterActeTechnique(Long consultationId, User medecin,
            TypeActeTechnique type, Double cout, String description) {

        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable");
        }

        // Vérifier que le médecin est autorisé
        if (!consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new IllegalStateException("Vous n'êtes pas autorisé à modifier cette consultation");
        }

        // Vérifier que la consultation n'est pas terminée
        if (consultation.isTerminee()) {
            throw new IllegalStateException("Impossible d'ajouter des actes à une consultation terminée");
        }

        // Créer l'acte technique
        ActeTechnique acte = new ActeTechnique(consultation, type, medecin);
        if (cout != null && cout > 0) {
            acte.setCout(cout);
        }
        acte.setDescription(description);

        acteTechniqueDAO.save(acte);

        return acte;
    }


    public void terminerConsultation(Long consultationId, User medecin) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable");
        }

        // Vérifier que le médecin est autorisé
        if (!consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new IllegalStateException("Vous n'êtes pas autorisé à modifier cette consultation");
        }

        // Vérifier que la consultation n'est pas déjà terminée
        if (consultation.isTerminee()) {
            throw new IllegalStateException("La consultation est déjà terminée");
        }

        // Terminer la consultation
        consultation.cloturer();
        consultation.setDateCloture(LocalDateTime.now());
        consultationDAO.update(consultation);

        // Mettre à jour le statut du patient
        Patient patient = consultation.getPatient();
        patient.setStatut("CONSULTATION_TERMINEE");
        patientDAO.update(patient);
    }


    public void modifierConsultation(Long consultationId, User medecin,
            String motif, String observations, String examenClinique,
            String analyseSymptomes, String diagnostic, String traitement) {

        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable");
        }

        // Vérifier que le médecin est autorisé
        if (!consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new IllegalStateException("Vous n'êtes pas autorisé à modifier cette consultation");
        }

        // Vérifier que la consultation n'est pas terminée
        if (consultation.isTerminee()) {
            throw new IllegalStateException("Impossible de modifier une consultation terminée");
        }

        // Mettre à jour les informations
        consultation.setMotif(motif);
        consultation.setObservations(observations);
        consultation.setExamenClinique(examenClinique);
        consultation.setAnalyseSymptomes(analyseSymptomes);
        consultation.setDiagnostic(diagnostic);
        consultation.setTraitement(traitement);

        consultationDAO.update(consultation);
    }


    public List<Consultation> getConsultationsByMedecin(User medecin) {
        return consultationDAO.findByMedecin(medecin);
    }


    public List<Patient> getPatientsEnAttente() {
        return patientDAO.findPatientsEnAttente();
    }


    public ConsultationDetails getConsultationDetails(Long consultationId, User medecin) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable");
        }

        // Vérifier que le médecin est autorisé à voir cette consultation
        if (!consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new IllegalStateException("Vous n'êtes pas autorisé à voir cette consultation");
        }

        List<ActeTechnique> actes = acteTechniqueDAO.findByConsultation(consultation);

        return new ConsultationDetails(consultation, actes);
    }


    public Double calculerCoutTotal(Long consultationId) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            return 0.0;
        }

        return consultation.getCoutTotal();
    }


    public static class ConsultationDetails {
        private final Consultation consultation;
        private final List<ActeTechnique> actesTechniques;

        public ConsultationDetails(Consultation consultation, List<ActeTechnique> actesTechniques) {
            this.consultation = consultation;
            this.actesTechniques = actesTechniques;
        }

        public Consultation getConsultation() { return consultation; }
        public List<ActeTechnique> getActesTechniques() { return actesTechniques; }

        public Double getCoutTotal() {
            return consultation.getCoutTotal();
        }

        public int getNombreActes() {
            return actesTechniques.size();
        }
    }
}
