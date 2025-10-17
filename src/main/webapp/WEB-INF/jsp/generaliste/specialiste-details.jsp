<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Spécialiste - TéléExpertise</title>
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
                <a href="${pageContext.request.contextPath}/generaliste/consultation" class="px-4 py-2 text-sm font-semibold text-slate-600 hover:text-blue-600 transition-colors">
                    <i class="bi bi-stethoscope mr-2"></i>Consultations
                </a>
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
    <div class="container mx-auto px-4 text-center relative z-10">
        <h1 class="text-4xl font-bold mb-2 animate-slide-up">
            <i class="bi bi-person-badge mr-3"></i>Détails du Spécialiste
        </h1>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <div class="flex justify-end mb-4">
        <a href="${pageContext.request.contextPath}/generaliste/specialistes" class="px-6 py-3 bg-white/90 backdrop-blur-md border border-white/20 rounded-xl font-semibold text-slate-600 hover:text-blue-600 shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
            <i class="bi bi-arrow-left mr-2"></i>Retour à la liste
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="bg-gradient-to-r from-red-100/90 to-red-50/90 border-l-4 border-red-500 text-red-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up mb-6 relative">
            <i class="bi bi-exclamation-triangle-fill mr-2"></i>${error}
            <button type="button" class="absolute top-5 right-5 text-red-600 hover:text-red-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </c:if>

    <c:if test="${not empty specialiste}">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Main Content -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Informations principales -->
                <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl overflow-hidden animate-slide-up">
                    <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4">
                        <h5 class="text-xl font-bold"><i class="bi bi-id-card mr-2"></i>Informations Personnelles</h5>
                    </div>
                    <div class="p-8">
                        <div class="text-center mb-6">
                            <div class="w-24 h-24 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-full flex items-center justify-center mx-auto mb-4 shadow-xl">
                                <i class="bi bi-person-badge text-white text-5xl"></i>
                            </div>
                            <h4 class="text-2xl font-bold text-slate-800 mb-2">Dr. ${specialiste.user.prenom} ${specialiste.user.nom}</h4>
                            <p class="text-lg text-slate-600">${specialiste.specialite.nom}</p>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-slate-700">
                            <div class="p-4 bg-slate-50 rounded-xl">
                                <p class="text-sm font-semibold text-slate-500 mb-1">Email</p>
                                <p class="font-medium">${specialiste.user.email}</p>
                            </div>
                            <div class="p-4 bg-slate-50 rounded-xl">
                                <p class="text-sm font-semibold text-slate-500 mb-1">N° Ordre</p>
                                <c:choose>
                                    <c:when test="${not empty specialiste.numeroOrdre}">
                                        <p class="font-medium">${specialiste.numeroOrdre}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-slate-400">Non renseigné</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="p-4 bg-slate-50 rounded-xl md:col-span-2">
                                <p class="text-sm font-semibold text-slate-500 mb-2">Disponibilité</p>
                                <c:choose>
                                    <c:when test="${specialiste.disponible}">
                                        <span class="inline-block px-4 py-2 bg-green-100 text-green-700 rounded-lg font-semibold">
                                            <i class="bi bi-check-circle mr-2"></i>Disponible
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-block px-4 py-2 bg-red-100 text-red-700 rounded-lg font-semibold">
                                            <i class="bi bi-x-circle mr-2"></i>Indisponible
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Spécialité et Expérience -->
                <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl overflow-hidden animate-slide-up">
                    <div class="bg-gradient-to-r from-cyan-600 to-blue-500 text-white px-6 py-4">
                        <h5 class="text-xl font-bold"><i class="bi bi-award mr-2"></i>Spécialité et Expérience</h5>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <h6 class="text-lg font-bold text-blue-600 mb-3">Spécialité</h6>
                                <span class="inline-block px-4 py-2 bg-gradient-to-r from-slate-600 to-slate-500 text-white rounded-lg font-semibold mb-3">
                                    ${specialiste.specialite.nom}
                                </span>
                                <p class="text-slate-600">${specialiste.specialite.description}</p>
                            </div>
                            <div>
                                <h6 class="text-lg font-bold text-blue-600 mb-3">Expérience</h6>
                                <p class="text-slate-700 mb-4">
                                    <c:choose>
                                        <c:when test="${not empty specialiste.experience}">
                                            ${specialiste.experience}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-slate-400">Expérience non renseignée</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <h6 class="text-lg font-bold text-blue-600 mb-3">Diplômes</h6>
                                <p class="text-slate-700">
                                    <c:choose>
                                        <c:when test="${not empty specialiste.diplomes}">
                                            ${specialiste.diplomes}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-slate-400">Diplômes non renseignés</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Statistiques -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="bg-gradient-to-br from-blue-600 to-cyan-600 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                        <i class="bi bi-clipboard-check text-5xl mb-3 opacity-80"></i>
                        <h4 class="text-4xl font-bold mb-2">${specialiste.nombreExpertisesTerminees}</h4>
                        <p class="opacity-90 font-medium">Expertises terminées</p>
                    </div>
                    <div class="bg-gradient-to-br from-green-600 to-green-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                        <i class="bi bi-currency-dollar text-5xl mb-3 opacity-80"></i>
                        <h4 class="text-3xl font-bold mb-2"><fmt:formatNumber value="${specialiste.revenus}" maxFractionDigits="0"/> DH</h4>
                        <p class="opacity-90 font-medium">Revenus totaux</p>
                    </div>
                    <div class="bg-gradient-to-br from-cyan-600 to-blue-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                        <i class="bi bi-clock text-5xl mb-3 opacity-80"></i>
                        <h4 class="text-4xl font-bold mb-2">${specialiste.dureeConsultation}</h4>
                        <p class="opacity-90 font-medium">min / consultation</p>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="lg:col-span-1 space-y-6">
                <!-- Tarification -->
                <div class="bg-gradient-to-br from-amber-600 to-yellow-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                    <i class="bi bi-currency-dollar text-6xl mb-4 opacity-80"></i>
                    <h3 class="text-5xl font-bold mb-3">${specialiste.tarifConsultation} DH</h3>
                    <p class="text-lg opacity-90 font-medium">Tarif par consultation</p>
                    <p class="text-sm opacity-75 mt-2">Durée : ${specialiste.dureeConsultation} minutes</p>
                </div>

                <!-- Actions -->
                <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl overflow-hidden">
                    <div class="bg-gradient-to-r from-slate-700 to-slate-600 text-white px-6 py-4">
                        <h5 class="text-lg font-bold"><i class="bi bi-lightning mr-2"></i>Actions</h5>
                    </div>
                    <div class="p-6 space-y-3">
                        <c:if test="${specialiste.disponible}">
                            <a href="${pageContext.request.contextPath}/generaliste/creneaux?specialisteId=${specialiste.id}" class="block w-full px-6 py-4 bg-gradient-to-r from-green-600 to-green-500 text-white rounded-xl font-semibold text-center hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                                <i class="bi bi-calendar-check mr-2"></i>Voir Créneaux Disponibles
                            </a>
                            <a href="${pageContext.request.contextPath}/generaliste/expertise?action=nouvelle&specialisteId=${specialiste.id}" class="block w-full px-6 py-4 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold text-center hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                                <i class="bi bi-plus-circle mr-2"></i>Demander une Expertise
                            </a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/generaliste/specialistes" class="block w-full px-6 py-4 bg-slate-200 text-slate-700 rounded-xl font-semibold text-center hover:bg-slate-300 transition-all duration-300">
                            <i class="bi bi-search mr-2"></i>Chercher un autre Spécialiste
                        </a>
                    </div>
                </div>

                <!-- Contact -->
                <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl overflow-hidden">
                    <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4">
                        <h6 class="text-lg font-bold"><i class="bi bi-envelope mr-2"></i>Contact</h6>
                    </div>
                    <div class="p-6">
                        <a href="mailto:${specialiste.user.email}" class="flex items-center text-blue-600 hover:text-blue-700 transition-colors">
                            <i class="bi bi-envelope-fill text-2xl mr-3"></i>
                            <span class="font-medium">${specialiste.user.email}</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>
