package com.teleexpertise.dao;

import com.teleexpertise.model.Medecin;
import com.teleexpertise.model.Role;
import com.teleexpertise.model.Specialite;
import com.teleexpertise.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.Optional;

public class MedecinDAO {

    public Optional<Medecin> findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Medecin> query = em.createQuery(
                "SELECT m FROM Medecin m JOIN FETCH m.user WHERE m.id = :id",
                Medecin.class);
            query.setParameter("id", id);
            List<Medecin> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } finally {
            em.close();
        }
    }

    public List<Medecin> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Medecin> query = em.createQuery(
                "SELECT m FROM Medecin m JOIN FETCH m.user", Medecin.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Medecin> findBySpecialite(Specialite specialite) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Medecin> query = em.createQuery(
                "SELECT m FROM Medecin m JOIN FETCH m.user u " +
                "WHERE m.specialite = :specialite AND u.role = :role AND m.disponible = true",
                Medecin.class);
            query.setParameter("specialite", specialite);
            query.setParameter("role", Role.SPECIALISTE);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Medecin> findAllSpecialistes() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Medecin> query = em.createQuery(
                "SELECT m FROM Medecin m JOIN FETCH m.user u " +
                "WHERE u.role = :role AND m.disponible = true",
                Medecin.class);
            query.setParameter("role", Role.SPECIALISTE);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Medecin> findByUserId(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Medecin> query = em.createQuery(
                "SELECT m FROM Medecin m JOIN FETCH m.user u WHERE u.id = :userId",
                Medecin.class);
            query.setParameter("userId", userId);
            List<Medecin> medecins = query.getResultList();
            return medecins.isEmpty() ? Optional.empty() : Optional.of(medecins.get(0));
        } finally {
            em.close();
        }
    }

    public void save(Medecin medecin) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (medecin.getId() == null) {
                em.persist(medecin);
            } else {
                em.merge(medecin);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Medecin medecin = em.find(Medecin.class, id);
            if (medecin != null) {
                em.remove(medecin);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
