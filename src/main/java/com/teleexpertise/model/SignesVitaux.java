package com.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "signes_vitaux")
public class SignesVitaux {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Column(name = "tension_arterielle")
    private String tensionArterielle; // Format: "120/80"

    @Column(name = "frequence_cardiaque")
    private Integer frequenceCardiaque;

    @Column(name = "temperature")
    private Double temperature;

    @Column(name = "frequence_respiratoire")
    private Integer frequenceRespiratoire;

    @Column(name = "poids")
    private Double poids;

    @Column(name = "taille")
    private Integer taille;

    @Column(name = "saturation_oxygene")
    private Integer saturationOxygene;

    @Column(name = "date_mesure")
    private LocalDateTime dateMesure;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mesure_par_id")
    private User mesurePar;

    public SignesVitaux() {}

    public SignesVitaux(Patient patient, User mesurePar) {
        this.patient = patient;
        this.mesurePar = mesurePar;
        this.dateMesure = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        dateMesure = LocalDateTime.now();
    }

    public boolean isComplete() {
        return tensionArterielle != null && frequenceCardiaque != null
                && temperature != null && frequenceRespiratoire != null;
    }

    public Double getIMC() {
        if (poids != null && taille != null && taille > 0) {
            double tailleM = taille / 100.0;
            return poids / (tailleM * tailleM);
        }
        return null;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public String getTensionArterielle() { return tensionArterielle; }
    public void setTensionArterielle(String tensionArterielle) { this.tensionArterielle = tensionArterielle; }

    public Integer getFrequenceCardiaque() { return frequenceCardiaque; }
    public void setFrequenceCardiaque(Integer frequenceCardiaque) { this.frequenceCardiaque = frequenceCardiaque; }

    public Double getTemperature() { return temperature; }
    public void setTemperature(Double temperature) { this.temperature = temperature; }

    public Integer getFrequenceRespiratoire() { return frequenceRespiratoire; }
    public void setFrequenceRespiratoire(Integer frequenceRespiratoire) { this.frequenceRespiratoire = frequenceRespiratoire; }

    public Double getPoids() { return poids; }
    public void setPoids(Double poids) { this.poids = poids; }

    public Integer getTaille() { return taille; }
    public void setTaille(Integer taille) { this.taille = taille; }

    public Integer getSaturationOxygene() { return saturationOxygene; }
    public void setSaturationOxygene(Integer saturationOxygene) { this.saturationOxygene = saturationOxygene; }

    public LocalDateTime getDateMesure() { return dateMesure; }
    public void setDateMesure(LocalDateTime dateMesure) { this.dateMesure = dateMesure; }

    public User getMesurePar() { return mesurePar; }
    public void setMesurePar(User mesurePar) { this.mesurePar = mesurePar; }
}