<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Consultation - Généraliste</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; }
        @keyframes slideInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-slide-up { animation: slideInUp 0.8s ease-out; }
        .modal { display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal.show { display: flex; align-items: center; justify-content: center; }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-cyan-50 to-slate-50 min-h-screen overflow-x-hidden">

<!-- Background Effects -->
<div class="fixed inset-0 -z-20 bg-gradient-to-br from-blue-100/50 via-cyan-100/30 to-slate-100/40"></div>
<div class="fixed inset-0 -z-10 opacity-30" style="background-image: radial-gradient(circle at 20% 80%, rgba(37, 99, 235, 0.08) 0%, transparent 50%), radial-gradient(circle at 80% 20%, rgba(8, 145, 178, 0.08) 0%, transparent 50%);"></div>

<!-- Navigation -->
<nav class="fixed top-0 w-full z-50 bg-white/95 backdrop-blur-xl border-b border-white/20 shadow-xl">
    <div class="container mx-auto px-4 py-4">
        <div class="flex items-center justify-between">
            <a href="${pageContext.request.contextPath}/generaliste/consultation" class="flex items-center group">
                <div class="w-12 h-12 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-2xl flex items-center justify-center mr-3 shadow-lg shadow-blue-500/30 transition-all duration-300 group-hover:rotate-6 group-hover:scale-110">
                    <i class="bi bi-heart-pulse text-white text-2xl"></i>
                </div>
                <span class="text-2xl font-extrabold bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">TeleExpertise</span>
            </a>
            <div class="flex items-center space-x-4">
                <div class="flex items-center bg-white/90 backdrop-blur-md border border-white/20 rounded-2xl px-4 py-2 shadow-lg">
                    <div class="w-9 h-9 bg-gradient-to-br from-cyan-600 to-cyan-500 rounded-xl flex items-center justify-center mr-3 shadow-md shadow-cyan-500/30">
                        <i class="bi bi-person-badge text-white"></i>
                    </div>
                    <div class="flex flex-col mr-3">
                        <span class="text-sm font-semibold text-slate-800">Dr. ${user.prenom} ${user.nom}</span>
                        <span class="text-xs font-medium text-white bg-gradient-to-r from-blue-600 to-blue-500 px-2 py-0.5 rounded-lg shadow-sm">Généraliste</span>
                    </div>
                </div>
                <a class="px-4 py-2 text-sm font-semibold text-red-600 border-2 border-red-600 rounded-xl hover:bg-gradient-to-r hover:from-red-600 hover:to-red-500 hover:text-white hover:border-transparent transition-all duration-300 hover:-translate-y-1" href="${pageContext.request.contextPath}/auth/logout">
                    <i class="bi bi-box-arrow-right mr-2"></i>Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="mt-20 bg-gradient-to-r from-blue-600 to-cyan-600 text-white py-12 relative overflow-hidden">
    <div class="absolute inset-0 opacity-30" style="background-image: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'0.1\'%3E%3Ccircle cx=\'30\' cy=\'30\' r=\'2\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    <div class="container mx-auto px-4 relative z-10">
        <div class="flex justify-between items-center">
            <h1 class="text-4xl font-bold animate-slide-up">
                <i class="bi bi-clipboard-check mr-3"></i>Consultation #${consultation.id}
            </h1>
            <div class="flex space-x-3">
                <c:if test="${consultation.statut != 'TERMINEE'}">
                    <a href="consultation?action=actes&consultationId=${consultation.id}" class="px-4 py-2 bg-white/20 backdrop-blur-md border border-white/30 rounded-xl font-semibold hover:bg-white/30 transition-all duration-300">
                        <i class="bi bi-tools mr-2"></i>Gérer Actes
                    </a>
                    <button onclick="document.getElementById('ajouterActeModal').classList.add('show')" class="px-4 py-2 bg-amber-500 text-white rounded-xl font-semibold hover:bg-amber-600 transition-all duration-300">
                        <i class="bi bi-plus-circle mr-2"></i>Ajouter Acte
                    </button>
                    <button onclick="terminerConsultation()" class="px-4 py-2 bg-green-500 text-white rounded-xl font-semibold hover:bg-green-600 transition-all duration-300">
                        <i class="bi bi-check-circle mr-2"></i>Terminer
                    </button>
                </c:if>
                <a href="consultation" class="px-4 py-2 bg-white text-blue-600 rounded-xl font-semibold hover:shadow-xl transition-all duration-300">
                    <i class="bi bi-arrow-left mr-2"></i>Retour
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Sidebar - Patient & Coût -->
        <div class="lg:col-span-1 space-y-6">
            <!-- Informations du patient -->
            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl overflow-hidden animate-slide-up">
                <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4">
                    <h5 class="text-lg font-bold"><i class="bi bi-person-circle mr-2"></i>Patient</h5>
                </div>
                <div class="p-6 text-slate-700 space-y-3">
                    <h6 class="font-bold text-lg text-slate-800">${consultation.patient.prenom} ${consultation.patient.nom}</h6>
                    <p class="text-sm"><strong>Âge :</strong> ${consultation.patient.age} ans</p>
                    <p class="text-sm"><strong>N° SS :</strong> ${consultation.patient.numeroSecuriteSociale}</p>
                    <p class="text-sm"><strong>Tél :</strong> ${consultation.patient.telephone}</p>
                    <p class="text-sm"><strong>Adresse :</strong> ${consultation.patient.adresse}</p>
                </div>
            </div>

            <!-- Résumé financier -->
            <div class="bg-gradient-to-br from-green-600 to-green-500 text-white rounded-3xl shadow-xl p-6 transition-all duration-300 hover:-translate-y-2">
                <h5 class="text-lg font-bold mb-4"><i class="bi bi-calculator mr-2"></i>Coût de la Consultation</h5>
                <div class="space-y-3">
                    <div class="flex justify-between pb-2 border-b border-white/20">
                        <span class="opacity-90">Consultation de base :</span>
                        <strong>${consultation.coutConsultation} DH</strong>
                    </div>
                    <c:forEach var="acte" items="${actesTechniques}">
                        <div class="flex justify-between text-sm opacity-90">
                            <span>${acte.type.libelle} :</span>
                            <span>${acte.cout} DH</span>
                        </div>
                    </c:forEach>
                    <div class="flex justify-between pt-2 border-t-2 border-white/30 text-xl">
                        <strong>Total :</strong>
                        <strong>${consultation.coutTotal} DH</strong>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="lg:col-span-2 space-y-6">
            <!-- Détails consultation -->
            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl overflow-hidden animate-slide-up">
                <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4">
                    <h5 class="text-lg font-bold"><i class="bi bi-notes-medical mr-2"></i>Détails de la Consultation</h5>
                </div>
                <div class="p-6">
                    <form action="consultation" method="post" class="space-y-4">
                        <input type="hidden" name="action" value="modifier">
                        <input type="hidden" name="consultationId" value="${consultation.id}">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 mb-2">Date de consultation</label>
                                <input type="text" class="w-full px-4 py-3 border border-slate-300 rounded-xl bg-slate-50"
                                       value="${consultation.dateConsultation.dayOfMonth}/${consultation.dateConsultation.monthValue}/${consultation.dateConsultation.year} ${consultation.dateConsultation.hour}h${consultation.dateConsultation.minute < 10 ? '0' : ''}${consultation.dateConsultation.minute}" readonly>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-slate-700 mb-2">Statut</label>
                                <span class="block w-full px-4 py-3 rounded-xl text-center font-bold ${consultation.statut == 'TERMINEE' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}">
                                    ${consultation.statut}
                                </span>
                            </div>
                        </div>

                        <div>
                            <label for="motif" class="block text-sm font-semibold text-slate-700 mb-2">Motif de consultation</label>
                            <input type="text" class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 ${consultation.statut == 'TERMINEE' ? 'bg-slate-50' : ''}"
                                   id="motif" name="motif" value="${consultation.motif}" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>
                        </div>

                        <div>
                            <label for="observations" class="block text-sm font-semibold text-slate-700 mb-2">Observations</label>
                            <textarea class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 ${consultation.statut == 'TERMINEE' ? 'bg-slate-50' : ''}"
                                      id="observations" name="observations" rows="3" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.observations}</textarea>
                        </div>

                        <div>
                            <label for="examenClinique" class="block text-sm font-semibold text-slate-700 mb-2">Examen clinique</label>
                            <textarea class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 ${consultation.statut == 'TERMINEE' ? 'bg-slate-50' : ''}"
                                      id="examenClinique" name="examenClinique" rows="3" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.examenClinique}</textarea>
                        </div>

                        <div>
                            <label for="analyseSymptomes" class="block text-sm font-semibold text-slate-700 mb-2">Analyse des symptômes</label>
                            <textarea class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 ${consultation.statut == 'TERMINEE' ? 'bg-slate-50' : ''}"
                                      id="analyseSymptomes" name="analyseSymptomes" rows="3" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.analyseSymptomes}</textarea>
                        </div>

                        <div>
                            <label for="diagnostic" class="block text-sm font-semibold text-slate-700 mb-2">Diagnostic</label>
                            <input type="text" class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 ${consultation.statut == 'TERMINEE' ? 'bg-slate-50' : ''}"
                                   id="diagnostic" name="diagnostic" value="${consultation.diagnostic}" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>
                        </div>

                        <div>
                            <label for="traitement" class="block text-sm font-semibold text-slate-700 mb-2">Traitement prescrit</label>
                            <textarea class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 ${consultation.statut == 'TERMINEE' ? 'bg-slate-50' : ''}"
                                      id="traitement" name="traitement" rows="3" ${consultation.statut == 'TERMINEE' ? 'readonly' : ''}>${consultation.traitement}</textarea>
                        </div>

                        <c:if test="${consultation.statut != 'TERMINEE'}">
                            <button type="submit" class="w-full px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                                <i class="bi bi-save mr-2"></i>Sauvegarder les modifications
                            </button>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- Actes techniques -->
            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl overflow-hidden animate-slide-up">
                <div class="bg-gradient-to-r from-amber-500 to-yellow-500 text-white px-6 py-4">
                    <h5 class="text-lg font-bold"><i class="bi bi-tools mr-2"></i>Actes Techniques</h5>
                </div>
                <div class="p-6">
                    <c:choose>
                        <c:when test="${empty actesTechniques}">
                            <p class="text-slate-500 text-center py-4">Aucun acte technique réalisé</p>
                        </c:when>
                        <c:otherwise>
                            <div class="overflow-x-auto">
                                <table class="w-full">
                                    <thead>
                                        <tr class="border-b border-slate-200">
                                            <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Type</th>
                                            <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Description</th>
                                            <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Coût</th>
                                            <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Date</th>
                                            <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Réalisé par</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="acte" items="${actesTechniques}">
                                            <tr class="border-b border-slate-100 hover:bg-blue-50/50 transition-colors">
                                                <td class="px-4 py-3"><strong class="text-slate-800">${acte.type.libelle}</strong></td>
                                                <td class="px-4 py-3 text-slate-600">${acte.description}</td>
                                                <td class="px-4 py-3"><strong class="text-green-600">${acte.cout} DH</strong></td>
                                                <td class="px-4 py-3 text-slate-600">
                                                    ${acte.dateRealisation.dayOfMonth}/${acte.dateRealisation.monthValue}/${acte.dateRealisation.year}
                                                    ${acte.dateRealisation.hour}h${acte.dateRealisation.minute < 10 ? '0' : ''}${acte.dateRealisation.minute}
                                                </td>
                                                <td class="px-4 py-3 text-slate-600">Dr. ${acte.realisePar.prenom} ${acte.realisePar.nom}</td>
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

