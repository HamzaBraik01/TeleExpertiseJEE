package com.teleexpertise.service;

import com.teleexpertise.model.User;
import com.teleexpertise.dao.UserDAO;
import com.teleexpertise.util.PasswordUtil;

import java.time.LocalDateTime;
import java.util.Optional;

public class AuthService {

    private final UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }


    public Optional<User> authenticate(String username, String password) {
        if (username == null || password == null) {
            return Optional.empty();
        }

        // Recherche par username
        Optional<User> userOpt = userDAO.findByUsername(username);

        // Si pas trouvé par username, essayer par email
        if (userOpt.isEmpty()) {
            userOpt = userDAO.findByEmail(username);
        }

        // Vérifier le mot de passe
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (PasswordUtil.checkPassword(password, user.getPassword())) {
                user.setLastLogin(LocalDateTime.now());
                userDAO.update(user);
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }


    public User register(User user, String plainPassword) {
        if (userDAO.existsByUsername(user.getUsername())) {
            throw new IllegalArgumentException("Ce nom d'utilisateur existe déjà");
        }

        if (userDAO.existsByEmail(user.getEmail())) {
            throw new IllegalArgumentException("Cet email est déjà utilisé");
        }

        if (!PasswordUtil.isPasswordStrong(plainPassword)) {
            throw new IllegalArgumentException(
                    "Le mot de passe doit contenir au moins 8 caractères, " +
                            "une majuscule, une minuscule, un chiffre et un caractère spécial"
            );
        }

        user.setPassword(PasswordUtil.hashPassword(plainPassword));
        user.setActive(true);

        return userDAO.save(user);
    }


    public boolean changePassword(Long userId, String oldPassword, String newPassword) {
        Optional<User> userOpt = userDAO.findById(userId);

        if (userOpt.isEmpty()) {
            return false;
        }

        User user = userOpt.get();

        if (!PasswordUtil.checkPassword(oldPassword, user.getPassword())) {
            return false;
        }

        if (!PasswordUtil.isPasswordStrong(newPassword)) {
            throw new IllegalArgumentException("Le nouveau mot de passe n'est pas assez fort");
        }

        user.setPassword(PasswordUtil.hashPassword(newPassword));
        userDAO.update(user);

        return true;
    }

    public Optional<User> getUserById(Long id) {
        return userDAO.findById(id);
    }
}
