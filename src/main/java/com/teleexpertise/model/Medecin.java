package com.teleexpertise.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "medecins")
public class Medecin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Specialite specialite;

    @Column(name = "tarif_consultation", nullable = false)
    private Double tarifConsultation;

    @Column(name = "duree_consultation")
    private Integer dureeConsultation = 30; // minutes

    private String diplomes;
    private String experience;

    @Column(name = "numero_ordre")
    private String numeroOrdre;

    @Column(name = "is_disponible")
    private boolean disponible = true;

    // Relations
    @OneToMany(mappedBy = "medecin", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Creneau> creneaux;

    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<DemandeExpertise> expertises;

    public Medecin() {}

    public Medecin(User user, Specialite specialite, Double tarifConsultation) {
        this.user = user;
        this.specialite = specialite;
        this.tarifConsultation = tarifConsultation;
    }

    public String getNomComplet() {
        return user != null ? user.getFullName() : "";
    }

    public boolean isSpecialiste() {
        return user != null && user.getRole() == Role.SPECIALISTE;
    }

    public long getNombreExpertisesTerminees() {
        if (expertises == null) return 0;
        return expertises.stream()
                .filter(e -> e.getStatut() == StatutExpertise.TERMINEE)
                .count();
    }

    public Double getRevenus() {
        if (expertises == null) return 0.0;
        return expertises.stream()
                .filter(e -> e.getStatut() == StatutExpertise.TERMINEE)
                .mapToDouble(e -> tarifConsultation)
                .sum();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Specialite getSpecialite() { return specialite; }
    public void setSpecialite(Specialite specialite) { this.specialite = specialite; }

    public Double getTarifConsultation() { return tarifConsultation; }
    public void setTarifConsultation(Double tarifConsultation) { this.tarifConsultation = tarifConsultation; }

    public Integer getDureeConsultation() { return dureeConsultation; }
    public void setDureeConsultation(Integer dureeConsultation) { this.dureeConsultation = dureeConsultation; }

    public String getDiplomes() { return diplomes; }
    public void setDiplomes(String diplomes) { this.diplomes = diplomes; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getNumeroOrdre() { return numeroOrdre; }
    public void setNumeroOrdre(String numeroOrdre) { this.numeroOrdre = numeroOrdre; }

    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }

    public List<Creneau> getCreneaux() { return creneaux; }
    public void setCreneaux(List<Creneau> creneaux) { this.creneaux = creneaux; }

    public List<DemandeExpertise> getExpertises() { return expertises; }
    public void setExpertises(List<DemandeExpertise> expertises) { this.expertises = expertises; }
}
