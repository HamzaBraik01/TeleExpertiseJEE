<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créneaux Disponibles - TéléExpertise</title>
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
                <a href="${pageContext.request.contextPath}/generaliste/specialistes" class="px-4 py-2 text-sm font-semibold text-slate-600 hover:text-blue-600 transition-colors">
                    <i class="bi bi-people mr-2"></i>Spécialistes
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
    <div class="container mx-auto px-4 relative z-10">
        <div class="flex justify-between items-center">
            <div>
                <h1 class="text-4xl font-bold mb-2 animate-slide-up">
                    <i class="bi bi-calendar-check mr-3"></i>Créneaux Disponibles
                </h1>
                <p class="text-lg opacity-90">
                    Dr. ${specialiste.user.prenom} ${specialiste.user.nom} - ${specialiste.specialite.nom}
                </p>
            </div>
            <div class="flex space-x-3">
                <a href="${pageContext.request.contextPath}/generaliste/specialistes?action=details&id=${specialiste.id}" class="px-4 py-2 bg-white/20 backdrop-blur-md border border-white/30 rounded-xl font-semibold hover:bg-white/30 transition-all duration-300">
                    <i class="bi bi-person-badge mr-2"></i>Profil
                </a>
                <a href="${pageContext.request.contextPath}/generaliste/specialistes" class="px-4 py-2 bg-white text-blue-600 rounded-xl font-semibold hover:shadow-xl transition-all duration-300">
                    <i class="bi bi-arrow-left mr-2"></i>Retour
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <!-- Messages -->
    <c:if test="${not empty error}">
        <div class="bg-gradient-to-r from-red-100/90 to-red-50/90 border-l-4 border-red-500 text-red-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up mb-6 relative">
            <i class="bi bi-exclamation-circle mr-2"></i>${error}
            <button type="button" class="absolute top-5 right-5 text-red-600 hover:text-red-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="bg-gradient-to-r from-green-100/90 to-green-50/90 border-l-4 border-green-500 text-green-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up mb-6 relative">
            <i class="bi bi-check-circle mr-2"></i>${success}
            <button type="button" class="absolute top-5 right-5 text-green-600 hover:text-green-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </c:if>

    <!-- Filtres -->
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl mb-8 animate-slide-up overflow-hidden">
        <div class="bg-gradient-to-r from-slate-700 to-slate-600 text-white px-6 py-4">
            <h5 class="text-xl font-bold mb-0"><i class="bi bi-funnel mr-3"></i>Filtrer les Créneaux</h5>
        </div>
        <div class="p-6">
            <form method="GET" action="creneaux">
                <input type="hidden" name="action" value="filter">
                <input type="hidden" name="specialisteId" value="${specialiste.id}">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label for="date" class="block text-sm font-semibold text-slate-700 mb-2">Date</label>
                        <input type="date" class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500" id="date" name="date" value="${selectedDate}">
                    </div>
                    <div>
                        <label for="periode" class="block text-sm font-semibold text-slate-700 mb-2">Période de la journée</label>
                        <select class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500" id="periode" name="periode">
                            <option value="all" ${selectedPeriode == 'all' ? 'selected' : ''}>Toute la journée</option>
                            <option value="matin" ${selectedPeriode == 'matin' ? 'selected' : ''}>Matin (8h-12h)</option>
                            <option value="apres-midi" ${selectedPeriode == 'apres-midi' ? 'selected' : ''}>Après-midi (12h-18h)</option>
                            <option value="soir" ${selectedPeriode == 'soir' ? 'selected' : ''}>Soir (18h-20h)</option>
                        </select>
                    </div>
                    <div class="flex items-end space-x-2">
                        <button type="submit" class="flex-1 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                            <i class="bi bi-search mr-2"></i>Filtrer
                        </button>
                        <a href="creneaux?specialisteId=${specialiste.id}" class="px-6 py-3 bg-slate-200 text-slate-700 rounded-xl font-semibold hover:bg-slate-300 transition-all">
                            <i class="bi bi-x-lg"></i>
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Génération de créneaux -->
    <c:if test="${noCreneaux}">
        <div class="bg-gradient-to-r from-amber-100/90 to-yellow-100/90 border-l-4 border-amber-500 rounded-2xl shadow-xl mb-8 overflow-hidden">
            <div class="p-6">
                <h5 class="text-lg font-bold text-amber-800 mb-3"><i class="bi bi-exclamation-triangle mr-2"></i>Aucun Créneau Disponible</h5>
                <p class="text-amber-700 mb-3">Ce spécialiste n'a pas encore de créneaux disponibles dans le système.</p>
                <p class="text-amber-600 text-sm mb-4">Pour faciliter les tests, vous pouvez générer automatiquement des créneaux pour les 7 prochains jours (9h-12h et 14h-18h).</p>
                <a href="creneaux?action=generer&specialisteId=${specialiste.id}" class="inline-block px-6 py-3 bg-gradient-to-r from-amber-600 to-yellow-500 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1"
                   onclick="return confirm('Générer des créneaux de test pour ce spécialiste ?')">
                    <i class="bi bi-magic mr-2"></i>Générer des Créneaux de Test
                </a>
            </div>
        </div>
    </c:if>

    <!-- Liste des créneaux -->
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl mb-8 animate-slide-up overflow-hidden">
        <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4 flex justify-between items-center">
            <h5 class="text-xl font-bold mb-0"><i class="bi bi-clock mr-3"></i>Créneaux Disponibles</h5>
            <span class="px-4 py-2 bg-white/20 backdrop-blur-md rounded-lg font-semibold">${fn:length(creneaux)}</span>
        </div>
        <div class="p-6">
            <c:choose>
                <c:when test="${empty creneaux && !noCreneaux}">
                    <div class="text-center py-12">
                        <i class="bi bi-calendar-x text-8xl text-slate-300 mb-4"></i>
                        <p class="text-slate-500 text-lg mb-4">Aucun créneau disponible pour les critères sélectionnés.</p>
                        <a href="creneaux?specialisteId=${specialiste.id}" class="inline-block px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300">
                            Voir tous les créneaux
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:set var="currentDate" value="" />
                    <div class="space-y-8">
                        <c:forEach var="creneau" items="${creneaux}">
                            <jsp:useBean id="creneau" type="com.teleexpertise.model.Creneau"/>
                            <c:set var="creneauDate" value="${creneau.dateCreneau.toLocalDate()}" />
                            <c:if test="${currentDate != creneauDate}">
                                <c:if test="${not empty currentDate}"></div></c:if>
                                <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-2xl p-4 mb-4">
                                    <h5 class="text-lg font-bold mb-0">
                                        <i class="bi bi-calendar-day mr-2"></i>
                                        <fmt:formatDate value="${creneau.dateCreneau}" pattern="EEEE dd MMMM yyyy" />
                                    </h5>
                                </div>
                                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                                <c:set var="currentDate" value="${creneauDate}" />
                            </c:if>
                            <div class="bg-white border-2 border-slate-200 rounded-2xl p-6 text-center hover:border-blue-500 hover:shadow-xl transition-all duration-300 hover:-translate-y-2 cursor-pointer">
                                <div class="mb-4">
                                    <i class="bi bi-clock text-5xl text-blue-600"></i>
                                </div>
                                <div class="mb-4">
                                    <span class="inline-block px-6 py-3 bg-gradient-to-r from-green-600 to-green-500 text-white rounded-xl font-bold text-xl shadow-lg">
                                        <fmt:formatDate value="${creneau.dateCreneau}" pattern="HH:mm" />
                                    </span>
                                </div>
                                <p class="text-slate-600 mb-4 text-sm">
                                    ${creneau.heureDebut} - ${creneau.heureFin}
                                </p>
                                <p class="text-slate-500 text-sm mb-4">
                                    <i class="bi bi-hourglass-half mr-1"></i>${specialiste.dureeConsultation} min
                                </p>
                                <a href="${pageContext.request.contextPath}/generaliste/expertise?action=nouvelle&creneauId=${creneau.id}&specialisteId=${specialiste.id}" class="block w-full px-4 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                                    <i class="bi bi-check-circle mr-2"></i>Réserver
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Statistiques -->
    <c:if test="${not empty creneaux}">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div class="bg-gradient-to-br from-blue-600 to-cyan-600 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                <i class="bi bi-calendar-check text-5xl mb-3 opacity-80"></i>
                <h3 class="text-4xl font-bold mb-2">${fn:length(creneaux)}</h3>
                <p class="opacity-90 font-medium">Créneaux disponibles</p>
            </div>
            <div class="bg-gradient-to-br from-green-600 to-green-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                <i class="bi bi-currency-dollar text-5xl mb-3 opacity-80"></i>
                <h3 class="text-4xl font-bold mb-2">${specialiste.tarifConsultation} DH</h3>
                <p class="opacity-90 font-medium">Tarif consultation</p>
            </div>
            <div class="bg-gradient-to-br from-cyan-600 to-blue-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                <i class="bi bi-clock text-5xl mb-3 opacity-80"></i>
                <h3 class="text-4xl font-bold mb-2">${specialiste.dureeConsultation} min</h3>
                <p class="opacity-90 font-medium">Durée moyenne</p>
            </div>
            <div class="bg-gradient-to-br from-amber-600 to-yellow-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-2">
                <i class="bi bi-star text-5xl mb-3 opacity-80"></i>
                <h3 class="text-2xl font-bold mb-2">${specialiste.experience}</h3>
                <p class="opacity-90 font-medium">Expérience</p>
            </div>
        </div>
    </c:if>

    <!-- Instructions -->
    <div class="bg-gradient-to-r from-blue-100/90 to-cyan-100/90 border-l-4 border-blue-500 rounded-2xl shadow-xl p-6 mt-8">
        <h6 class="text-lg font-bold text-blue-800 mb-3"><i class="bi bi-info-circle mr-2"></i>Instructions</h6>
        <ol class="text-blue-700 space-y-2 ml-5 list-decimal">
            <li>Sélectionnez un créneau disponible en cliquant sur le bouton "Réserver"</li>
            <li>Vous serez redirigé vers le formulaire de demande d'expertise</li>
            <li>Remplissez les informations du patient et les détails de la consultation</li>
            <li>Soumettez votre demande pour confirmation</li>
        </ol>
    </div>
</div>

</body>
</html>
