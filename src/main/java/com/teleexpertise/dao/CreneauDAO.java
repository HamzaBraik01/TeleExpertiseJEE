package com.teleexpertise.dao;

import com.teleexpertise.model.Creneau;
import com.teleexpertise.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class CreneauDAO {

    public Optional<Creneau> findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Creneau creneau = em.find(Creneau.class, id);
            return Optional.ofNullable(creneau);
        } finally {
            em.close();
        }
    }

    public List<Creneau> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Creneau> query = em.createQuery(
                "SELECT c FROM Creneau c JOIN FETCH c.medecin m JOIN FETCH m.user",
                Creneau.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouve tous les créneaux disponibles pour un médecin spécialiste
     */
    public List<Creneau> findByMedecinAndDisponible(Long medecinId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Creneau> query = em.createQuery(
                "SELECT c FROM Creneau c JOIN FETCH c.medecin m JOIN FETCH m.user " +
                "WHERE m.id = :medecinId AND c.disponible = true AND c.reserve = false " +
                "AND c.dateCreneau > :now " +
                "ORDER BY c.dateCreneau ASC, c.heureDebut ASC",
                Creneau.class);
            query.setParameter("medecinId", medecinId);
            query.setParameter("now", LocalDateTime.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouve les créneaux disponibles d'un médecin à une date donnée
     */
    public List<Creneau> findByMedecinAndDate(Long medecinId, LocalDateTime date) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            LocalDateTime startOfDay = date.toLocalDate().atStartOfDay();
            LocalDateTime endOfDay = date.toLocalDate().atTime(23, 59, 59);

            TypedQuery<Creneau> query = em.createQuery(
                "SELECT c FROM Creneau c JOIN FETCH c.medecin m JOIN FETCH m.user " +
                "WHERE m.id = :medecinId " +
                "AND c.dateCreneau BETWEEN :startOfDay AND :endOfDay " +
                "AND c.disponible = true AND c.reserve = false " +
                "ORDER BY c.heureDebut ASC",
                Creneau.class);
            query.setParameter("medecinId", medecinId);
            query.setParameter("startOfDay", startOfDay);
            query.setParameter("endOfDay", endOfDay);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouve tous les créneaux d'un médecin (disponibles et réservés)
     */
    public List<Creneau> findByMedecin(Long medecinId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Creneau> query = em.createQuery(
                "SELECT c FROM Creneau c JOIN FETCH c.medecin m JOIN FETCH m.user " +
                "WHERE m.id = :medecinId " +
                "ORDER BY c.dateCreneau ASC, c.heureDebut ASC",
                Creneau.class);
            query.setParameter("medecinId", medecinId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Compte les créneaux disponibles pour un médecin
     */
    public Long countDisponiblesByMedecin(Long medecinId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(c) FROM Creneau c " +
                "WHERE c.medecin.id = :medecinId " +
                "AND c.disponible = true AND c.reserve = false " +
                "AND c.dateCreneau > :now",
                Long.class);
            query.setParameter("medecinId", medecinId);
            query.setParameter("now", LocalDateTime.now());
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public void save(Creneau creneau) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (creneau.getId() == null) {
                em.persist(creneau);
            } else {
                em.merge(creneau);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Creneau creneau = em.find(Creneau.class, id);
            if (creneau != null) {
                em.remove(creneau);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    /**
     * Réserve un créneau
     */
    public void reserver(Long creneauId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Creneau creneau = em.find(Creneau.class, creneauId);
            if (creneau != null && creneau.isDisponiblePourReservation()) {
                creneau.reserver();
                em.merge(creneau);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    /**
     * Libère un créneau
     */
    public void liberer(Long creneauId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Creneau creneau = em.find(Creneau.class, creneauId);
            if (creneau != null) {
                creneau.liberer();
                em.merge(creneau);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}

