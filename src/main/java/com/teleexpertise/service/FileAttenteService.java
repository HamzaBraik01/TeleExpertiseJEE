package com.teleexpertise.service;

import com.teleexpertise.model.Patient;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;


public class FileAttenteService {

    // Map pour stocker les patients en attente par date
    private final Map<LocalDate, List<Patient>> fileAttente = new ConcurrentHashMap<>();


    public void add(Patient patient, LocalDate date) {
        if (patient != null && date != null) {
            patient.setEnAttente(true);
            if (patient.getHeureArrivee() == null) {
                patient.setHeureArrivee(LocalDateTime.now());
            }

            fileAttente.computeIfAbsent(date, k -> new ArrayList<>()).add(patient);
        }
    }


    public List<Patient> listByDate(LocalDate date) {
        if (date == null) {
            return new ArrayList<>();
        }

        return fileAttente.getOrDefault(date, new ArrayList<>())
                .stream()
                .filter(Patient::isEnAttente)
                .sorted(Comparator.comparing(Patient::getHeureArrivee))
                .collect(Collectors.toList());
    }


    public void remove(Patient patient, LocalDate date) {
        if (patient != null && date != null) {
            patient.setEnAttente(false);
            List<Patient> patients = fileAttente.get(date);
            if (patients != null) {
                patients.remove(patient);
            }
        }
    }


    public long countByDate(LocalDate date) {
        return listByDate(date).size();
    }


    public List<Patient> getAllPatientsEnAttente() {
        return fileAttente.entrySet()
                .stream()
                .flatMap(entry -> entry.getValue().stream())
                .filter(Patient::isEnAttente)
                .sorted(Comparator.comparing((Patient p) -> p.getHeureArrivee().toLocalDate())
                        .thenComparing(Patient::getHeureArrivee))
                .collect(Collectors.toList());
    }
}
