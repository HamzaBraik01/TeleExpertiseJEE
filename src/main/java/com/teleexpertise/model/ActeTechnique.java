package com.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "actes_techniques")
public class ActeTechnique {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TypeActeTechnique type;

    @Column(nullable = false)
    private Double cout;

    private String description;

    @Column(columnDefinition = "TEXT")
    private String resultats;

    @Column(name = "date_realisation")
    private LocalDateTime dateRealisation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "realise_par_id")
    private User realisePar;

    // Constructeurs
    public ActeTechnique() {}

    public ActeTechnique(Consultation consultation, TypeActeTechnique type, User realisePar) {
        this.consultation = consultation;
        this.type = type;
        this.cout = type.getCoutStandard();
        this.realisePar = realisePar;
        this.dateRealisation = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        if (dateRealisation == null) {
            dateRealisation = LocalDateTime.now();
        }
        if (cout == null && type != null) {
            cout = type.getCoutStandard();
        }
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) { this.consultation = consultation; }

    public TypeActeTechnique getType() { return type; }
    public void setType(TypeActeTechnique type) { this.type = type; }

    public Double getCout() { return cout; }
    public void setCout(Double cout) { this.cout = cout; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getResultats() { return resultats; }
    public void setResultats(String resultats) { this.resultats = resultats; }

    public LocalDateTime getDateRealisation() { return dateRealisation; }
    public void setDateRealisation(LocalDateTime dateRealisation) { this.dateRealisation = dateRealisation; }

    public User getRealisePar() { return realisePar; }
    public void setRealisePar(User realisePar) { this.realisePar = realisePar; }
}
