package com.teleexpertise.service;

import com.teleexpertise.dao.MedecinDAO;
import com.teleexpertise.model.Medecin;
import com.teleexpertise.model.Specialite;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class SpécialisteService {

    private final MedecinDAO medecinDAO;

    public SpécialisteService() {
        this.medecinDAO = new MedecinDAO();
    }

    /**
     * Trouve tous les spécialistes par spécialité et les trie par tarif
     */
    public List<Medecin> findBySpecialite(Specialite specialite) {
        return medecinDAO.findBySpecialite(specialite)
                .stream()
                .filter(Medecin::isDisponible)
                .sorted(Comparator.comparing(Medecin::getTarifConsultation))
                .collect(Collectors.toList());
    }

    /**
     * Trouve tous les spécialistes disponibles
     */
    public List<Medecin> findAllSpecialistes() {
        return medecinDAO.findAllSpecialistes()
                .stream()
                .filter(Medecin::isDisponible)
                .collect(Collectors.toList());
    }

    /**
     * Trie les spécialistes par tarif (ordre croissant)
     */
    public List<Medecin> sortByTarif(List<Medecin> specialistes) {
        return specialistes.stream()
                .sorted(Comparator.comparing(Medecin::getTarifConsultation))
                .collect(Collectors.toList());
    }

    /**
     * Trie les spécialistes par tarif (ordre décroissant)
     */
    public List<Medecin> sortByTarifDesc(List<Medecin> specialistes) {
        return specialistes.stream()
                .sorted(Comparator.comparing(Medecin::getTarifConsultation).reversed())
                .collect(Collectors.toList());
    }

    /**
     * Filtre les spécialistes par spécialité à partir d'une liste
     */
    public List<Medecin> filterBySpecialite(List<Medecin> specialistes, Specialite specialite) {
        return specialistes.stream()
                .filter(medecin -> medecin.getSpecialite() == specialite)
                .collect(Collectors.toList());
    }

    /**
     * Filtre les spécialistes par tarif maximum
     */
    public List<Medecin> filterByMaxTarif(List<Medecin> specialistes, double maxTarif) {
        return specialistes.stream()
                .filter(medecin -> medecin.getTarifConsultation() <= maxTarif)
                .collect(Collectors.toList());
    }

    /**
     * Trouve un spécialiste par son ID
     */
    public Medecin findById(Long id) {
        return medecinDAO.findById(id).orElse(null);
    }

    /**
     * Obtient la liste de toutes les spécialités disponibles
     */
    public Specialite[] getAllSpecialites() {
        return Specialite.values();
    }

    /**
     * Compte le nombre de spécialistes par spécialité
     */
    public long countBySpecialite(Specialite specialite) {
        return medecinDAO.findAllSpecialistes()
                .stream()
                .filter(medecin -> medecin.getSpecialite() == specialite)
                .filter(Medecin::isDisponible)
                .count();
    }

    /**
     * Trouve les spécialistes les moins chers par spécialité
     */
    public List<Medecin> findCheapestBySpecialite(Specialite specialite, int limit) {
        return findBySpecialite(specialite)
                .stream()
                .limit(limit)
                .collect(Collectors.toList());
    }
}
