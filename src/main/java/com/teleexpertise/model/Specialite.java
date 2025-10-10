package com.teleexpertise.model;

public enum Specialite {
    CARDIOLOGIE("Cardiologie", "Maladies du cœur et des vaisseaux sanguins"),
    PNEUMOLOGIE("Pneumologie", "Maladies respiratoires et pulmonaires"),
    NEUROLOGIE("Neurologie", "Troubles du système nerveux"),
    GASTRO_ENTEROLOGIE("Gastro-entérologie", "Maladies du système digestif"),
    ENDOCRINOLOGIE("Endocrinologie", "Troubles hormonaux et métaboliques"),
    DERMATOLOGIE("Dermatologie", "Maladies de la peau"),
    RHUMATOLOGIE("Rhumatologie", "Maladies des articulations, os et muscles"),
    PSYCHIATRIE("Psychiatrie", "Troubles mentaux et psychologiques"),
    NEPHROLOGIE("Néphrologie", "Maladies des reins"),
    ORTHOPÉDIE("Orthopédie", "Traumatismes et pathologies des os, articulations et muscles");

    private final String nom;
    private final String description;

    Specialite(String nom, String description) {
        this.nom = nom;
        this.description = description;
    }

    public String getNom() { return nom; }
    public String getDescription() { return description; }
}
