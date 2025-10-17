<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Consultations - Généraliste</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">TéléExpertise</a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">Dr. ${user.prenom} ${user.nom}</span>
                <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-stethoscope"></i> Gestion des Consultations</h2>
                    <div>
                        <a href="specialistes" class="btn btn-info me-2">
                            <i class="fas fa-user-md"></i> Rechercher un Spécialiste
                        </a>
                        <a href="consultation?action=nouvelle" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Nouvelle Consultation
                        </a>
                    </div>
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

                <!-- Patients en attente -->
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0"><i class="fas fa-clock"></i> Patients en Attente</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty patientsEnAttente}">
                                <p class="text-muted">Aucun patient en attente</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Patient</th>
                                                <th>Heure d'arrivée</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="patient" items="${patientsEnAttente}" varStatus="status">
                                                <tr>
                                                    <td><strong>${status.index + 1}</strong></td>
                                                    <td>
                                                        <strong>${patient.prenom} ${patient.nom}</strong><br>
                                                        <small class="text-muted">N° Sécu: ${patient.numeroSecuriteSociale}</small>
                                                        <c:if test="${not empty patient.telephone}">
                                                            <br><small class="text-muted">Tél: ${patient.telephone}</small>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty patient.heureArrivee}">
                                                                ${patient.heureArrivee.hour}h${patient.heureArrivee.minute < 10 ? '0' : ''}${patient.heureArrivee.minute}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Non définie</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="consultation?action=nouvelle&patientId=${patient.id}"
                                                           class="btn btn-success">
                                                            <i class="fas fa-stethoscope"></i> Consulter
                                                        </a>
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

                <!-- Mes consultations -->
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-history"></i> Mes Consultations</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty consultations}">
                                <p class="text-muted">Aucune consultation enregistrée</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Patient</th>
                                                <th>Motif</th>
                                                <th>Date</th>
                                                <th>Statut</th>
                                                <th>Coût Total</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="consultation" items="${consultations}">
                                                <tr>
                                                    <td>
                                                        <strong>${consultation.patient.prenom} ${consultation.patient.nom}</strong>
                                                    </td>
                                                    <td>${consultation.motif}</td>
                                                    <td>
                                                        ${consultation.dateConsultation.dayOfMonth}/${consultation.dateConsultation.monthValue}/${consultation.dateConsultation.year}
                                                        ${consultation.dateConsultation.hour}h${consultation.dateConsultation.minute < 10 ? '0' : ''}${consultation.dateConsultation.minute}
                                                    </td>
                                                    <td>
                                                        <span class="badge ${consultation.statut == 'TERMINEE' ? 'bg-success' : 'bg-warning'}">
                                                            ${consultation.statut}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <strong>${consultation.coutTotal} DH</strong>
                                                    </td>
                                                    <td>
                                                        <a href="consultation?action=details&id=${consultation.id}"
                                                           class="btn btn-sm btn-primary">
                                                            <i class="fas fa-eye"></i> Détails
                                                        </a>
                                                        <c:if test="${consultation.statut != 'TERMINEE'}">
                                                            <a href="consultation?action=actes&consultationId=${consultation.id}"
                                                               class="btn btn-sm btn-warning">
                                                                <i class="fas fa-tools"></i> Actes
                                                            </a>
                                                        </c:if>
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
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
