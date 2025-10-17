<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Consultation - Généraliste</title>
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
                    <h2><i class="fas fa-clipboard-check"></i> Consultation #${consultation.id}</h2>
                    <div>
                        <c:if test="${consultation.statut != 'TERMINEE'}">
                            <a href="consultation?action=actes&consultationId=${consultation.id}" class="btn btn-info">
                                <i class="fas fa-tools"></i> Gérer Actes Techniques
                            </a>
                            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#ajouterActeModal">
                                <i class="fas fa-plus"></i> Ajouter Acte
                            </button>
                            <button type="button" class="btn btn-success" onclick="terminerConsultation()">
                                <i class="fas fa-check"></i> Terminer
                            </button>
                        </c:if>
                        <a href="consultation" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                    </div>
                </div>

                <div class="row">
                    <!-- Informations du patient -->
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-user"></i> Patient</h5>
                            </div>
                            <div class="card-body">
                                <h6>${consultation.patient.prenom} ${consultation.patient.nom}</h6>
                                <p class="mb-1"><strong>Âge :</strong> ${consultation.patient.age} ans</p>
                                <p class="mb-1"><strong>N° SS :</strong> ${consultation.patient.numeroSecuriteSociale}</p>
                                <p class="mb-1"><strong>Téléphone :</strong> ${consultation.patient.telephone}</p>
                                <p class="mb-0"><strong>Adresse :</strong> ${consultation.patient.adresse}</p>
                            </div>
                        </div>

                        <!-- Résumé financier -->
                        <div class="card">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-calculator"></i> Coût de la Consultation</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Consultation de base :</span>
                                    <strong>${consultation.coutConsultation} DH</strong>
                                </div>
                                <c:forEach var="acte" items="${actesTechniques}">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>${acte.type.libelle} :</span>
                                        <span>${acte.cout} DH</span>
                                    </div>
                                </c:forEach>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <strong>Total :</strong>
                                    <strong class="text-success">${consultation.coutTotal} DH</strong>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Détails de la consultation -->
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-notes-medical"></i> Détails de la Consultation</h5>
                            </div>
                            <div class="card-body">
                                <form action="consultation" method="post">
                                    <input type="hidden" name="action" value="modifier">
                                    <input type="hidden" name="consultationId" value="${consultation.id}">

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Date de consultation</label>
                                            <input type="text" class="form-control"
                                                   value="${consultation.dateConsultation.dayOfMonth}/${consultation.dateConsultation.monthValue}/${consultation.dateConsultation.year} ${consultation.dateConsultation.hour}h${consultation.dateConsultation.minute < 10 ? '0' : ''}${consultation.dateConsultation.minute}" readonly>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Statut</label>
                                            <span class="form-control ${consultation.statut == 'TERMINEE' ? 'bg-success text-white' : 'bg-warning'}">
                                                ${consultation.statut}
                                            </span>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="motif" class="form-label">Motif de consultation</label>
                                        <input type="text" class="form-control" id="motif" name="motif"
                                               value="${consultation.motif}" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>
                                    </div>

                                    <div class="mb-3">
                                        <label for="observations" class="form-label">Observations</label>
                                        <textarea class="form-control" id="observations" name="observations" rows="3"
                                                  ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.observations}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="examenClinique" class="form-label">Examen clinique</label>
                                        <textarea class="form-control" id="examenClinique" name="examenClinique" rows="3"
                                                  ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.examenClinique}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="analyseSymptomes" class="form-label">Analyse des symptômes</label>
                                        <textarea class="form-control" id="analyseSymptomes" name="analyseSymptomes" rows="3"
                                                  ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.analyseSymptomes}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="diagnostic" class="form-label">Diagnostic</label>
                                        <input type="text" class="form-control" id="diagnostic" name="diagnostic"
                                               value="${consultation.diagnostic}" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>
                                    </div>

                                    <div class="mb-3">
                                        <label for="traitement" class="form-label">Traitement prescrit</label>
                                        <textarea class="form-control" id="traitement" name="traitement" rows="3"
                                                  ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.traitement}</textarea>
                                    </div>

                                    <c:if test="${consultation.statut != 'TERMINEE'}">
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-save"></i> Sauvegarder les modifications
                                            </button>
                                        </div>
                                    </c:if>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Actes techniques -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-warning text-dark">
                                <h5 class="mb-0"><i class="fas fa-tools"></i> Actes Techniques</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty actesTechniques}">
                                        <p class="text-muted">Aucun acte technique réalisé</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Type d'acte</th>
                                                        <th>Description</th>
                                                        <th>Coût</th>
                                                        <th>Date</th>
                                                        <th>Réalisé par</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="acte" items="${actesTechniques}">
                                                        <tr>
                                                            <td><strong>${acte.type.libelle}</strong></td>
                                                            <td>${acte.description}</td>
                                                            <td><strong>${acte.cout} DH</strong></td>
                                                            <td>
                                                                ${acte.dateRealisation.dayOfMonth}/${acte.dateRealisation.monthValue}/${acte.dateRealisation.year} ${acte.dateRealisation.hour}h${acte.dateRealisation.minute < 10 ? '0' : ''}${acte.dateRealisation.minute}
                                                            </td>
                                                            <td>Dr. ${acte.realisePar.prenom} ${acte.realisePar.nom}</td>
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
        </div>
    </div>

    <!-- Modal pour ajouter un acte technique -->
    <div class="modal fade" id="ajouterActeModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="consultation" method="post">
                    <input type="hidden" name="action" value="ajouter-acte">
                    <input type="hidden" name="consultationId" value="${consultation.id}">

                    <div class="modal-header">
                        <h5 class="modal-title">Ajouter un Acte Technique</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="typeActe" class="form-label">Type d'acte *</label>
                            <select class="form-select" id="typeActe" name="typeActe" required onchange="updateCout()">
                                <option value="">Sélectionnez un type d'acte</option>
                                <c:forEach var="type" items="${typesActes}">
                                    <option value="${type}" data-cout="${type.coutStandard}">
                                        ${type.libelle} (${type.coutStandard} DH)
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="cout" class="form-label">Coût (DH) *</label>
                            <input type="number" class="form-control" id="cout" name="cout" step="0.01" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"
                                      placeholder="Description optionnelle de l'acte..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                        <button type="submit" class="btn btn-primary">Ajouter l'Acte</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateCout() {
            const select = document.getElementById('typeActe');
            const coutInput = document.getElementById('cout');
            const selectedOption = select.options[select.selectedIndex];

            if (selectedOption.dataset.cout) {
                coutInput.value = selectedOption.dataset.cout;
            }
        }

        function terminerConsultation() {
            if (confirm('Êtes-vous sûr de vouloir terminer cette consultation ? Cette action est irréversible.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'consultation';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'terminer';
                form.appendChild(actionInput);

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'consultationId';
                idInput.value = '${consultation.id}';
                form.appendChild(idInput);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
