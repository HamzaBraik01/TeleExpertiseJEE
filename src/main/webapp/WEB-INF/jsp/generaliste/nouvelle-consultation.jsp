<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Consultation - Généraliste</title>
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
            <i class="bi bi-plus-circle mr-3"></i>Nouvelle Consultation
        </h1>
    </div>
</div>

<div class="container mx-auto px-4 py-8 max-w-4xl">
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-xl animate-slide-up overflow-hidden">
        <div class="bg-gradient-to-r from-blue-600 to-cyan-600 text-white px-6 py-4">
            <h4 class="text-xl font-bold mb-0"><i class="bi bi-plus-circle mr-3"></i>Nouvelle Consultation</h4>
        </div>
        <div class="p-8">
            <c:choose>
                <c:when test="${not empty patient}">
                    <!-- Informations du patient sélectionné -->
                    <div class="bg-gradient-to-r from-blue-100/90 to-cyan-100/90 border-l-4 border-blue-500 rounded-2xl p-6 mb-6 shadow-md">
                        <h5 class="text-lg font-bold text-blue-800 mb-3">
                            <i class="bi bi-person-circle mr-2"></i>Patient sélectionné
                        </h5>
                        <div class="text-slate-700">
                            <p class="mb-2"><strong class="text-blue-700">${patient.prenom} ${patient.nom}</strong></p>
                            <p class="text-sm mb-1">N° Sécurité Sociale: ${patient.numeroSecuriteSociale}</p>
                            <c:if test="${not empty patient.telephone}">
                                <p class="text-sm mb-0">Téléphone: ${patient.telephone}</p>
                            </c:if>
                        </div>
                    </div>

                    <!-- Formulaire de consultation -->
                    <form action="consultation" method="post" class="space-y-6">
                        <input type="hidden" name="action" value="creer">
                        <input type="hidden" name="patientId" value="${patient.id}">

                        <div>
                            <label for="motif" class="block text-sm font-semibold text-slate-700 mb-2">
                                Motif de consultation *
                            </label>
                            <input type="text"
                                   class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                   id="motif"
                                   name="motif"
                                   placeholder="Ex: fièvre, toux, douleurs abdominales..."
                                   required>
                        </div>

                        <div>
                            <label for="observations" class="block text-sm font-semibold text-slate-700 mb-2">
                                Observations médicales
                            </label>
                            <textarea class="w-full px-4 py-3 border border-slate-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                                      id="observations"
                                      name="observations"
                                      rows="4"
                                      placeholder="Notez vos observations à l'examen du patient..."></textarea>
                        </div>

                        <div class="bg-gradient-to-r from-green-100/90 to-green-50/90 border-l-4 border-green-500 rounded-2xl p-5 shadow-md">
                            <i class="bi bi-info-circle text-green-700 mr-2"></i>
                            <strong class="text-green-800">Information :</strong>
                            <span class="text-green-700"> Le coût de base de cette consultation sera de <strong>150 DH</strong>.</span>
                        </div>

                        <div class="flex gap-4 justify-end pt-4">
                            <a href="consultation" class="px-6 py-3 bg-slate-200 text-slate-700 rounded-xl font-semibold hover:bg-slate-300 transition-all duration-300 hover:-translate-y-1">
                                <i class="bi bi-arrow-left mr-2"></i>Retour
                            </a>
                            <button type="submit" class="px-6 py-3 bg-gradient-to-r from-green-600 to-green-500 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                                <i class="bi bi-save mr-2"></i>Enregistrer la Consultation
                            </button>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <!-- Aucun patient sélectionné -->
                    <div class="text-center py-12">
                        <i class="bi bi-exclamation-triangle text-8xl text-amber-400 mb-6"></i>
                        <h5 class="text-2xl font-bold text-slate-800 mb-3">Aucun patient sélectionné</h5>
                        <p class="text-slate-500 mb-6">Veuillez sélectionner un patient depuis la liste des patients en attente.</p>
                        <a href="consultation" class="inline-block px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
                            <i class="bi bi-arrow-left mr-2"></i>Retour à la liste des patients
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

</body>
</html>
