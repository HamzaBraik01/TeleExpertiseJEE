package com.teleexpertise.filter;

import com.teleexpertise.model.Role;
import com.teleexpertise.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final List<String> PUBLIC_URLS = Arrays.asList(
            "/auth/login",
            "/assets/",
            "/css/",
            "/js/",
            "/images/"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (isPublicResource(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Si l'utilisateur n'est pas connecté, rediriger vers login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        if (!hasAccess(path, user.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé");
            return;
        }

        resp.setHeader("X-Content-Type-Options", "nosniff");
        resp.setHeader("X-Frame-Options", "DENY");
        resp.setHeader("X-XSS-Protection", "1; mode=block");

        chain.doFilter(request, response);
    }


    private boolean isPublicResource(String path) {
        return PUBLIC_URLS.stream().anyMatch(path::startsWith);
    }


    private boolean hasAccess(String path, Role role) {
        if (path.startsWith("/infirmier/")) {
            return role == Role.INFIRMIER;
        } else if (path.startsWith("/generaliste/")) {
            return role == Role.GENERALISTE;
        } else if (path.startsWith("/specialiste/")) {
            return role == Role.SPECIALISTE;
        }
        return true;
    }
}