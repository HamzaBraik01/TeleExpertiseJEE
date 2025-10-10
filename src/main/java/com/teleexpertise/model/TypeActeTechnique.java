package com.teleexpertise.model;

public enum TypeActeTechnique {
    RADIOGRAPHIE("Radiographie", 80.0),
    ECHOGRAPHIE("Échographie", 120.0),
    IRM("IRM", 400.0),
    ELECTROCARDIOGRAMME("Électrocardiogramme", 50.0),
    DERMATOLOGIQUE_LASER("Dermatologique (Laser)", 200.0),
    FOND_OEIL("Fond d'œil", 60.0),
    ANALYSE_SANG("Analyse de sang", 45.0),
    ANALYSE_URINE("Analyse d'urine", 25.0);

    private final String libelle;
    private final Double coutStandard;

    TypeActeTechnique(String libelle, Double coutStandard) {
        this.libelle = libelle;
        this.coutStandard = coutStandard;
    }

    public String getLibelle() { return libelle; }
    public Double getCoutStandard() { return coutStandard; }
}
