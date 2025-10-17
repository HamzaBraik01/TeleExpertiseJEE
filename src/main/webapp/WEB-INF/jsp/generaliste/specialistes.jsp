<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche de Spécialistes - TéléExpertise</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">TéléExpertise</a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">Dr. ${user.prenom} ${user.nom}</span>
                <a class="nav-link" href="${pageContext.request.contextPath}/generaliste/consultation">Consultations</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-user-md"></i> Recherche de Spécialistes</h2>
                    <a href="${pageContext.request.contextPath}/generaliste/consultation" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour aux Consultations
                    </a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Filtres de recherche -->
                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-filter"></i> Filtres de Recherche</h5>
                    </div>
                    <div class="card-body">
                        <form method="GET" action="specialistes">
                            <input type="hidden" name="action" value="search">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="specialite" class="form-label">Spécialité</label>
                                    <select class="form-select" id="specialite" name="specialite">
                                        <option value="">Toutes les spécialités</option>
                                        <c:forEach var="spec" items="${specialites}">
                                            <option value="${spec.name()}"
                                                ${selectedSpecialite == spec.name() ? 'selected' : ''}>
                                                ${spec.nom}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="sort" class="form-label">Trier par tarif</label>
                                    <select class="form-select" id="sort" name="sort">
                                        <option value="asc" ${sortOrder != 'desc' ? 'selected' : ''}>Prix croissant</option>
                                        <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Prix décroissant</option>
                                    </select>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary me-2">
                                        <i class="fas fa-search"></i> Rechercher
                                    </button>
                                    <a href="specialistes" class="btn btn-outline-secondary">
                                        <i class="fas fa-times"></i> Réinitialiser
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Liste des spécialistes -->
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-users"></i>
                            Spécialistes Disponibles
                            <span class="badge bg-light text-dark">${specialistes.size()}</span>
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty specialistes}">
                                <div class="text-center py-4">
                                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">Aucun spécialiste trouvé pour les critères sélectionnés</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Spécialiste</th>
                                                <th>Spécialité</th>
                                                <th>Tarif Consultation</th>
                                                <th>Durée</th>
                                                <th>Expérience</th>
                                                <th>Disponibilité</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="specialiste" items="${specialistes}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                                                 style="width: 40px; height: 40px;">
                                                                <i class="fas fa-user-md"></i>
                                                            </div>
                                                            <div>
                                                                <strong>Dr. ${specialiste.user.prenom} ${specialiste.user.nom}</strong>
                                                                <c:if test="${not empty specialiste.numeroOrdre}">
                                                                    <br><small class="text-muted">N° Ordre: ${specialiste.numeroOrdre}</small>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary">${specialiste.specialite.nom}</span>
                                                        <c:if test="${not empty specialiste.specialite.description}">
                                                            <br><small class="text-muted">${specialiste.specialite.description}</small>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <strong class="text-success">${specialiste.tarifConsultation} DH</strong>
                                                    </td>
                                                    <td>
                                                        ${specialiste.dureeConsultation} min
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty specialiste.experience}">
                                                                ${specialiste.experience}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Non renseignée</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${specialiste.disponible}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check"></i> Disponible
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">
                                                                    <i class="fas fa-times"></i> Indisponible
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="specialistes?action=details&id=${specialiste.id}"
                                                               class="btn btn-sm btn-outline-primary"
                                                               title="Voir les détails">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <c:if test="${specialiste.disponible}">
                                                                <a href="${pageContext.request.contextPath}/generaliste/creneaux?specialisteId=${specialiste.id}"
                                                                   class="btn btn-sm btn-success"
                                                                   title="Voir créneaux disponibles">
                                                                    <i class="fas fa-calendar"></i> Créneaux
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Statistiques -->
                <c:if test="${not empty specialistes}">
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="card bg-light">
                                <div class="card-body">
                                    <div class="row text-center">
                                        <div class="col-md-3">
                                            <h5 class="text-primary">${specialistes.size()}</h5>
                                            <small class="text-muted">Spécialistes trouvés</small>
                                        </div>
                                        <div class="col-md-3">
                                            <h5 class="text-success">
                                                <c:set var="minTarif" value="999999"/>
                                                <c:forEach var="s" items="${specialistes}">
                                                    <c:if test="${s.tarifConsultation < minTarif}">
                                                        <c:set var="minTarif" value="${s.tarifConsultation}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${minTarif} DH
                                            </h5>
                                            <small class="text-muted">Tarif minimum</small>
                                        </div>
                                        <div class="col-md-3">
                                            <h5 class="text-warning">
                                                <c:set var="maxTarif" value="0"/>
                                                <c:forEach var="s" items="${specialistes}">
                                                    <c:if test="${s.tarifConsultation > maxTarif}">
                                                        <c:set var="maxTarif" value="${s.tarifConsultation}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${maxTarif} DH
                                            </h5>
                                            <small class="text-muted">Tarif maximum</small>
                                        </div>
                                        <div class="col-md-3">
                                            <h5 class="text-info">
                                                <c:set var="totalTarif" value="0"/>
                                                <c:forEach var="s" items="${specialistes}">
                                                    <c:set var="totalTarif" value="${totalTarif + s.tarifConsultation}"/>
                                                </c:forEach>
                                                <fmt:formatNumber value="${totalTarif / specialistes.size()}" maxFractionDigits="0"/> DH
                                            </h5>
                                            <small class="text-muted">Tarif moyen</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
