package com.teleexpertise.servlet;

import com.teleexpertise.dao.MedecinDAO;
import com.teleexpertise.model.Creneau;
import com.teleexpertise.model.Medecin;
import com.teleexpertise.model.User;
import com.teleexpertise.service.CreneauService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@WebServlet("/generaliste/creneaux")
public class CreneauServlet extends HttpServlet {

    private CreneauService creneauService;
    private MedecinDAO medecinDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.creneauService = new CreneauService();
        this.medecinDAO = new MedecinDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        String specialisteIdParam = request.getParameter("specialisteId");

        if (specialisteIdParam == null || specialisteIdParam.trim().isEmpty()) {
            request.setAttribute("error", "ID du spécialiste manquant");
            response.sendRedirect(request.getContextPath() + "/generaliste/specialistes");
            return;
        }

        try {
            Long specialisteId = Long.parseLong(specialisteIdParam);

            if ("filter".equals(action)) {
                handleFilterCreneaux(request, response, specialisteId);
            } else if ("generer".equals(action)) {
                handleGenererCreneaux(request, response, specialisteId);
            } else {
                handleListCreneaux(request, response, specialisteId);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID du spécialiste invalide");
            response.sendRedirect(request.getContextPath() + "/generaliste/specialistes");
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur s'est produite : " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/generaliste/specialistes");
        }
    }

    private void handleListCreneaux(HttpServletRequest request, HttpServletResponse response,
                                    Long specialisteId) throws ServletException, IOException {

        // Récupérer le spécialiste
        Optional<Medecin> specialisteOpt = medecinDAO.findById(specialisteId);

        if (specialisteOpt.isEmpty()) {
            request.setAttribute("error", "Spécialiste non trouvé");
            response.sendRedirect(request.getContextPath() + "/generaliste/specialistes");
            return;
        }

        Medecin specialiste = specialisteOpt.get();

        // Récupérer les créneaux disponibles
        List<Creneau> creneaux = creneauService.getCreneauxDisponibles(specialisteId);

        // Si aucun créneau n'existe, proposer d'en générer
        if (creneaux.isEmpty()) {
            Long countTotal = creneauService.countCreneauxDisponibles(specialisteId);
            if (countTotal == 0) {
                request.setAttribute("noCreneaux", true);
                request.setAttribute("info",
                    "Aucun créneau n'est disponible pour ce spécialiste. " +
                    "Vous pouvez générer des créneaux de test pour la démonstration.");
            }
        }

        request.setAttribute("specialiste", specialiste);
        request.setAttribute("creneaux", creneaux);
        request.setAttribute("selectedPeriode", "all");
        request.setAttribute("selectedDate", "");

        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/creneaux.jsp")
                .forward(request, response);
    }

    private void handleFilterCreneaux(HttpServletRequest request, HttpServletResponse response,
                                     Long specialisteId) throws ServletException, IOException {

        Optional<Medecin> specialisteOpt = medecinDAO.findById(specialisteId);

        if (specialisteOpt.isEmpty()) {
            request.setAttribute("error", "Spécialiste non trouvé");
            response.sendRedirect(request.getContextPath() + "/generaliste/specialistes");
            return;
        }

        Medecin specialiste = specialisteOpt.get();
        String periode = request.getParameter("periode");
        String dateParam = request.getParameter("date");

        List<Creneau> creneaux;

        // Filtrer par date si spécifiée
        if (dateParam != null && !dateParam.trim().isEmpty()) {
            try {
                LocalDateTime date = LocalDateTime.parse(dateParam + "T00:00:00");
                creneaux = creneauService.getCreneauxByDate(specialisteId, date);
            } catch (Exception e) {
                creneaux = creneauService.getCreneauxDisponibles(specialisteId);
                request.setAttribute("error", "Format de date invalide");
            }
        } else {
            creneaux = creneauService.getCreneauxDisponibles(specialisteId);
        }

        // Filtrer par période (matin, après-midi, soir)
        if (periode != null && !periode.isEmpty()) {
            creneaux = creneauService.filterByPeriode(creneaux, periode);
        }

        request.setAttribute("specialiste", specialiste);
        request.setAttribute("creneaux", creneaux);
        request.setAttribute("selectedPeriode", periode != null ? periode : "all");
        request.setAttribute("selectedDate", dateParam != null ? dateParam : "");

        if (creneaux.isEmpty()) {
            request.setAttribute("info",
                String.format("%d créneau(x) trouvé(s) pour les critères sélectionnés", creneaux.size()));
        } else {
            request.setAttribute("success",
                String.format("%d créneau(x) disponible(s)", creneaux.size()));
        }

        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/creneaux.jsp")
                .forward(request, response);
    }

    private void handleGenererCreneaux(HttpServletRequest request, HttpServletResponse response,
                                      Long specialisteId) throws ServletException, IOException {

        try {
            // Générer des créneaux par défaut pour les tests
            creneauService.creerCreneauxParDefaut(specialisteId);

            request.setAttribute("success",
                "Créneaux générés avec succès pour les 7 prochains jours !");

            // Rediriger vers la liste des créneaux
            response.sendRedirect(request.getContextPath() +
                "/generaliste/creneaux?specialisteId=" + specialisteId);

        } catch (Exception e) {
            request.setAttribute("error",
                "Erreur lors de la génération des créneaux : " + e.getMessage());
            handleListCreneaux(request, response, specialisteId);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
