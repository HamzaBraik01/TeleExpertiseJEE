<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche de Spécialistes - TéléExpertise</title>
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

<!-- Alert Messages -->
<div class="mt-24 mx-3">
    <c:if test="${not empty error}">
        <div class="bg-gradient-to-r from-red-100/90 to-red-50/90 border-l-4 border-red-500 text-red-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up relative">
            <i class="bi bi-exclamation-triangle-fill mr-3"></i>${error}
            <button type="button" class="absolute top-5 right-5 text-red-600 hover:text-red-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="bg-gradient-to-r from-green-100/90 to-green-50/90 border-l-4 border-green-500 text-green-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up relative">
            <i class="bi bi-check-circle-fill mr-3"></i>${success}
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
                <i class="bi bi-person-badge mr-3"></i>Recherche de Spécialistes
            </h1>
            <p class="text-xl opacity-90">Trouvez le spécialiste adapté à vos besoins</p>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <div class="flex justify-end mb-4">
        <a href="${pageContext.request.contextPath}/generaliste/consultation" class="px-6 py-3 bg-white/90 backdrop-blur-md border border-white/20 rounded-xl font-semibold text-slate-600 hover:text-blue-600 shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
            <i class="bi bi-arrow-left mr-2"></i>Retour aux Consultations
        </a>
    </div>

    <!-- Filtres de recherche -->
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl mb-8 animate-slide-up overflow-hidden">
        <div class="bg-gradient-to-r from-slate-700 to-slate-600 text-white px-6 py-4">
            <h5 class="text-xl font-bold mb-0"><i class="bi bi-funnel mr-3"></i>Filtres de Recherche</h5>
        </div>
        <div class="p-6">
            <form method="GET" action="specialistes">
                <input type="hidden" name="action" value="search">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label for="specialite" class="block text-sm font-semibold text-slate-700 mb-2">Spécialité</label>
                        <select class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" id="specialite" name="specialite">
                            <option value="">Toutes les spécialités</option>
                            <c:forEach var="spec" items="${specialites}">
                                <option value="${spec.name()}" ${selectedSpecialite == spec.name() ? 'selected' : ''}>
                                    ${spec.nom}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="sort" class="block text-sm font-semibold text-slate-700 mb-2">Trier par tarif</label>
                        <select class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" id="sort" name="sort">
                            <option value="asc" ${sortOrder != 'desc' ? 'selected' : ''}>Prix croissant</option>
                            <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Prix décroissant</option>
                        </select>
                    </div>
                    <div class="flex items-end space-x-2">
                        <button type="submit" class="flex-1 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                            <i class="bi bi-search mr-2"></i>Rechercher
                        </button>
                        <a href="specialistes" class="px-6 py-3 bg-slate-200 text-slate-700 rounded-xl font-semibold hover:bg-slate-300 transition-all duration-300">
                            <i class="bi bi-x-lg"></i>
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Liste des spécialistes -->
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl animate-slide-up overflow-hidden">
        <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4 flex justify-between items-center">
            <h5 class="text-xl font-bold mb-0"><i class="bi bi-people mr-3"></i>Spécialistes Disponibles</h5>
            <span class="px-4 py-2 bg-white/20 backdrop-blur-md rounded-lg font-semibold">${specialistes.size()}</span>
        </div>
        <div class="p-6">
            <c:choose>
                <c:when test="${empty specialistes}">
                    <div class="text-center py-12">
                        <i class="bi bi-search text-6xl text-slate-300 mb-4"></i>
                        <p class="text-slate-500 text-lg">Aucun spécialiste trouvé pour les critères sélectionnés</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b-2 border-slate-200">
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Spécialiste</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Spécialité</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Tarif</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Durée</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Expérience</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Disponibilité</th>
                                    <th class="px-4 py-3 text-left text-sm font-semibold text-slate-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="specialiste" items="${specialistes}">
                                    <tr class="border-b border-slate-100 hover:bg-gradient-to-r hover:from-blue-50/50 hover:to-cyan-50/50 transition-all">
                                        <td class="px-4 py-4">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-xl flex items-center justify-center mr-3 shadow-md">
                                                    <i class="bi bi-person-badge text-white"></i>
                                                </div>
                                                <div>
                                                    <strong class="text-slate-800">Dr. ${specialiste.user.prenom} ${specialiste.user.nom}</strong>
                                                    <c:if test="${not empty specialiste.numeroOrdre}">
                                                        <br><small class="text-slate-500">N° Ordre: ${specialiste.numeroOrdre}</small>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-4 py-4">
                                            <span class="px-3 py-1 bg-gradient-to-r from-slate-600 to-slate-500 text-white rounded-lg text-xs font-semibold">${specialiste.specialite.nom}</span>
                                        </td>
                                        <td class="px-4 py-4">
                                            <strong class="text-green-600 text-lg">${specialiste.tarifConsultation} DH</strong>
                                        </td>
                                        <td class="px-4 py-4 text-slate-600">
                                            ${specialiste.dureeConsultation} min
                                        </td>
                                        <td class="px-4 py-4 text-slate-600">
                                            <c:choose>
                                                <c:when test="${not empty specialiste.experience}">
                                                    ${specialiste.experience}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-slate-400">Non renseignée</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-4">
                                            <c:choose>
                                                <c:when test="${specialiste.disponible}">
                                                    <span class="px-3 py-1 bg-green-100 text-green-700 rounded-lg text-xs font-semibold">
                                                        <i class="bi bi-check-circle mr-1"></i>Disponible
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 bg-red-100 text-red-700 rounded-lg text-xs font-semibold">
                                                        <i class="bi bi-x-circle mr-1"></i>Indisponible
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-4">
                                            <div class="flex space-x-2">
                                                <a href="specialistes?action=details&id=${specialiste.id}" class="px-3 py-2 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-lg text-sm font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5" title="Voir les détails">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <c:if test="${specialiste.disponible}">
                                                    <a href="${pageContext.request.contextPath}/generaliste/creneaux?specialisteId=${specialiste.id}" class="px-3 py-2 bg-gradient-to-r from-green-600 to-green-500 text-white rounded-lg text-sm font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-0.5" title="Voir créneaux">
                                                        <i class="bi bi-calendar mr-1"></i>Créneaux
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
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mt-8">
            <div class="bg-gradient-to-br from-blue-600 to-cyan-600 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl">
                <i class="bi bi-people text-5xl mb-3 opacity-80"></i>
                <h3 class="text-4xl font-bold mb-2">${specialistes.size()}</h3>
                <p class="opacity-90 font-medium">Spécialistes trouvés</p>
            </div>
            <div class="bg-gradient-to-br from-green-600 to-green-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl">
                <i class="bi bi-currency-dollar text-5xl mb-3 opacity-80"></i>
                <c:set var="minTarif" value="999999"/>
                <c:forEach var="s" items="${specialistes}">
                    <c:if test="${s.tarifConsultation < minTarif}">
                        <c:set var="minTarif" value="${s.tarifConsultation}"/>
                    </c:if>
                </c:forEach>
                <h3 class="text-4xl font-bold mb-2">${minTarif} DH</h3>
                <p class="opacity-90 font-medium">Tarif minimum</p>
            </div>
            <div class="bg-gradient-to-br from-amber-600 to-yellow-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl">
                <i class="bi bi-currency-dollar text-5xl mb-3 opacity-80"></i>
                <c:set var="maxTarif" value="0"/>
                <c:forEach var="s" items="${specialistes}">
                    <c:if test="${s.tarifConsultation > maxTarif}">
                        <c:set var="maxTarif" value="${s.tarifConsultation}"/>
                    </c:if>
                </c:forEach>
                <h3 class="text-4xl font-bold mb-2">${maxTarif} DH</h3>
                <p class="opacity-90 font-medium">Tarif maximum</p>
            </div>
            <div class="bg-gradient-to-br from-cyan-600 to-blue-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl">
                <i class="bi bi-graph-up text-5xl mb-3 opacity-80"></i>
                <c:set var="totalTarif" value="0"/>
                <c:forEach var="s" items="${specialistes}">
                    <c:set var="totalTarif" value="${totalTarif + s.tarifConsultation}"/>
                </c:forEach>
                <h3 class="text-4xl font-bold mb-2"><fmt:formatNumber value="${totalTarif / specialistes.size()}" maxFractionDigits="0"/> DH</h3>
                <p class="opacity-90 font-medium">Tarif moyen</p>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>
