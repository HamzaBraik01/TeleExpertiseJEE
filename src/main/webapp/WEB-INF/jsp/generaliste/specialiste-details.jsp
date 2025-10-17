<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Spécialiste - TéléExpertise</title>
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
                    <h2><i class="fas fa-user-md"></i> Détails du Spécialiste</h2>
                    <a href="${pageContext.request.contextPath}/generaliste/specialistes" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty specialiste}">
                    <div class="row">
                        <!-- Informations principales -->
                        <div class="col-md-8">
                            <div class="card mb-4">
                                <div class="card-header bg-primary text-white">
                                    <h5 class="mb-0"><i class="fas fa-id-card"></i> Informations Personnelles</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="text-center mb-4">
                                                <div class="avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3"
                                                     style="width: 80px; height: 80px; font-size: 2rem;">
                                                    <i class="fas fa-user-md"></i>
                                                </div>
                                                <h4>Dr. ${specialiste.user.prenom} ${specialiste.user.nom}</h4>
                                                <p class="text-muted">${specialiste.specialite.nom}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <table class="table table-borderless">
                                                <tr>
                                                    <th>Email :</th>
                                                    <td>${specialiste.user.email}</td>
                                                </tr>
                                                <tr>
                                                    <th>N° Ordre :</th>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty specialiste.numeroOrdre}">
                                                                ${specialiste.numeroOrdre}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Non renseigné</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Disponibilité :</th>
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
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Spécialité et Expérience -->
                            <div class="card mb-4">
                                <div class="card-header bg-info text-white">
                                    <h5 class="mb-0"><i class="fas fa-stethoscope"></i> Spécialité et Expérience</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h6 class="text-primary">Spécialité</h6>
                                            <p class="mb-3">
                                                <span class="badge bg-secondary fs-6">${specialiste.specialite.nom}</span>
                                            </p>
                                            <h6 class="text-primary">Description</h6>
                                            <p class="text-muted">${specialiste.specialite.description}</p>
                                        </div>
                                        <div class="col-md-6">
                                            <h6 class="text-primary">Expérience</h6>
                                            <p class="mb-3">
                                                <c:choose>
                                                    <c:when test="${not empty specialiste.experience}">
                                                        ${specialiste.experience}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Expérience non renseignée</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                            <h6 class="text-primary">Diplômes</h6>
                                            <p>
                                                <c:choose>
                                                    <c:when test="${not empty specialiste.diplomes}">
                                                        ${specialiste.diplomes}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Diplômes non renseignés</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Statistiques -->
                            <div class="card">
                                <div class="card-header bg-success text-white">
                                    <h5 class="mb-0"><i class="fas fa-chart-bar"></i> Statistiques</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row text-center">
                                        <div class="col-md-4">
                                            <div class="bg-light p-3 rounded">
                                                <h4 class="text-primary">${specialiste.nombreExpertisesTerminees}</h4>
                                                <small class="text-muted">Expertises terminées</small>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="bg-light p-3 rounded">
                                                <h4 class="text-success">
                                                    <fmt:formatNumber value="${specialiste.revenus}" maxFractionDigits="0"/> DH
                                                </h4>
                                                <small class="text-muted">Revenus totaux</small>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="bg-light p-3 rounded">
                                                <h4 class="text-info">${specialiste.dureeConsultation} min</h4>
                                                <small class="text-muted">Durée consultation</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sidebar avec actions -->
                        <div class="col-md-4">
                            <!-- Tarification -->
                            <div class="card mb-4">
                                <div class="card-header bg-warning text-dark">
                                    <h5 class="mb-0"><i class="fas fa-euro-sign"></i> Tarification</h5>
                                </div>
                                <div class="card-body text-center">
                                    <h3 class="text-success mb-3">${specialiste.tarifConsultation} DH</h3>
                                    <p class="text-muted">Tarif par consultation</p>
                                    <small class="text-muted">Durée : ${specialiste.dureeConsultation} minutes</small>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="card">
                                <div class="card-header bg-dark text-white">
                                    <h5 class="mb-0"><i class="fas fa-tools"></i> Actions</h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${specialiste.disponible}">
                                        <a href="${pageContext.request.contextPath}/generaliste/creneaux?specialisteId=${specialiste.id}"
                                           class="btn btn-success btn-lg w-100 mb-3">
                                            <i class="fas fa-calendar-alt"></i> Voir Créneaux Disponibles
                                        </a>

                                        <a href="${pageContext.request.contextPath}/generaliste/expertise?action=nouvelle&specialisteId=${specialiste.id}"
                                           class="btn btn-primary btn-lg w-100 mb-3">
                                            <i class="fas fa-plus"></i> Demander une Expertise
                                        </a>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/generaliste/specialistes"
                                       class="btn btn-outline-secondary w-100">
                                        <i class="fas fa-search"></i> Chercher un autre Spécialiste
                                    </a>
                                </div>
                            </div>

                            <!-- Contact -->
                            <div class="card mt-4">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0"><i class="fas fa-address-card"></i> Contact</h6>
                                </div>
                                <div class="card-body">
                                    <p class="mb-0">
                                        <i class="fas fa-envelope text-muted me-2"></i>
                                        <a href="mailto:${specialiste.user.email}">${specialiste.user.email}</a>
                                    </p>
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
