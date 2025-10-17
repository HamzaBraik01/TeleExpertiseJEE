package com.teleexpertise.servlet;

import com.teleexpertise.model.Medecin;
import com.teleexpertise.model.Specialite;
import com.teleexpertise.service.SpécialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/generaliste/specialistes")
public class SpécialisteServlet extends HttpServlet {

    private SpécialisteService specialisteService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.specialisteService = new SpécialisteService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("list")) {
                handleListSpecialistes(request, response);
            } else if (action.equals("search")) {
                handleSearchBySpecialite(request, response);
            } else if (action.equals("details")) {
                handleSpecialisteDetails(request, response);
            } else {
                handleListSpecialistes(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur s'est produite : " + e.getMessage());
            handleListSpecialistes(request, response);
        }
    }

    private void handleListSpecialistes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtenir tous les spécialistes
        List<Medecin> specialistes = specialisteService.findAllSpecialistes();

        // Trier par tarif (ordre croissant)
        specialistes = specialisteService.sortByTarif(specialistes);

        // Obtenir toutes les spécialités pour le filtre
        Specialite[] specialites = specialisteService.getAllSpecialites();

        request.setAttribute("specialistes", specialistes);
        request.setAttribute("specialites", specialites);
        request.setAttribute("selectedSpecialite", "");

        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/specialistes.jsp")
                .forward(request, response);
    }

    private void handleSearchBySpecialite(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String specialiteParam = request.getParameter("specialite");
        String sortOrder = request.getParameter("sort");

        List<Medecin> specialistes;
        Specialite selectedSpecialite = null;

        if (specialiteParam != null && !specialiteParam.trim().isEmpty()) {
            try {
                selectedSpecialite = Specialite.valueOf(specialiteParam);
                specialistes = specialisteService.findBySpecialite(selectedSpecialite);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Spécialité invalide");
                specialistes = specialisteService.findAllSpecialistes();
            }
        } else {
            specialistes = specialisteService.findAllSpecialistes();
        }

        // Appliquer le tri selon l'ordre demandé
        if ("desc".equals(sortOrder)) {
            specialistes = specialisteService.sortByTarifDesc(specialistes);
        } else {
            specialistes = specialisteService.sortByTarif(specialistes);
        }

        // Obtenir toutes les spécialités pour le filtre
        Specialite[] specialites = specialisteService.getAllSpecialites();

        request.setAttribute("specialistes", specialistes);
        request.setAttribute("specialites", specialites);
        request.setAttribute("selectedSpecialite", specialiteParam);
        request.setAttribute("sortOrder", sortOrder);

        if (selectedSpecialite != null) {
            request.setAttribute("success",
                String.format("%d spécialiste(s) trouvé(s) en %s",
                    specialistes.size(), selectedSpecialite.getNom()));
        }

        request.getRequestDispatcher("/WEB-INF/jsp/generaliste/specialistes.jsp")
                .forward(request, response);
    }

    private void handleSpecialisteDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            request.setAttribute("error", "ID du spécialiste manquant");
            handleListSpecialistes(request, response);
            return;
        }

        try {
            Long specialisteId = Long.parseLong(idParam);
            Medecin specialiste = specialisteService.findById(specialisteId);

            if (specialiste == null) {
                request.setAttribute("error", "Spécialiste non trouvé");
                handleListSpecialistes(request, response);
                return;
            }

            request.setAttribute("specialiste", specialiste);
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/specialiste-details.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID du spécialiste invalide");
            handleListSpecialistes(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
