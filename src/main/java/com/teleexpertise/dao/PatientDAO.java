package com.teleexpertise.dao;

import com.teleexpertise.model.Patient;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.util.Optional;

public class PatientDAO {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("teleexpertise-pu");

    public List<Patient> searchByName(String nom) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p WHERE LOWER(p.nom) LIKE LOWER(:nom) OR LOWER(p.prenom) LIKE LOWER(:nom)",
                    Patient.class
            );
            query.setParameter("nom", "%" + nom + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Patient> findByNumeroSecuriteSociale(String numeroSecu) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p WHERE p.numeroSecuriteSociale = :numeroSecu",
                    Patient.class
            );
            query.setParameter("numeroSecu", numeroSecu);
            return Optional.of(query.getSingleResult());
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public List<Patient> searchByNameAndNumeroSecu(String searchTerm) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p WHERE " +
                    "LOWER(p.nom) LIKE LOWER(:searchTerm) OR " +
                    "LOWER(p.prenom) LIKE LOWER(:searchTerm) OR " +
                    "p.numeroSecuriteSociale LIKE :searchTerm",
                    Patient.class
            );
            query.setParameter("searchTerm", "%" + searchTerm + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Patient> findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            Patient patient = em.find(Patient.class, id);
            return Optional.ofNullable(patient);
        } finally {
            em.close();
        }
    }

    public List<Patient> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p", Patient.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Patient> findPatientsEnAttente() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.enAttente = true ORDER BY p.heureArrivee ASC",
                Patient.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void create(Patient patient) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Patient patient) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
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
