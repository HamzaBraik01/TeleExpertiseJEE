package com.teleexpertise.model;

public enum TypeActeTechnique {
    RADIOGRAPHIE("Radiographie", 80.0, "Examen d'imagerie médicale utilisant les rayons X"),
    ECHOGRAPHIE("Échographie", 120.0, "Examen d'imagerie par ultrasons"),
    IRM("IRM", 400.0, "Imagerie par résonance magnétique - examen approfondi"),
    ELECTROCARDIOGRAMME("Électrocardiogramme", 50.0, "Enregistrement de l'activité électrique du cœur (ECG)"),
    DERMATOLOGIQUE_LASER("Dermatologique (Laser)", 200.0, "Traitement dermatologique par laser"),
    FOND_OEIL("Fond d'œil", 60.0, "Examen ophtalmologique du fond de l'œil"),
    ANALYSE_SANG("Analyse de sang", 45.0, "Analyse biologique sanguine"),
    ANALYSE_URINE("Analyse d'urine", 25.0, "Analyse biologique urinaire");

    private final String libelle;
    private final Double coutStandard;
    private final String description;

    TypeActeTechnique(String libelle, Double coutStandard, String description) {
        this.libelle = libelle;
        this.coutStandard = coutStandard;
        this.description = description;
    }

    public String getLibelle() { return libelle; }
    public Double getCoutStandard() { return coutStandard; }
    public String getDescription() { return description; }
}
