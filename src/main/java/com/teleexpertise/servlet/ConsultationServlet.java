package com.teleexpertise.servlet;

import com.teleexpertise.dao.ActeTechniqueDAO;
import com.teleexpertise.dao.ConsultationDAO;
import com.teleexpertise.dao.PatientDAO;
import com.teleexpertise.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@WebServlet({"/consultation", "/generaliste/consultation"})
public class ConsultationServlet extends HttpServlet {

    private ConsultationDAO consultationDAO;
    private ActeTechniqueDAO acteTechniqueDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        consultationDAO = new ConsultationDAO();
        acteTechniqueDAO = new ActeTechniqueDAO();
        patientDAO = new PatientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User medecin = (User) session.getAttribute("user");

        if (medecin == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "list") {
                case "nouvelle":
                    afficherNouvelleConsultation(request, response);
                    break;
                case "details":
                    afficherDetailsConsultation(request, response, medecin);
                    break;
                case "actes":
                    gererActesTechniques(request, response, medecin);
                    break;
                default:
                    afficherListeConsultations(request, response, medecin);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/consultations.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User medecin = (User) session.getAttribute("user");

        if (medecin == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "creer":
                    creerConsultation(request, response, medecin);
                    break;
                case "rechercher":
                    rechercherPatients(request, response);
                    break;
                case "modifier":
                    modifierConsultation(request, response, medecin);
                    break;
                case "ajouter-acte":
                    ajouterActeTechnique(request, response, medecin);
                    break;
                case "supprimer-acte":
                    supprimerActeTechnique(request, response, medecin);
                    break;
                case "terminer":
                    terminerConsultation(request, response, medecin);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void afficherListeConsultations(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        List<Consultation> consultations = consultationDAO.findByMedecin(medecin);
        List<Patient> patientsEnAttente = patientDAO.findPatientsEnAttente();

        request.setAttribute("consultations", consultations);
        request.setAttribute("patientsEnAttente", patientsEnAttente);
        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/consultations.jsp").forward(request, response);
    }

    private void afficherNouvelleConsultation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String patientIdParam = request.getParameter("patientId");

        if (patientIdParam != null && !patientIdParam.isEmpty()) {
            // Un patient a été sélectionné depuis la liste
            try {
                Long patientId = Long.parseLong(patientIdParam);
                Optional<Patient> patientOpt = patientDAO.findById(patientId);

                if (patientOpt.isPresent()) {
                    Patient patient = patientOpt.get();
                    // Vérifier que le patient est bien en attente
                    if (patient.isEnAttente()) {
                        request.setAttribute("patient", patient);
                    } else {
                        request.setAttribute("error", "Ce patient n'est plus en attente de consultation.");
                    }
                } else {
                    request.setAttribute("error", "Patient non trouvé.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Identifiant patient invalide.");
            }
        }

        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp").forward(request, response);
    }

    private void afficherDetailsConsultation(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        Long consultationId = Long.parseLong(request.getParameter("id"));
        // Utiliser findByIdWithActes pour charger tous les actes techniques
        Consultation consultation = consultationDAO.findByIdWithActes(consultationId);

        if (consultation == null || !consultation.getMedecin().getId().equals(medecin.getId())) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Consultation non trouvée");
            return;
        }

        List<ActeTechnique> actesTechniques = acteTechniqueDAO.findByConsultation(consultation);
        List<TypeActeTechnique> typesActes = Arrays.asList(TypeActeTechnique.values());

        request.setAttribute("consultation", consultation);
        request.setAttribute("actesTechniques", actesTechniques);
        request.setAttribute("typesActes", typesActes);
        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/details-consultation.jsp").forward(request, response);
    }

    private void creerConsultation(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        Long patientId = Long.parseLong(request.getParameter("patientId"));
        String motif = request.getParameter("motif");
        String observations = request.getParameter("observations");

        Optional<Patient> patientOpt = patientDAO.findById(patientId);
        if (!patientOpt.isPresent()) {
            throw new RuntimeException("Patient non trouvé");
        }

        Patient patient = patientOpt.get();

        // Créer la consultation avec coût fixe de 150 DH (déjà défini par défaut dans le modèle)
        Consultation consultation = new Consultation(patient, medecin, motif);
        consultation.setObservations(observations);
        consultation.setStatut(StatutConsultation.EN_COURS);
        // Le coût de 150 DH est déjà défini par défaut dans le modèle

        consultationDAO.save(consultation);

        // Mettre le patient hors de la liste d'attente
        patient.setEnAttente(false);
        patient.setStatut("EN_CONSULTATION");
        patientDAO.update(patient);

        // Rediriger vers les détails de la consultation
        response.sendRedirect("consultation?action=details&id=" + consultation.getId());
    }

    private void modifierConsultation(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        Long consultationId = Long.parseLong(request.getParameter("consultationId"));
        Consultation consultation = consultationDAO.findById(consultationId);

        if (consultation == null || !consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new RuntimeException("Consultation non trouvée ou non autorisée");
        }

        consultation.setMotif(request.getParameter("motif"));
        consultation.setObservations(request.getParameter("observations"));
        consultation.setExamenClinique(request.getParameter("examenClinique"));
        consultation.setAnalyseSymptomes(request.getParameter("analyseSymptomes"));
        consultation.setDiagnostic(request.getParameter("diagnostic"));
        consultation.setTraitement(request.getParameter("traitement"));

        consultationDAO.update(consultation);

        response.sendRedirect("consultation?action=details&id=" + consultationId);
    }

    private void ajouterActeTechnique(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        Long consultationId = Long.parseLong(request.getParameter("consultationId"));
        Consultation consultation = consultationDAO.findById(consultationId);

        if (consultation == null || !consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new RuntimeException("Consultation non trouvée ou non autorisée");
        }

        TypeActeTechnique type = TypeActeTechnique.valueOf(request.getParameter("typeActe"));
        String coutStr = request.getParameter("cout");
        Double cout = (coutStr != null && !coutStr.isEmpty()) ? Double.parseDouble(coutStr) : type.getCoutStandard();
        String description = request.getParameter("description");

        ActeTechnique acte = new ActeTechnique(consultation, type, medecin);
        acte.setCout(cout);
        acte.setDescription(description);

        acteTechniqueDAO.save(acte);

        // Rediriger vers la page des actes techniques au lieu des détails
        response.sendRedirect("consultation?action=actes&consultationId=" + consultationId);
    }

    private void supprimerActeTechnique(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        Long acteId = Long.parseLong(request.getParameter("acteId"));
        Long consultationId = Long.parseLong(request.getParameter("consultationId"));

        ActeTechnique acte = acteTechniqueDAO.findById(acteId);

        if (acte == null) {
            throw new RuntimeException("Acte technique non trouvé");
        }

        // Vérifier que l'acte appartient à la consultation du médecin
        Consultation consultation = acte.getConsultation();
        if (!consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new RuntimeException("Accès non autorisé à cet acte technique");
        }

        acteTechniqueDAO.delete(acteId);

        // Rediriger vers la page des actes techniques
        response.sendRedirect("consultation?action=actes&consultationId=" + consultationId);
    }

    private void terminerConsultation(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        Long consultationId = Long.parseLong(request.getParameter("consultationId"));
        Consultation consultation = consultationDAO.findById(consultationId);

        if (consultation == null || !consultation.getMedecin().getId().equals(medecin.getId())) {
            throw new RuntimeException("Consultation non trouvée ou non autorisée");
        }

        consultation.cloturer();
        consultation.setDateCloture(LocalDateTime.now());
        consultationDAO.update(consultation);

        // Mettre à jour le statut du patient
        Patient patient = consultation.getPatient();
        patient.setStatut("CONSULTATION_TERMINEE");
        patientDAO.update(patient);

        response.sendRedirect("consultation?action=list");
    }

    private void gererActesTechniques(HttpServletRequest request, HttpServletResponse response, User medecin)
            throws ServletException, IOException {

        String consultationIdParam = request.getParameter("consultationId");
        System.out.println("DEBUG: consultationId reçu = " + consultationIdParam);

        if (consultationIdParam == null || consultationIdParam.trim().isEmpty()) {
            System.out.println("ERROR: consultationId manquant");
            request.setAttribute("error", "ID de consultation manquant");
            afficherListeConsultations(request, response, medecin);
            return;
        }

        try {
            Long consultationId = Long.parseLong(consultationIdParam);
            System.out.println("DEBUG: Recherche consultation avec ID = " + consultationId);

            // Utiliser findByIdWithActes pour charger tous les actes techniques
            Consultation consultation = consultationDAO.findByIdWithActes(consultationId);

            if (consultation == null) {
                System.out.println("ERROR: Consultation non trouvée pour ID = " + consultationId);
                request.setAttribute("error", "Consultation non trouvée");
                afficherListeConsultations(request, response, medecin);
                return;
            }

            System.out.println("DEBUG: Consultation trouvée - Patient: " + consultation.getPatient().getPrenom() + " " + consultation.getPatient().getNom());

            if (!consultation.getMedecin().getId().equals(medecin.getId())) {
                System.out.println("ERROR: Médecin non autorisé");
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès non autorisé à cette consultation");
                return;
            }

            List<ActeTechnique> actesTechniques = acteTechniqueDAO.findByConsultation(consultation);
            List<TypeActeTechnique> typesActes = Arrays.asList(TypeActeTechnique.values());

            System.out.println("DEBUG: " + actesTechniques.size() + " actes trouvés");
            System.out.println("DEBUG: " + typesActes.size() + " types d'actes disponibles");

            // Ajouter l'utilisateur connecté pour éviter l'erreur dans la JSP
            request.setAttribute("user", medecin);
            request.setAttribute("consultation", consultation);
            request.setAttribute("actesTechniques", actesTechniques);
            request.setAttribute("typesActes", typesActes);

            System.out.println("DEBUG: Redirection vers actes-techniques.jsp");
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/actes-techniques.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("ERROR: ID consultation invalide = " + consultationIdParam);
            request.setAttribute("error", "ID de consultation invalide");
            afficherListeConsultations(request, response, medecin);
        } catch (Exception e) {
            System.out.println("ERROR: Exception dans gererActesTechniques = " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des actes techniques: " + e.getMessage());
            afficherListeConsultations(request, response, medecin);
        }
    }

    private void rechercherPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("searchTerm");

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Rechercher par nom, prénom ou numéro de sécurité sociale
            List<Patient> patientsEnAttente = patientDAO.searchByNameAndNumeroSecu(searchTerm.trim());
            // Filtrer seulement les patients en attente
            patientsEnAttente = patientsEnAttente.stream()
                .filter(Patient::isEnAttente)
                .collect(java.util.stream.Collectors.toList());

            request.setAttribute("patientsEnAttente", patientsEnAttente);
        }

        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp").forward(request, response);
    }
}
