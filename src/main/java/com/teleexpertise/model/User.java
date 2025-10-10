package com.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String prenom;

    @Column(unique = true)
    private String email;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "last_login")
    private LocalDateTime lastLogin;

    @Column(name = "is_active")
    private boolean isActive = true;

    public User() {}

    public User(String username, String password, String nom, String prenom, String email, Role role) {
        this.username = username;
        this.password = password;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.role = role;
        this.createdAt = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public String getFullName() {
        return prenom + " " + nom;
    }

}
