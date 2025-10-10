package com.teleexpertise.model;

public enum StatutConsultation {
    EN_COURS("En cours"),
    EN_ATTENTE_AVIS_SPECIALISTE("En attente avis spécialiste"),
    TERMINEE("Terminée"),
    ANNULEE("Annulée");

    private final String libelle;

    StatutConsultation(String libelle) {
        this.libelle = libelle;
    }

    public String getLibelle() {
        return libelle;
    }
}
