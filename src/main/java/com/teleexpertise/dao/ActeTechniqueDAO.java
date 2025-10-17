package com.teleexpertise.dao;

import com.teleexpertise.model.ActeTechnique;
import com.teleexpertise.model.Consultation;
import com.teleexpertise.model.TypeActeTechnique;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ActeTechniqueDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("teleexpertise-pu");

    public void save(ActeTechnique acteTechnique) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            if (acteTechnique.getId() == null) {
                em.persist(acteTechnique);
            } else {
                em.merge(acteTechnique);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de l'acte technique", e);
        } finally {
            em.close();
        }
    }

    public ActeTechnique findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a " +
                "LEFT JOIN FETCH a.realisePar " +
                "LEFT JOIN FETCH a.consultation c " +
                "LEFT JOIN FETCH c.medecin " +
                "WHERE a.id = :id",
                ActeTechnique.class);
            query.setParameter("id", id);
            List<ActeTechnique> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public List<ActeTechnique> findByConsultation(Consultation consultation) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a " +
                "LEFT JOIN FETCH a.realisePar u " +
                "LEFT JOIN FETCH a.consultation c " +
                "WHERE a.consultation = :consultation ORDER BY a.dateRealisation DESC",
                ActeTechnique.class);
            query.setParameter("consultation", consultation);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<ActeTechnique> findByType(TypeActeTechnique type) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a WHERE a.type = :type ORDER BY a.dateRealisation DESC",
                ActeTechnique.class);
            query.setParameter("type", type);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(ActeTechnique acteTechnique) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(acteTechnique);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de l'acte technique", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            ActeTechnique acteTechnique = em.find(ActeTechnique.class, id);
            if (acteTechnique != null) {
                em.remove(acteTechnique);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de l'acte technique", e);
        } finally {
            em.close();
        }
    }

    public Double getCoutTotalByConsultation(Consultation consultation) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Double> query = em.createQuery(
                "SELECT COALESCE(SUM(a.cout), 0.0) FROM ActeTechnique a WHERE a.consultation = :consultation",
                Double.class);
            query.setParameter("consultation", consultation);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
