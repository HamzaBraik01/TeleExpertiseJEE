<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actes Techniques - Généraliste</title>
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
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-tools"></i> Gestion des Actes Techniques</h2>
                    <div>
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#ajouterActeModal">
                            <i class="fas fa-plus"></i> Ajouter Acte
                        </button>
                        <a href="consultation?action=details&id=${consultation.id}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Retour à la Consultation
                        </a>
                    </div>
                </div>

                <!-- Informations de la consultation -->
                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">Consultation en cours</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Patient :</strong> ${consultation.patient.prenom} ${consultation.patient.nom}</p>
                                <p><strong>Motif :</strong> ${consultation.motif}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Date :</strong>
                                    ${consultation.dateConsultation.dayOfMonth}/${consultation.dateConsultation.monthValue}/${consultation.dateConsultation.year}
                                    ${consultation.dateConsultation.hour}h${consultation.dateConsultation.minute < 10 ? '0' : ''}${consultation.dateConsultation.minute}
                                </p>
                                <p><strong>Coût de base :</strong> ${consultation.coutConsultation} DH</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Liste des actes techniques -->
                <div class="card">
                    <div class="card-header bg-warning text-dark d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-list"></i> Actes Techniques Réalisés</h5>
                        <span class="badge bg-primary fs-6">
                            Total actes :
                            <c:set var="totalActes" value="0"/>
                            <c:forEach var="acte" items="${actesTechniques}">
                                <c:set var="totalActes" value="${totalActes + acte.cout}"/>
                            </c:forEach>
                            ${totalActes} DH
                        </span>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty actesTechniques}">
                                <div class="text-center py-5">
                                    <i class="fas fa-clipboard-list fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">Aucun acte technique réalisé</h5>
                                    <p class="text-muted">Cliquez sur "Ajouter Acte" pour commencer</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Type d'Acte</th>
                                                <th>Description</th>
                                                <th>Coût</th>
                                                <th>Date de Réalisation</th>
                                                <th>Réalisé par</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="acte" items="${actesTechniques}" varStatus="status">
                                                <tr>
                                                    <td>
                                                        <strong>${acte.type.libelle}</strong>
                                                        <br>
                                                        <small class="text-muted">${acte.type.description}</small>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty acte.description}">
                                                                ${acte.description}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted fst-italic">Aucune description</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="fw-bold text-success">${acte.cout} DH</span>
                                                    </td>
                                                    <td>
                                                        ${acte.dateRealisation.dayOfMonth}/${acte.dateRealisation.monthValue}/${acte.dateRealisation.year}
                                                        <br>
                                                        <small class="text-muted">
                                                            ${acte.dateRealisation.hour}h${acte.dateRealisation.minute < 10 ? '0' : ''}${acte.dateRealisation.minute}
                                                        </small>
                                                    </td>
                                                    <td>
                                                        Dr. ${acte.realisePar.prenom} ${acte.realisePar.nom}
                                                    </td>
                                                    <td>
                                                        <a href="consultation?action=voir-acte&id=${acte.id}"
                                                           class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-eye"></i> Voir
                                                        </a>
                                                        <c:if test="${consultation.statut != 'TERMINEE'}">
                                                            <form method="post" action="consultation" style="display: inline;">
                                                                <input type="hidden" name="action" value="supprimer-acte">
                                                                <input type="hidden" name="acteId" value="${acte.id}">
                                                                <input type="hidden" name="consultationId" value="${consultation.id}">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger"
                                                                        onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet acte technique ?')">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot class="table-light">
                                            <tr>
                                                <td colspan="2"><strong>Total des actes techniques</strong></td>
                                                <td><strong class="text-success">${totalActes} DH</strong></td>
                                                <td colspan="3"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><strong>Coût consultation de base</strong></td>
                                                <td><strong class="text-primary">${consultation.coutConsultation} DH</strong></td>
                                                <td colspan="3"></td>
                                            </tr>
                                            <tr class="table-success">
                                                <td colspan="2"><strong>TOTAL GÉNÉRAL</strong></td>
                                                <td><strong class="text-success fs-5">${consultation.coutTotal} DH</strong></td>
                                                <td colspan="3"></td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Résumé financier -->
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card border-success">
                            <div class="card-header bg-success text-white">
                                <h6 class="mb-0"><i class="fas fa-calculator"></i> Résumé Financier</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Consultation :</span>
                                    <span>${consultation.coutConsultation} DH</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Actes techniques :</span>
                                    <span>${totalActes} DH</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <strong>Total à payer :</strong>
                                    <strong class="text-success">${consultation.coutTotal} DH</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card border-info">
                            <div class="card-header bg-info text-white">
                                <h6 class="mb-0"><i class="fas fa-info-circle"></i> Informations</h6>
                            </div>
                            <div class="card-body">
                                <p class="mb-2"><small><i class="fas fa-check-circle text-success"></i> Coût de consultation fixe : 150 DH</small></p>
                                <p class="mb-2"><small><i class="fas fa-tools text-primary"></i> ${actesTechniques.size()} acte(s) technique(s) réalisé(s)</small></p>
                                <p class="mb-0"><small><i class="fas fa-calendar text-warning"></i>
                                    Consultation du ${consultation.dateConsultation.dayOfMonth}/${consultation.dateConsultation.monthValue}/${consultation.dateConsultation.year}
                                </small></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal pour ajouter un acte technique -->
    <div class="modal fade" id="ajouterActeModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="consultation" method="post">
                    <input type="hidden" name="action" value="ajouter-acte">
                    <input type="hidden" name="consultationId" value="${consultation.id}">

                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Ajouter un Acte Technique</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="typeActe" class="form-label">Type d'acte *</label>
                                <select class="form-select" id="typeActe" name="typeActe" required>
                                    <option value="">Sélectionnez un type d'acte</option>
                                    <c:forEach var="type" items="${typesActes}">
                                        <option value="${type}" ${param.typeActe == type ? 'selected' : ''}>
                                            ${type.libelle} - ${type.coutStandard} DH
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="cout" class="form-label">Coût (DH) *</label>
                                <input type="number" class="form-control" id="cout" name="cout"
                                       step="0.01" min="0" required value="${param.cout}">
                                <div class="form-text">Modifiez le coût si nécessaire</div>
                            </div>
                        </div>

                        <c:if test="${not empty param.typeActe}">
                            <div class="mb-3">
                                <label class="form-label">Description de l'acte sélectionné</label>
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <c:forEach var="type" items="${typesActes}">
                                            <c:if test="${param.typeActe == type}">
                                                <p class="mb-0">${type.description}</p>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <div class="mb-3">
                            <label for="description" class="form-label">Notes personnelles</label>
                            <textarea class="form-control" id="description" name="description" rows="3"
                                      placeholder="Ajoutez des notes personnelles sur cet acte (optionnel)...">${param.description}</textarea>
                        </div>

                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            <strong>Information :</strong> L'acte sera automatiquement daté et associé à votre nom.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Annuler
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Ajouter l'Acte
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mettre à jour automatiquement le coût quand on sélectionne un type d'acte
        document.addEventListener('DOMContentLoaded', function() {
            const typeActeSelect = document.getElementById('typeActe');
            const coutInput = document.getElementById('cout');

            if (typeActeSelect && coutInput) {
                typeActeSelect.addEventListener('change', function() {
                    const selectedOption = typeActeSelect.options[typeActeSelect.selectedIndex];
                    if (selectedOption.value) {
                        // Extraire le coût du texte de l'option (format: "Nom - Prix DH")
                        const optionText = selectedOption.textContent;
                        const coutMatch = optionText.match(/(\d+(?:\.\d+)?)\s*DH/);
                        if (coutMatch) {
                            coutInput.value = coutMatch[1];
                        }
                    } else {
                        coutInput.value = '';
                    }
                });
            }
        });
    </script>
</body>
</html>
