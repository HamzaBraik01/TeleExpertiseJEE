package com.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "creneaux")
public class Creneau {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id", nullable = false)
    private Medecin medecin;

    @Column(name = "heure_debut", nullable = false)
    private LocalTime heureDebut;

    @Column(name = "heure_fin", nullable = false)
    private LocalTime heureFin;

    @Column(name = "date_creneau", nullable = false)
    private LocalDateTime dateCreneau;

    @Column(name = "is_disponible")
    private boolean disponible = true;

    @Column(name = "is_reserve")
    private boolean reserve = false;

    @OneToOne(mappedBy = "creneau", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private DemandeExpertise demandeExpertise;

    public Creneau() {}

    public Creneau(Medecin medecin, LocalTime heureDebut, LocalTime heureFin, LocalDateTime dateCreneau) {
        this.medecin = medecin;
        this.heureDebut = heureDebut;
        this.heureFin = heureFin;
        this.dateCreneau = dateCreneau;
    }

    public boolean isDisponiblePourReservation() {
        return disponible && !reserve && dateCreneau.isAfter(LocalDateTime.now());
    }

    public boolean isPasse() {
        return dateCreneau.isBefore(LocalDateTime.now());
    }

    public void reserver() {
        this.reserve = true;
        this.disponible = false;
    }

    public void liberer() {
        this.reserve = false;
        this.disponible = true;
    }

    public String getHeureFormatee() {
        return heureDebut + " - " + heureFin;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Medecin getMedecin() { return medecin; }
    public void setMedecin(Medecin medecin) { this.medecin = medecin; }

    public LocalTime getHeureDebut() { return heureDebut; }
    public void setHeureDebut(LocalTime heureDebut) { this.heureDebut = heureDebut; }

    public LocalTime getHeureFin() { return heureFin; }
    public void setHeureFin(LocalTime heureFin) { this.heureFin = heureFin; }

    public LocalDateTime getDateCreneau() { return dateCreneau; }
    public void setDateCreneau(LocalDateTime dateCreneau) { this.dateCreneau = dateCreneau; }

    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }

    public boolean isReserve() { return reserve; }
    public void setReserve(boolean reserve) { this.reserve = reserve; }

    public DemandeExpertise getDemandeExpertise() { return demandeExpertise; }
    public void setDemandeExpertise(DemandeExpertise demandeExpertise) { this.demandeExpertise = demandeExpertise; }
}
