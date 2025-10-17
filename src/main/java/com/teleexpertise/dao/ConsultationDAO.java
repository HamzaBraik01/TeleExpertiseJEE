package com.teleexpertise.dao;

import com.teleexpertise.model.Consultation;
import com.teleexpertise.model.Patient;
import com.teleexpertise.model.StatutConsultation;
import com.teleexpertise.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ConsultationDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("teleexpertise-pu");

    public void save(Consultation consultation) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            if (consultation.getId() == null) {
                em.persist(consultation);
            } else {
                em.merge(consultation);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de la consultation", e);
        } finally {
            em.close();
        }
    }

    public Consultation findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c " +
                "LEFT JOIN FETCH c.patient " +
                "LEFT JOIN FETCH c.medecin " +
                "WHERE c.id = :id",
                Consultation.class);
            query.setParameter("id", id);
            List<Consultation> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public Consultation findByIdWithActes(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT DISTINCT c FROM Consultation c " +
                "LEFT JOIN FETCH c.patient " +
                "LEFT JOIN FETCH c.medecin " +
                "LEFT JOIN FETCH c.actesTechniques a " +
                "LEFT JOIN FETCH a.realisePar u " +
                "WHERE c.id = :id",
                Consultation.class);
            query.setParameter("id", id);
            List<Consultation> results = query.getResultList();

            if (!results.isEmpty()) {
                Consultation consultation = results.get(0);
                // Forcer l'initialisation des collections paresseuses
                consultation.getActesTechniques().size();
                return consultation;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByMedecin(User medecin) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT DISTINCT c FROM Consultation c " +
                "LEFT JOIN FETCH c.patient " +
                "LEFT JOIN FETCH c.actesTechniques " +
                "WHERE c.medecin = :medecin ORDER BY c.dateConsultation DESC",
                Consultation.class);
            query.setParameter("medecin", medecin);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByPatient(Patient patient) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.patient = :patient ORDER BY c.dateConsultation DESC",
                Consultation.class);
            query.setParameter("patient", patient);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByStatut(StatutConsultation statut) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.statut = :statut ORDER BY c.dateConsultation DESC",
                Consultation.class);
            query.setParameter("statut", statut);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Consultation consultation) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(consultation);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de la consultation", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Consultation consultation = em.find(Consultation.class, id);
            if (consultation != null) {
                em.remove(consultation);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de la consultation", e);
        } finally {
            em.close();
        }
    }
}
