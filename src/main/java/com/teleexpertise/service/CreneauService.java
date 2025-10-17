package com.teleexpertise.service;

import com.teleexpertise.dao.CreneauDAO;
import com.teleexpertise.dao.MedecinDAO;
import com.teleexpertise.model.Creneau;
import com.teleexpertise.model.Medecin;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class CreneauService {

    private final CreneauDAO creneauDAO;
    private final MedecinDAO medecinDAO;

    public CreneauService() {
        this.creneauDAO = new CreneauDAO();
        this.medecinDAO = new MedecinDAO();
    }

    /**
     * Récupère tous les créneaux disponibles d'un spécialiste
     */
    public List<Creneau> getCreneauxDisponibles(Long specialisteId) {
        return creneauDAO.findByMedecinAndDisponible(specialisteId);
    }

    /**
     * Récupère les créneaux disponibles à une date donnée
     */
    public List<Creneau> getCreneauxByDate(Long specialisteId, LocalDateTime date) {
        return creneauDAO.findByMedecinAndDate(specialisteId, date);
    }

    /**
     * Filtre les créneaux par période de la journée
     */
    public List<Creneau> filterByPeriode(List<Creneau> creneaux, String periode) {
        if (periode == null || periode.isEmpty() || periode.equals("all")) {
            return creneaux;
        }

        return creneaux.stream()
            .filter(c -> matchesPeriode(c, periode))
            .collect(Collectors.toList());
    }

    private boolean matchesPeriode(Creneau creneau, String periode) {
        LocalTime heure = creneau.getHeureDebut();

        return switch (periode) {
            case "matin" -> heure.isBefore(LocalTime.of(12, 0));
            case "apres-midi" -> heure.isAfter(LocalTime.of(12, 0)) && heure.isBefore(LocalTime.of(18, 0));
            case "soir" -> heure.isAfter(LocalTime.of(18, 0));
            default -> true;
        };
    }

    /**
     * Compte les créneaux disponibles pour un spécialiste
     */
    public Long countCreneauxDisponibles(Long specialisteId) {
        return creneauDAO.countDisponiblesByMedecin(specialisteId);
    }

    /**
     * Récupère un créneau par son ID
     */
    public Optional<Creneau> findById(Long id) {
        return creneauDAO.findById(id);
    }

    /**
     * Réserve un créneau
     */
    public void reserverCreneau(Long creneauId) {
        creneauDAO.reserver(creneauId);
    }

    /**
     * Crée des créneaux par défaut pour un spécialiste (si besoin pour les tests)
     */
    public void creerCreneauxParDefaut(Long specialisteId) {
        Optional<Medecin> medecinOpt = medecinDAO.findById(specialisteId);

        if (medecinOpt.isEmpty()) {
            throw new IllegalArgumentException("Spécialiste non trouvé");
        }

        Medecin medecin = medecinOpt.get();
        LocalDateTime now = LocalDateTime.now();

        // Créer des créneaux pour les 7 prochains jours
        for (int i = 1; i <= 7; i++) {
            LocalDateTime date = now.plusDays(i);

            // Créneaux du matin (9h-12h)
            creerCreneau(medecin, date, LocalTime.of(9, 0), LocalTime.of(10, 0));
            creerCreneau(medecin, date, LocalTime.of(10, 0), LocalTime.of(11, 0));
            creerCreneau(medecin, date, LocalTime.of(11, 0), LocalTime.of(12, 0));

            // Créneaux de l'après-midi (14h-18h)
            creerCreneau(medecin, date, LocalTime.of(14, 0), LocalTime.of(15, 0));
            creerCreneau(medecin, date, LocalTime.of(15, 0), LocalTime.of(16, 0));
            creerCreneau(medecin, date, LocalTime.of(16, 0), LocalTime.of(17, 0));
            creerCreneau(medecin, date, LocalTime.of(17, 0), LocalTime.of(18, 0));
        }
    }

    private void creerCreneau(Medecin medecin, LocalDateTime date, LocalTime debut, LocalTime fin) {
        LocalDateTime dateCreneau = date.toLocalDate().atTime(debut);
        Creneau creneau = new Creneau(medecin, debut, fin, dateCreneau);
        creneauDAO.save(creneau);
    }
}

