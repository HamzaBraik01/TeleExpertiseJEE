package com.teleexpertise.model;

public enum Priorite {
    URGENTE("Urgente", 1),
    NORMALE("Normale", 2),
    NON_URGENTE("Non urgente", 3);

    private final String libelle;
    private final int niveau;

    Priorite(String libelle, int niveau) {
        this.libelle = libelle;
        this.niveau = niveau;
    }

    public String getLibelle() { return libelle; }
    public int getNiveau() { return niveau; }
}
