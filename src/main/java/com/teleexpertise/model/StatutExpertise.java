package com.teleexpertise.model;

public enum StatutExpertise {
    EN_ATTENTE("En attente"),
    ACCEPTEE("Acceptée"),
    EN_COURS("En cours"),
    TERMINEE("Terminée"),
    REFUSEE("Refusée"),
    ANNULEE("Annulée");

    private final String libelle;

    StatutExpertise(String libelle) {
        this.libelle = libelle;
    }

    public String getLibelle() {
        return libelle;
    }
}
