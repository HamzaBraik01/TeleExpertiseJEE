package com.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "consultations")
public class Consultation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id", nullable = false)
    private User medecin;

    @Column(nullable = false)
    private String motif;

    @Column(columnDefinition = "TEXT")
    private String observations;

    @Column(name = "examen_clinique", columnDefinition = "TEXT")
    private String examenClinique;

    @Column(name = "analyse_symptomes", columnDefinition = "TEXT")
    private String analyseSymptomes;

    private String diagnostic;

    @Column(columnDefinition = "TEXT")
    private String traitement;

    @Enumerated(EnumType.STRING)
    private StatutConsultation statut = StatutConsultation.EN_COURS;

    @Column(name = "cout_consultation")
    private Double coutConsultation = 150.0; // Coût fixe

    @Column(name = "date_consultation")
    private LocalDateTime dateConsultation;

    @Column(name = "date_cloture")
    private LocalDateTime dateCloture;

    // Relations
    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ActeTechnique> actesTechniques;

    @OneToOne(mappedBy = "consultation", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private DemandeExpertise demandeExpertise;

    // Constructeurs
    public Consultation() {}

    public Consultation(Patient patient, User medecin, String motif) {
        this.patient = patient;
        this.medecin = medecin;
        this.motif = motif;
        this.dateConsultation = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        if (dateConsultation == null) {
            dateConsultation = LocalDateTime.now();
        }
    }

    // Méthodes utilitaires
    public Double getCoutTotal() {
        double total = coutConsultation;

        if (actesTechniques != null) {
            total += actesTechniques.stream()
                    .mapToDouble(ActeTechnique::getCout)
                    .sum();
        }

        if (demandeExpertise != null && demandeExpertise.getSpecialiste() != null) {
            total += demandeExpertise.getSpecialiste().getTarifConsultation();
        }

        return total;
    }

    public boolean isTerminee() {
        return statut == StatutConsultation.TERMINEE;
    }

    public boolean isEnAttenteAvis() {
        return statut == StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE;
    }

    public void cloturer() {
        this.statut = StatutConsultation.TERMINEE;
        this.dateCloture = LocalDateTime.now();
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public User getMedecin() { return medecin; }
    public void setMedecin(User medecin) { this.medecin = medecin; }

    public String getMotif() { return motif; }
    public void setMotif(String motif) { this.motif = motif; }

    public String getObservations() { return observations; }
    public void setObservations(String observations) { this.observations = observations; }

    public String getExamenClinique() { return examenClinique; }
    public void setExamenClinique(String examenClinique) { this.examenClinique = examenClinique; }

    public String getAnalyseSymptomes() { return analyseSymptomes; }
    public void setAnalyseSymptomes(String analyseSymptomes) { this.analyseSymptomes = analyseSymptomes; }

    public String getDiagnostic() { return diagnostic; }
    public void setDiagnostic(String diagnostic) { this.diagnostic = diagnostic; }

    public String getTraitement() { return traitement; }
    public void setTraitement(String traitement) { this.traitement = traitement; }

    public StatutConsultation getStatut() { return statut; }
    public void setStatut(StatutConsultation statut) { this.statut = statut; }

    public Double getCoutConsultation() { return coutConsultation; }
    public void setCoutConsultation(Double coutConsultation) { this.coutConsultation = coutConsultation; }

    public LocalDateTime getDateConsultation() { return dateConsultation; }
    public void setDateConsultation(LocalDateTime dateConsultation) { this.dateConsultation = dateConsultation; }

    public LocalDateTime getDateCloture() { return dateCloture; }
    public void setDateCloture(LocalDateTime dateCloture) { this.dateCloture = dateCloture; }

    public List<ActeTechnique> getActesTechniques() { return actesTechniques; }
    public void setActesTechniques(List<ActeTechnique> actesTechniques) { this.actesTechniques = actesTechniques; }

    public DemandeExpertise getDemandeExpertise() { return demandeExpertise; }
    public void setDemandeExpertise(DemandeExpertise demandeExpertise) { this.demandeExpertise = demandeExpertise; }
}
