package com.teleexpertise.service;

import com.teleexpertise.dao.PatientDAO;
import com.teleexpertise.model.Patient;

import java.util.List;
import java.util.Optional;

public class PatientService {

    private PatientDAO patientDAO;

    public PatientService() {
        this.patientDAO = new PatientDAO();
    }


    public List<Patient> rechercherPatients(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return List.of();
        }

        return patientDAO.searchByNameAndNumeroSecu(searchTerm.trim());
    }


    public Optional<Patient> rechercherParNumeroSecu(String numeroSecu) {
        if (numeroSecu == null || numeroSecu.trim().isEmpty()) {
            return Optional.empty();
        }

        return patientDAO.findByNumeroSecuriteSociale(numeroSecu.trim());
    }


    public List<Patient> rechercherParNom(String nom) {
        if (nom == null || nom.trim().isEmpty()) {
            return List.of();
        }

        return patientDAO.searchByName(nom.trim());
    }


    public Optional<Patient> obtenirPatientParId(Long id) {
        if (id == null) {
            return Optional.empty();
        }

        return patientDAO.findById(id);
    }


    public int calculerAge(Patient patient) {
        if (patient == null || patient.getDateNaissance() == null) {
            return 0;
        }

        return java.time.Period.between(
            patient.getDateNaissance(),
            java.time.LocalDate.now()
        ).getYears();
    }


    public String formaterNumeroSecu(String numeroSecu) {
        if (numeroSecu == null || numeroSecu.length() != 15) {
            return numeroSecu;
        }

        return numeroSecu.substring(0, 1) + " " +
               numeroSecu.substring(1, 3) + " " +
               numeroSecu.substring(3, 5) + " " +
               numeroSecu.substring(5, 7) + " " +
               numeroSecu.substring(7, 10) + " " +
               numeroSecu.substring(10, 13) + " " +
               numeroSecu.substring(13, 15);
    }


    public void creerPatient(Patient patient) {
        if (patient != null) {
            patientDAO.create(patient);
        }
    }
}
