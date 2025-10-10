package com.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "demandes_expertise")
public class DemandeExpertise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "specialiste_id", nullable = false)
    private Medecin specialiste;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creneau_id")
    private Creneau creneau;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String question;

    @Column(name = "donnees_analyses", columnDefinition = "TEXT")
    private String donneesAnalyses;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Priorite priorite = Priorite.NORMALE;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutExpertise statut = StatutExpertise.EN_ATTENTE;

    @Column(name = "date_demande")
    private LocalDateTime dateDemande;

    @Column(name = "date_reponse")
    private LocalDateTime dateReponse;

    @Column(name = "avis_medical", columnDefinition = "TEXT")
    private String avisMedical;

    @Column(columnDefinition = "TEXT")
    private String recommandations;

    @Column(name = "diagnostic_specialiste")
    private String diagnosticSpecialiste;

    public DemandeExpertise() {}

    public DemandeExpertise(Consultation consultation, Medecin specialiste, String question, Priorite priorite) {
        this.consultation = consultation;
        this.specialiste = specialiste;
        this.question = question;
        this.priorite = priorite;
        this.dateDemande = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        if (dateDemande == null) {
            dateDemande = LocalDateTime.now();
        }
    }

    public void terminerExpertise(String avisMedical, String recommandations) {
        this.avisMedical = avisMedical;
        this.recommandations = recommandations;
        this.statut = StatutExpertise.TERMINEE;
        this.dateReponse = LocalDateTime.now();

        if (creneau != null) {
            creneau.liberer();
        }
    }

    public boolean isTerminee() {
        return statut == StatutExpertise.TERMINEE;
    }

    public boolean isEnAttente() {
        return statut == StatutExpertise.EN_ATTENTE;
    }

    public long getDureeTraitement() {
        if (dateDemande != null && dateReponse != null) {
            return java.time.Duration.between(dateDemande, dateReponse).toHours();
        }
        return 0;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) { this.consultation = consultation; }

    public Medecin getSpecialiste() { return specialiste; }
    public void setSpecialiste(Medecin specialiste) { this.specialiste = specialiste; }

    public Creneau getCreneau() { return creneau; }
    public void setCreneau(Creneau creneau) { this.creneau = creneau; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getDonneesAnalyses() { return donneesAnalyses; }
    public void setDonneesAnalyses(String donneesAnalyses) { this.donneesAnalyses = donneesAnalyses; }

    public Priorite getPriorite() { return priorite; }
    public void setPriorite(Priorite priorite) { this.priorite = priorite; }

    public StatutExpertise getStatut() { return statut; }
    public void setStatut(StatutExpertise statut) { this.statut = statut; }

    public LocalDateTime getDateDemande() { return dateDemande; }
    public void setDateDemande(LocalDateTime dateDemande) { this.dateDemande = dateDemande; }

    public LocalDateTime getDateReponse() { return dateReponse; }
    public void setDateReponse(LocalDateTime dateReponse) { this.dateReponse = dateReponse; }

    public String getAvisMedical() { return avisMedical; }
    public void setAvisMedical(String avisMedical) { this.avisMedical = avisMedical; }

    public String getRecommandations() { return recommandations; }
    public void setRecommandations(String recommandations) { this.recommandations = recommandations; }

    public String getDiagnosticSpecialiste() { return diagnosticSpecialiste; }
    public void setDiagnosticSpecialiste(String diagnosticSpecialiste) { this.diagnosticSpecialiste = diagnosticSpecialiste; }

    public Double getCoutExpertise() {
        if (specialiste != null) {
            return specialiste.getTarifConsultation() * 0.8;
        }
        return 50.0;
    }

    public void setCoutExpertise(Double cout) {
        // Pour la compatibilité, on peut stocker dans une nouvelle propriété si nécessaire
        // Ou calculer dynamiquement
    }

    public String getReponseSpecialiste() {
        StringBuilder reponse = new StringBuilder();
        if (avisMedical != null) {
            reponse.append("Avis: ").append(avisMedical);
        }
        if (recommandations != null) {
            if (reponse.length() > 0) reponse.append("\n\n");
            reponse.append("Recommandations: ").append(recommandations);
        }
        return reponse.toString();
    }

    public void setReponseSpecialiste(String reponse) {
        this.avisMedical = reponse;
    }
}