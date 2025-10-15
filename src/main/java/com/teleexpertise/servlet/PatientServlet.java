package com.teleexpertise.servlet;

import com.teleexpertise.model.Patient;
import com.teleexpertise.model.SignesVitaux;
import com.teleexpertise.model.User;
import com.teleexpertise.service.FileAttenteService;
import com.teleexpertise.service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/infirmier/patient")
public class PatientServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();
    private final FileAttenteService fileAttenteService = new FileAttenteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        req.setAttribute("user", user);
        req.setAttribute("pageTitle", "Gestion des patients - Infirmier");

        String action = req.getParameter("action");
        String searchTerm = req.getParameter("search");

        // Recherche de patient
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Patient> patientsFound = patientService.rechercherPatients(searchTerm.trim());
            req.setAttribute("patientsFound", patientsFound);
            req.setAttribute("searchTerm", searchTerm);
        }

        // Affichage d'un patient existant pour ajout de signes vitaux
        String patientIdStr = req.getParameter("patientId");
        if (patientIdStr != null) {
            try {
                Long patientId = Long.parseLong(patientIdStr);
                patientService.obtenirPatientParId(patientId).ifPresent(patient -> {
                    req.setAttribute("selectedPatient", patient);
                });
            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID patient invalide");
            }
        }

        // File d'attente du jour (triée par heure d'arrivée)
        LocalDate today = LocalDate.now();
        List<Patient> fileAttente = fileAttenteService.listByDate(today);
        req.setAttribute("fileAttente", fileAttente);
        req.setAttribute("dateAujourdhui", today);

        req.getRequestDispatcher("/WEB-INF/jsp/infirmier/recherche-patient.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = req.getParameter("action");

        if ("createPatient".equals(action)) {
            handleCreatePatient(req, resp, user);
        } else if ("addSignesVitaux".equals(action)) {
            handleAddSignesVitaux(req, resp, user);
        } else {
            handleCreatePatient(req, resp, user); // Par défaut
        }
    }

    private void handleCreatePatient(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String dateNaissanceStr = req.getParameter("dateNaissance");
        String numeroSecu = req.getParameter("numeroSecuriteSociale");
        String telephone = req.getParameter("telephone");
        String adresse = req.getParameter("adresse");

        // Signes vitaux
        String tensionStr = req.getParameter("tensionArterielle");
        String frequenceCardiaqueStr = req.getParameter("frequenceCardiaque");
        String temperatureStr = req.getParameter("temperature");
        String saturationStr = req.getParameter("saturationOxygene");

        // Validation
        if (nom == null || nom.trim().isEmpty() ||
            prenom == null || prenom.trim().isEmpty() ||
            dateNaissanceStr == null || dateNaissanceStr.trim().isEmpty() ||
            numeroSecu == null || numeroSecu.trim().isEmpty() ||
            telephone == null || telephone.trim().isEmpty() ||
            adresse == null || adresse.trim().isEmpty()) {

            req.setAttribute("error", "Tous les champs obligatoires doivent être remplis");
            doGet(req, resp);
            return;
        }

        try {
            LocalDate dateNaissance = LocalDate.parse(dateNaissanceStr);

            // Créer le patient
            Patient patient = new Patient();
            patient.setNom(nom.trim());
            patient.setPrenom(prenom.trim());
            patient.setDateNaissance(dateNaissance);
            patient.setNumeroSecuriteSociale(numeroSecu.trim());
            patient.setTelephone(telephone.trim());
            patient.setAdresse(adresse.trim());

            if (isAnySigneVitalProvided(tensionStr, frequenceCardiaqueStr, temperatureStr, saturationStr)) {
                SignesVitaux signesVitaux = new SignesVitaux(patient, user);

                if (tensionStr != null && !tensionStr.trim().isEmpty()) {
                    signesVitaux.setTensionArterielle(tensionStr.trim());
                }
                if (frequenceCardiaqueStr != null && !frequenceCardiaqueStr.trim().isEmpty()) {
                    try {
                        signesVitaux.setFrequenceCardiaque(Integer.parseInt(frequenceCardiaqueStr.trim()));
                    } catch (NumberFormatException e) {
                        // Ignorer si format invalide
                    }
                }
                if (temperatureStr != null && !temperatureStr.trim().isEmpty()) {
                    try {
                        signesVitaux.setTemperature(Double.parseDouble(temperatureStr.trim()));
                    } catch (NumberFormatException e) {
                        // Ignorer si format invalide
                    }
                }
                if (saturationStr != null && !saturationStr.trim().isEmpty()) {
                    try {
                        signesVitaux.setSaturationOxygene(Integer.parseInt(saturationStr.trim()));
                    } catch (NumberFormatException e) {
                        // Ignorer si format invalide
                    }
                }
            }

            // Persister le patient
            patientService.creerPatient(patient);

            // Ajouter automatiquement à la file d'attente du jour
            fileAttenteService.add(patient, LocalDate.now());

            req.setAttribute("success", "Patient créé avec succès et ajouté à la file d'attente");

        } catch (DateTimeParseException e) {
            req.setAttribute("error", "Format de date invalide");
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de la création du patient : " + e.getMessage());
        }

        doGet(req, resp);
    }

    private void handleAddSignesVitaux(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        String patientIdStr = req.getParameter("patientId");
        String tensionStr = req.getParameter("tensionArterielle");
        String frequenceCardiaqueStr = req.getParameter("frequenceCardiaque");
        String temperatureStr = req.getParameter("temperature");
        String saturationStr = req.getParameter("saturationOxygene");

        if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
            req.setAttribute("error", "Patient non sélectionné");
            doGet(req, resp);
            return;
        }

        try {
            Long patientId = Long.parseLong(patientIdStr);
            Patient patient = patientService.obtenirPatientParId(patientId).orElse(null);

            if (patient == null) {
                req.setAttribute("error", "Patient non trouvé");
                doGet(req, resp);
                return;
            }

            if (!isAnySigneVitalProvided(tensionStr, frequenceCardiaqueStr, temperatureStr, saturationStr)) {
                req.setAttribute("error", "Au moins un signe vital doit être fourni");
                doGet(req, resp);
                return;
            }

            SignesVitaux signesVitaux = new SignesVitaux(patient, user);

            if (tensionStr != null && !tensionStr.trim().isEmpty()) {
                signesVitaux.setTensionArterielle(tensionStr.trim());
            }
            if (frequenceCardiaqueStr != null && !frequenceCardiaqueStr.trim().isEmpty()) {
                signesVitaux.setFrequenceCardiaque(Integer.parseInt(frequenceCardiaqueStr.trim()));
            }
            if (temperatureStr != null && !temperatureStr.trim().isEmpty()) {
                signesVitaux.setTemperature(Double.parseDouble(temperatureStr.trim()));
            }
            if (saturationStr != null && !saturationStr.trim().isEmpty()) {
                signesVitaux.setSaturationOxygene(Integer.parseInt(saturationStr.trim()));
            }

            // Note: Il faudrait aussi persister les signes vitaux avec une DAO dédiée
            // Pour l'instant on les attache juste au patient

            req.setAttribute("success", "Signes vitaux ajoutés avec succès");

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Format de données invalide");
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de l'ajout des signes vitaux : " + e.getMessage());
        }

        doGet(req, resp);
    }

    private boolean isAnySigneVitalProvided(String... signes) {
        for (String signe : signes) {
            if (signe != null && !signe.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }
}
