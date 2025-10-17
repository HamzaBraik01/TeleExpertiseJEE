<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Consultations - Généraliste</title>
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
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .animate-slide-up { animation: slideInUp 0.8s ease-out; }
        .animate-fade-in { animation: fadeIn 1s ease-out; }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-cyan-50 to-slate-50 min-h-screen overflow-x-hidden">

<!-- Background Effects -->
<div class="fixed inset-0 -z-20 bg-gradient-to-br from-blue-100/50 via-cyan-100/30 to-slate-100/40"></div>
<div class="fixed inset-0 -z-10 opacity-30" style="background-image: radial-gradient(circle at 20% 80%, rgba(37, 99, 235, 0.08) 0%, transparent 50%), radial-gradient(circle at 80% 20%, rgba(8, 145, 178, 0.08) 0%, transparent 50%), radial-gradient(circle at 40% 40%, rgba(6, 182, 212, 0.05) 0%, transparent 50%), radial-gradient(circle at 60% 70%, rgba(59, 130, 246, 0.06) 0%, transparent 50%);"></div>

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
                    <i class="bi bi-box-arrow-right mr-2"></i> Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Alert Messages -->
<div class="mt-24 mx-3">
    <c:if test="${not empty error}">
        <div class="bg-gradient-to-r from-red-100/90 to-red-50/90 border-l-4 border-red-500 text-red-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up relative" role="alert">
            <i class="bi bi-exclamation-triangle-fill mr-3"></i> ${error}
            <button type="button" class="absolute top-5 right-5 text-red-600 hover:text-red-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="bg-gradient-to-r from-green-100/90 to-green-50/90 border-l-4 border-green-500 text-green-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up relative" role="alert">
            <i class="bi bi-check-circle-fill mr-3"></i> ${success}
            <button type="button" class="absolute top-5 right-5 text-green-600 hover:text-green-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </c:if>
</div>

<!-- Hero Section -->
<div class="mt-20 bg-gradient-to-r from-blue-600 to-cyan-600 text-white py-16 relative overflow-hidden">
    <div class="absolute inset-0 opacity-30" style="background-image: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'0.1\'%3E%3Ccircle cx=\'30\' cy=\'30\' r=\'2\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    <div class="container mx-auto px-4 text-center relative z-10">
        <div class="max-w-4xl mx-auto">
            <h1 class="text-5xl font-bold mb-4 animate-slide-up">
                <i class="bi bi-stethoscope mr-3"></i>Gestion des Consultations
            </h1>
            <div class="flex justify-center space-x-4 mt-6">
                <a href="specialistes" class="px-6 py-3 bg-white/20 backdrop-blur-md border border-white/30 rounded-xl font-semibold hover:bg-white/30 transition-all duration-300 hover:-translate-y-1 hover:shadow-lg">
                    <i class="bi bi-person-badge mr-2"></i>Rechercher un Spécialiste
                </a>
                <a href="consultation?action=nouvelle" class="px-6 py-3 bg-white text-blue-600 rounded-xl font-semibold hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
                    <i class="bi bi-plus-circle mr-2"></i>Nouvelle Consultation
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <!-- Patients en attente -->
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl mb-8 animate-slide-up overflow-hidden">
        <div class="bg-gradient-to-r from-amber-500 to-yellow-500 text-white px-6 py-4">
            <h5 class="text-xl font-bold mb-0"><i class="bi bi-clock-history mr-3"></i>Patients en Attente</h5>
        </div>
        <div class="p-6">
            <c:choose>
                <c:when test="${empty patientsEnAttente}">
                    <p class="text-slate-500 text-center py-4">Aucun patient en attente</p>
                </c:when>
                <c:otherwise>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b border-slate-200">
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">#</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Patient</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Heure d'arrivée</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="patient" items="${patientsEnAttente}" varStatus="status">
                                    <tr class="border-b border-slate-100 hover:bg-blue-50/50 transition-colors">
                                        <td class="px-4 py-3"><strong class="text-blue-600">${status.index + 1}</strong></td>
                                        <td class="px-4 py-3">
                                            <strong class="text-slate-800">${patient.prenom} ${patient.nom}</strong><br>
                                            <small class="text-slate-500">N° Sécu: ${patient.numeroSecuriteSociale}</small>
                                            <c:if test="${not empty patient.telephone}">
                                                <br><small class="text-slate-500">Tél: ${patient.telephone}</small>
                                            </c:if>
                                        </td>
                                        <td class="px-4 py-3">
                                            <c:choose>
                                                <c:when test="${not empty patient.heureArrivee}">
                                                    <span class="text-slate-700">${patient.heureArrivee.hour}h${patient.heureArrivee.minute < 10 ? '0' : ''}${patient.heureArrivee.minute}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-slate-400">Non définie</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-3">
                                            <a href="consultation?action=nouvelle&patientId=${patient.id}" class="px-4 py-2 bg-gradient-to-r from-green-600 to-green-500 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1 inline-block">
                                                <i class="bi bi-stethoscope mr-2"></i>Consulter
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
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl animate-slide-up overflow-hidden">
        <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4">
            <h5 class="text-xl font-bold mb-0"><i class="bi bi-clock-history mr-3"></i>Mes Consultations</h5>
        </div>
        <div class="p-6">
            <c:choose>
                <c:when test="${empty consultations}">
                    <p class="text-slate-500 text-center py-4">Aucune consultation enregistrée</p>
                </c:when>
                <c:otherwise>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b border-slate-200">
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Patient</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Motif</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Date</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Statut</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Coût Total</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="consultation" items="${consultations}">
                                    <tr class="border-b border-slate-100 hover:bg-cyan-50/50 transition-colors">
                                        <td class="px-4 py-3">
                                            <strong class="text-slate-800">${consultation.patient.prenom} ${consultation.patient.nom}</strong>
                                        </td>
                                        <td class="px-4 py-3 text-slate-600">${consultation.motif}</td>
                                        <td class="px-4 py-3 text-slate-600">
                                            ${consultation.dateConsultation.dayOfMonth}/${consultation.dateConsultation.monthValue}/${consultation.dateConsultation.year}
                                            ${consultation.dateConsultation.hour}h${consultation.dateConsultation.minute < 10 ? '0' : ''}${consultation.dateConsultation.minute}
                                        </td>
                                        <td class="px-4 py-3">
                                            <span class="px-3 py-1 rounded-lg text-xs font-semibold ${consultation.statut == 'TERMINEE' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}">
                                                ${consultation.statut}
                                            </span>
                                        </td>
                                        <td class="px-4 py-3">
                                            <strong class="text-green-600">${consultation.coutTotal} DH</strong>
                                        </td>
                                        <td class="px-4 py-3">
                                            <div class="flex space-x-2">
                                                <a href="consultation?action=details&id=${consultation.id}" class="px-3 py-1.5 bg-gradient-to-r from-blue-600 to-cyan-600 text-white text-sm rounded-lg font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5">
                                                    <i class="bi bi-eye mr-1"></i>Détails
                                                </a>
                                                <c:if test="${consultation.statut != 'TERMINEE'}">
                                                    <a href="consultation?action=actes&consultationId=${consultation.id}" class="px-3 py-1.5 bg-gradient-to-r from-amber-600 to-yellow-500 text-white text-sm rounded-lg font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5">
                                                        <i class="bi bi-tools mr-1"></i>Actes
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
</div>

</body>
</html>
