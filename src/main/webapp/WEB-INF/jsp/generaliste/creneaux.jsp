<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créneaux Disponibles - TéléExpertise</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .creneau-card {
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }
        .creneau-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .time-badge {
            font-size: 1.2rem;
            padding: 0.5rem 1rem;
        }
        .date-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">TéléExpertise</a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">Dr. ${user.prenom} ${user.nom}</span>
                <a class="nav-link" href="${pageContext.request.contextPath}/generaliste/consultation">Consultations</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/generaliste/specialistes">Spécialistes</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <!-- En-tête -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2><i class="fas fa-calendar-alt"></i> Créneaux Disponibles</h2>
                        <p class="text-muted mb-0">
                            Dr. ${specialiste.user.prenom} ${specialiste.user.nom} - ${specialiste.specialite.nom}
                        </p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/generaliste/specialistes?action=details&id=${specialiste.id}"
                           class="btn btn-outline-primary me-2">
                            <i class="fas fa-user-md"></i> Profil du Spécialiste
                        </a>
                        <a href="${pageContext.request.contextPath}/generaliste/specialistes"
                           class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Retour à la liste
                        </a>
                    </div>
                </div>

                <!-- Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty info}">
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <i class="fas fa-info-circle"></i> ${info}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Filtres -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-filter"></i> Filtrer les Créneaux</h5>
                    </div>
                    <div class="card-body">
                        <form method="GET" action="creneaux">
                            <input type="hidden" name="action" value="filter">
                            <input type="hidden" name="specialisteId" value="${specialiste.id}">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="date" class="form-label">Date</label>
                                    <input type="date" class="form-control" id="date" name="date"
                                           value="${selectedDate}">
                                </div>
                                <div class="col-md-4">
                                    <label for="periode" class="form-label">Période de la journée</label>
                                    <select class="form-select" id="periode" name="periode">
                                        <option value="all" ${selectedPeriode == 'all' ? 'selected' : ''}>Toute la journée</option>
                                        <option value="matin" ${selectedPeriode == 'matin' ? 'selected' : ''}>Matin (8h-12h)</option>
                                        <option value="apres-midi" ${selectedPeriode == 'apres-midi' ? 'selected' : ''}>Après-midi (12h-18h)</option>
                                        <option value="soir" ${selectedPeriode == 'soir' ? 'selected' : ''}>Soir (18h-20h)</option>
                                    </select>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary me-2">
                                        <i class="fas fa-search"></i> Filtrer
                                    </button>
                                    <a href="creneaux?specialisteId=${specialiste.id}" class="btn btn-outline-secondary">
                                        <i class="fas fa-times"></i> Réinitialiser
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Génération de créneaux (si aucun créneau) -->
                <c:if test="${noCreneaux}">
                    <div class="card border-warning mb-4">
                        <div class="card-header bg-warning text-dark">
                            <h5 class="mb-0"><i class="fas fa-exclamation-triangle"></i> Aucun Créneau Disponible</h5>
                        </div>
                        <div class="card-body">
                            <p class="mb-3">Ce spécialiste n'a pas encore de créneaux disponibles dans le système.</p>
                            <p class="text-muted mb-3">
                                <small>Pour faciliter les tests, vous pouvez générer automatiquement des créneaux
                                pour les 7 prochains jours (9h-12h et 14h-18h).</small>
                            </p>
                            <a href="creneaux?action=generer&specialisteId=${specialiste.id}"
                               class="btn btn-warning"
                               onclick="return confirm('Générer des créneaux de test pour ce spécialiste ?')">
                                <i class="fas fa-magic"></i> Générer des Créneaux de Test
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- Liste des créneaux -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-clock"></i> Créneaux Disponibles
                            <span class="badge bg-light text-dark ms-2">${fn:length(creneaux)}</span>
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty creneaux && !noCreneaux}">
                                <div class="text-center py-5">
                                    <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
                                    <p class="text-muted">Aucun créneau disponible pour les critères sélectionnés.</p>
                                    <a href="creneaux?specialisteId=${specialiste.id}" class="btn btn-outline-primary">
                                        Voir tous les créneaux
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Grouper par date -->
                                <c:set var="currentDate" value="" />
                                <div class="row">
                                    <c:forEach var="creneau" items="${creneaux}">
                                        <jsp:useBean id="creneau" type="com.teleexpertise.model.Creneau"/>

                                        <!-- Afficher l'en-tête de date si changement de jour -->
                                        <c:set var="creneauDate" value="${creneau.dateCreneau.toLocalDate()}" />
                                        <c:if test="${currentDate != creneauDate}">
                                            <c:if test="${not empty currentDate}">
                                                </div><div class="row">
                                            </c:if>
                                            <div class="col-12 mt-3">
                                                <div class="date-header">
                                                    <h5 class="mb-0">
                                                        <i class="fas fa-calendar-day"></i>
                                                        <fmt:formatDate value="${creneau.dateCreneau}" pattern="EEEE dd MMMM yyyy" />
                                                    </h5>
                                                </div>
                                            </div>
                                            <c:set var="currentDate" value="${creneauDate}" />
                                        </c:if>

                                        <!-- Carte de créneau -->
                                        <div class="col-md-3 mb-3">
                                            <div class="card creneau-card h-100">
                                                <div class="card-body text-center">
                                                    <div class="mb-3">
                                                        <i class="fas fa-clock fa-2x text-primary"></i>
                                                    </div>
                                                    <h5 class="card-title">
                                                        <span class="badge bg-success time-badge">
                                                            <fmt:formatDate value="${creneau.dateCreneau}" pattern="HH:mm" />
                                                        </span>
                                                    </h5>
                                                    <p class="text-muted mb-3">
                                                        ${creneau.heureDebut} - ${creneau.heureFin}
                                                    </p>
                                                    <p class="mb-3">
                                                        <small class="text-muted">
                                                            <i class="fas fa-hourglass-half"></i>
                                                            ${specialiste.dureeConsultation} min
                                                        </small>
                                                    </p>
                                                    <a href="${pageContext.request.contextPath}/generaliste/expertise?action=nouvelle&creneauId=${creneau.id}&specialisteId=${specialiste.id}"
                                                       class="btn btn-primary btn-sm w-100">
                                                        <i class="fas fa-check"></i> Réserver
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Statistiques -->
                                <div class="row mt-4">
                                    <div class="col-md-12">
                                        <div class="card bg-light">
                                            <div class="card-body">
                                                <div class="row text-center">
                                                    <div class="col-md-3">
                                                        <h4 class="text-primary">${fn:length(creneaux)}</h4>
                                                        <small class="text-muted">Créneaux disponibles</small>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <h4 class="text-success">${specialiste.tarifConsultation} DH</h4>
                                                        <small class="text-muted">Tarif par consultation</small>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <h4 class="text-info">${specialiste.dureeConsultation} min</h4>
                                                        <small class="text-muted">Durée moyenne</small>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <h4 class="text-warning">
                                                            <i class="fas fa-star"></i>
                                                        </h4>
                                                        <small class="text-muted">${specialiste.experience}</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Instructions -->
                <div class="card mt-4 border-info">
                    <div class="card-header bg-info text-white">
                        <h6 class="mb-0"><i class="fas fa-info-circle"></i> Instructions</h6>
                    </div>
                    <div class="card-body">
                        <ol class="mb-0">
                            <li>Sélectionnez un créneau disponible en cliquant sur le bouton "Réserver"</li>
                            <li>Vous serez redirigé vers le formulaire de demande d'expertise</li>
                            <li>Remplissez les informations du patient et les détails de la consultation</li>
                            <li>Soumettez votre demande pour confirmation</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

