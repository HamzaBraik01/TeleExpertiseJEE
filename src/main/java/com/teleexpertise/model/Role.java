package com.teleexpertise.model;

public enum Role {
    INFIRMIER("Infirmier"),
    GENERALISTE("Médecin Généraliste"),
    SPECIALISTE("Médecin Spécialiste");

    private final String displayName;

    Role(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