<!-- Modal Ajouter Acte -->
<div id="ajouterActeModal" class="modal">
    <div class="bg-white rounded-3xl shadow-2xl max-w-2xl w-full mx-4 animate-slide-up overflow-hidden">
        <form action="consultation" method="post">
            <input type="hidden" name="action" value="ajouter-acte">
            <input type="hidden" name="consultationId" value="${consultation.id}">
            <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4 flex justify-between items-center">
                <h5 class="text-xl font-bold">Ajouter un Acte Technique</h5>
                <button type="button" onclick="document.getElementById('ajouterActeModal').classList.remove('show')" class="text-white hover:text-gray-200">
                    <i class="bi bi-x-lg text-2xl"></i>
                </button>
            </div>
            <div class="p-6 space-y-4">
                <div>
                    <label for="typeActe" class="block text-sm font-semibold text-slate-700 mb-2">Type d'acte *</label>
                    <select class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500" id="typeActe" name="typeActe" required onchange="updateCout()">
                        <option value="">Sélectionnez un type d'acte</option>
                        <c:forEach var="type" items="${typesActes}">
                            <option value="${type}" data-cout="${type.coutStandard}">
                                ${type.libelle} (${type.coutStandard} DH)
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label for="cout" class="block text-sm font-semibold text-slate-700 mb-2">Coût (DH) *</label>
                    <input type="number" class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500" id="cout" name="cout" step="0.01" min="0" required>
                </div>
                <div>
                    <label for="description" class="block text-sm font-semibold text-slate-700 mb-2">Description</label>
                    <textarea class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500" id="description" name="description" rows="3" placeholder="Description optionnelle..."></textarea>
                </div>
            </div>
            <div class="px-6 py-4 bg-slate-50 flex justify-end space-x-3">
                <button type="button" onclick="document.getElementById('ajouterActeModal').classList.remove('show')" class="px-6 py-3 bg-slate-200 text-slate-700 rounded-xl font-semibold hover:bg-slate-300 transition-all">Annuler</button>
                <button type="submit" class="px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1">Ajouter l'Acte</button>
            </div>
        </form>
    </div>
</div>

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
