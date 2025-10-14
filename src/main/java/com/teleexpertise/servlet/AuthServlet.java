package com.teleexpertise.servlet;

import com.teleexpertise.model.Role;
import com.teleexpertise.model.User;
import com.teleexpertise.service.AuthService;
import com.teleexpertise.util.CSRFUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet(urlPatterns = {"/auth/login", "/auth/logout"})
public class AuthServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        this.authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/auth/logout".equals(path)) {
            handleLogout(req, resp);
        } else {
            showLoginPage(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/auth/login".equals(path)) {
            handleLogin(req, resp);
        }
    }


    private void showLoginPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Vérifier si l'utilisateur est déjà connecté
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            resp.sendRedirect(req.getContextPath() + getDashboardPath(user.getRole()));
            return;
        }

        session = req.getSession(true);
        String csrfToken = CSRFUtil.generateToken(session);
        req.setAttribute("csrfToken", csrfToken);

        req.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(req, resp);
    }


    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Validation CSRF
        if (!CSRFUtil.validateToken(req)) {
            req.setAttribute("error", "Token de sécurité invalide. Veuillez réessayer.");
            showLoginPage(req, resp);
            return;
        }

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Veuillez remplir tous les champs");
            showLoginPage(req, resp);
            return;
        }

        Optional<User> userOpt = authService.authenticate(username.trim(), password);

        if (userOpt.isPresent()) {
            User user = userOpt.get();

            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession newSession = req.getSession(true);

            // Stocker l'utilisateur en session
            newSession.setAttribute("user", user);
            newSession.setAttribute("userId", user.getId());
            newSession.setAttribute("userRole", user.getRole());
            newSession.setAttribute("username", user.getUsername());

            CSRFUtil.generateToken(newSession);

            newSession.setMaxInactiveInterval(30 * 60);

            String redirectPath = getDashboardPath(user.getRole());
            resp.sendRedirect(req.getContextPath() + redirectPath);

        } else {
            req.setAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
            req.setAttribute("username", username);
            showLoginPage(req, resp);
        }
    }


    private void handleLogout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            CSRFUtil.removeToken(session);

            session.invalidate();
        }

        resp.sendRedirect(req.getContextPath() + "/auth/login");
    }


    private String getDashboardPath(Role role) {
        switch (role) {
            case INFIRMIER:
                return "/infirmier/dashboard";
            case GENERALISTE:
                return "/generaliste/dashboard";
            case SPECIALISTE:
                return "/specialiste/dashboard";
            default:
                return "/auth/login";
        }
    }
}