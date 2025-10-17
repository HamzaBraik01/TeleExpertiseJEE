<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Consultation - Généraliste</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="consultation">TéléExpertise</a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">Dr. ${user.prenom} ${user.nom}</span>
                <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="fas fa-plus"></i> Nouvelle Consultation</h4>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty patient}">
                                <!-- Informations du patient sélectionné -->
                                <div class="alert alert-info mb-4">
                                    <h5><i class="fas fa-user"></i> Patient sélectionné</h5>
                                    <p class="mb-0">
                                        <strong>${patient.prenom} ${patient.nom}</strong><br>
                                        <small>N° Sécurité Sociale: ${patient.numeroSecuriteSociale}</small>
                                        <c:if test="${not empty patient.telephone}">
                                            <br><small>Téléphone: ${patient.telephone}</small>
                                        </c:if>
                                    </p>
                                </div>

                                <!-- Formulaire de consultation -->
                                <form action="consultation" method="post">
                                    <input type="hidden" name="action" value="creer">
                                    <input type="hidden" name="patientId" value="${patient.id}">

                                    <div class="mb-3">
                                        <label for="motif" class="form-label">Motif de consultation *</label>
                                        <input type="text" class="form-control" id="motif" name="motif"
                                               placeholder="Ex: fièvre, toux, douleurs abdominales..." required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="observations" class="form-label">Observations médicales</label>
                                        <textarea class="form-control" id="observations" name="observations" rows="4"
                                                  placeholder="Notez vos observations à l'examen du patient..."></textarea>
                                    </div>

                                    <div class="alert alert-success">
                                        <i class="fas fa-info-circle"></i>
                                        <strong>Information :</strong> Le coût de base de cette consultation sera de <strong>150 DH</strong>.
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="consultation" class="btn btn-secondary me-md-2">
                                            <i class="fas fa-arrow-left"></i> Retour
                                        </a>
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save"></i> Enregistrer la Consultation
                                        </button>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <!-- Aucun patient sélectionné - retourner à la liste -->
                                <div class="text-center">
                                    <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                                    <h5>Aucun patient sélectionné</h5>
                                    <p class="text-muted">Veuillez sélectionner un patient depuis la liste des patients en attente.</p>
                                    <a href="consultation" class="btn btn-primary">
                                        <i class="fas fa-arrow-left"></i> Retour à la liste des patients
                                    </a>
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
