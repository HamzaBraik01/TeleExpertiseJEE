<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - TeleExpertise</title>
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
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        .animate-slide-up { animation: slideInUp 0.8s ease-out; }
        .animate-fade-in { animation: fadeIn 1s ease-out; }
        .animate-pulse-custom { animation: pulse 2s infinite; }
        .stagger-1 { animation-delay: 0.1s; }
        .stagger-2 { animation-delay: 0.2s; }
        .stagger-3 { animation-delay: 0.3s; }
        .stagger-4 { animation-delay: 0.4s; }
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
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/infirmier/dashboard" class="flex items-center group">
                <div class="w-12 h-12 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-2xl flex items-center justify-center mr-3 shadow-lg shadow-blue-500/30 transition-all duration-300 group-hover:rotate-6 group-hover:scale-110">
                    <i class="bi bi-heart-pulse text-white text-2xl"></i>
                </div>
                <span class="text-2xl font-extrabold bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">TeleExpertise</span>
            </a>

            <!-- User Info & Logout -->
            <div class="flex items-center space-x-4">
                <div class="flex items-center bg-white/90 backdrop-blur-md border border-white/20 rounded-2xl px-4 py-2 shadow-lg">
                    <div class="w-9 h-9 bg-gradient-to-br from-cyan-600 to-cyan-500 rounded-xl flex items-center justify-center mr-3 shadow-md shadow-cyan-500/30">
                        <i class="bi bi-person-badge text-white"></i>
                    </div>
                    <div class="flex flex-col mr-3">
                        <span class="text-sm font-semibold text-slate-800">${user.username}</span>
                        <span class="text-xs font-medium text-white bg-gradient-to-r from-green-600 to-green-500 px-2 py-0.5 rounded-lg shadow-sm">Infirmier</span>
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
    <c:if test="${not empty sessionScope.success}">
        <div class="bg-gradient-to-r from-green-100/90 to-green-50/90 border-l-4 border-green-500 text-green-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up relative" role="alert">
            <i class="bi bi-check-circle-fill mr-3"></i> ${sessionScope.success}
            <button type="button" class="absolute top-5 right-5 text-green-600 hover:text-green-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
        <c:remove var="success" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.error}">
        <div class="bg-gradient-to-r from-red-100/90 to-red-50/90 border-l-4 border-red-500 text-red-800 px-6 py-5 rounded-2xl shadow-lg backdrop-blur-md animate-slide-up relative" role="alert">
            <i class="bi bi-exclamation-triangle-fill mr-3"></i> ${sessionScope.error}
            <button type="button" class="absolute top-5 right-5 text-red-600 hover:text-red-800" onclick="this.parentElement.remove()">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>
</div>

<!-- Hero Section -->
<div class="mt-20 bg-gradient-to-r from-blue-600 to-cyan-600 text-white py-16 relative overflow-hidden">
    <div class="absolute inset-0 opacity-30" style="background-image: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'0.1\'%3E%3Ccircle cx=\'30\' cy=\'30\' r=\'2\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    <div class="container mx-auto px-4 text-center relative z-10">
        <div class="max-w-4xl mx-auto">
            <h1 class="text-5xl font-bold mb-4 animate-slide-up">
                <i class="bi bi-heart-pulse mr-3"></i>Dashboard Infirmier
            </h1>
            <p class="text-xl opacity-90 animate-fade-in stagger-2">
                Bienvenue <strong>${user.username}</strong>, gérez efficacement les patients et optimisez la file d'attente
            </p>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <!-- Navigation Tabs -->
    <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl p-2 shadow-lg mb-8 animate-slide-up">
        <div class="flex flex-wrap gap-2">
            <a href="${pageContext.request.contextPath}/infirmier/dashboard"
               class="flex-1 min-w-max px-6 py-4 rounded-2xl font-semibold text-center transition-all duration-300 ${empty param.action ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-lg -translate-y-1' : 'text-slate-600 hover:bg-gradient-to-r hover:from-blue-50 hover:to-cyan-50 hover:text-blue-600 hover:-translate-y-1 hover:shadow-md'}">
                <i class="bi bi-speedometer2 mr-2 text-lg"></i>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
               class="flex-1 min-w-max px-6 py-4 rounded-2xl font-semibold text-center transition-all duration-300 ${param.action == 'listPatients' || param.action == 'addPatientForm' || param.action == 'editPatientForm' || formMode != null ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-lg -translate-y-1' : 'text-slate-600 hover:bg-gradient-to-r hover:from-blue-50 hover:to-cyan-50 hover:text-blue-600 hover:-translate-y-1 hover:shadow-md'}">
                <i class="bi bi-people mr-2 text-lg"></i>Gestion Patients
            </a>
            <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=fileAttente"
               class="flex-1 min-w-max px-6 py-4 rounded-2xl font-semibold text-center transition-all duration-300 ${param.action == 'fileAttente' || showFileAttente ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-lg -translate-y-1' : 'text-slate-600 hover:bg-gradient-to-r hover:from-blue-50 hover:to-cyan-50 hover:text-blue-600 hover:-translate-y-1 hover:shadow-md'}">
                <i class="bi bi-clock-history mr-2 text-lg"></i>File d'Attente
            </a>
            <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=searchPatients"
               class="flex-1 min-w-max px-6 py-4 rounded-2xl font-semibold text-center transition-all duration-300 ${param.action == 'searchPatients' || showSearchResults ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-lg -translate-y-1' : 'text-slate-600 hover:bg-gradient-to-r hover:from-blue-50 hover:to-cyan-50 hover:text-blue-600 hover:-translate-y-1 hover:shadow-md'}">
                <i class="bi bi-search mr-2 text-lg"></i>Recherche
            </a>
        </div>
    </div>

    <!-- Dashboard Section -->
    <c:if test="${empty param.action}">
        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-600 to-cyan-600 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-3 hover:scale-105 hover:shadow-2xl animate-slide-up stagger-1 relative overflow-hidden">
                <div class="absolute -top-12 -right-12 w-32 h-32 bg-white/10 rounded-full"></div>
                <i class="bi bi-people text-6xl mb-4 animate-pulse-custom relative z-10"></i>
                <h2 class="text-5xl font-bold mb-2 relative z-10">${not empty allPatients ? allPatients.size() : 0}</h2>
                <p class="opacity-90 font-medium relative z-10">Total Patients</p>
            </div>

            <div class="bg-gradient-to-br from-amber-600 to-yellow-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-3 hover:scale-105 hover:shadow-2xl animate-slide-up stagger-2 relative overflow-hidden">
                <div class="absolute -top-12 -right-12 w-32 h-32 bg-white/10 rounded-full"></div>
                <i class="bi bi-clock text-6xl mb-4 animate-pulse-custom relative z-10"></i>
                <h2 class="text-5xl font-bold mb-2 relative z-10">${not empty patientsEnAttente ? patientsEnAttente.size() : 0}</h2>
                <p class="opacity-90 font-medium relative z-10">En Attente</p>
            </div>

            <div class="bg-gradient-to-br from-cyan-600 to-cyan-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-3 hover:scale-105 hover:shadow-2xl animate-slide-up stagger-3 relative overflow-hidden">
                <div class="absolute -top-12 -right-12 w-32 h-32 bg-white/10 rounded-full"></div>
                <i class="bi bi-calendar-day text-6xl mb-4 animate-pulse-custom relative z-10"></i>
                <h2 class="text-5xl font-bold mb-2 relative z-10"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd"/></h2>
                <p class="opacity-90 font-medium relative z-10">Aujourd'hui</p>
            </div>

            <div class="bg-gradient-to-br from-sky-600 to-blue-500 text-white rounded-3xl shadow-xl p-6 text-center transition-all duration-300 hover:-translate-y-3 hover:scale-105 hover:shadow-2xl animate-slide-up stagger-4 relative overflow-hidden">
                <div class="absolute -top-12 -right-12 w-32 h-32 bg-white/10 rounded-full"></div>
                <i class="bi bi-activity text-6xl mb-4 animate-pulse-custom relative z-10"></i>
                <h2 class="text-5xl font-bold mb-2 relative z-10">100%</h2>
                <p class="opacity-90 font-medium relative z-10">Statut Actif</p>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 animate-fade-in stagger-3">
            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg overflow-hidden transition-all duration-500 hover:-translate-y-4 hover:scale-105 hover:shadow-2xl group relative">
                <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-blue-600 to-cyan-600 transform scale-x-0 transition-transform duration-500 group-hover:scale-x-100 origin-left"></div>
                <div class="p-6 text-center">
                    <div class="w-22 h-22 mx-auto mb-6 rounded-3xl bg-gradient-to-br from-blue-100 to-blue-200 flex items-center justify-center transition-all duration-300 group-hover:scale-110 group-hover:rotate-6">
                        <i class="bi bi-person-plus text-5xl text-blue-600"></i>
                    </div>
                    <h5 class="text-lg font-bold mb-3 text-slate-800">Ajouter Patient</h5>
                    <p class="text-slate-600 mb-6 font-medium">Enregistrer un nouveau patient dans le système médical</p>
                    <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=addPatientForm"
                       class="inline-block px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                        <i class="bi bi-plus-circle mr-2"></i>Ajouter
                    </a>
                </div>
            </div>

            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg overflow-hidden transition-all duration-500 hover:-translate-y-4 hover:scale-105 hover:shadow-2xl group relative">
                <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-amber-600 to-yellow-500 transform scale-x-0 transition-transform duration-500 group-hover:scale-x-100 origin-left"></div>
                <div class="p-6 text-center">
                    <div class="w-22 h-22 mx-auto mb-6 rounded-3xl bg-gradient-to-br from-amber-100 to-yellow-200 flex items-center justify-center transition-all duration-300 group-hover:scale-110 group-hover:rotate-6">
                        <i class="bi bi-clock-history text-5xl text-amber-600"></i>
                    </div>
                    <h5 class="text-lg font-bold mb-3 text-slate-800">File d'Attente</h5>
                    <p class="text-slate-600 mb-6 font-medium">Gérer les patients en attente de consultation médicale</p>
                    <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=fileAttente"
                       class="inline-block px-6 py-3 bg-gradient-to-r from-amber-600 to-yellow-500 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                        <i class="bi bi-list-ul mr-2"></i>Voir File
                    </a>
                </div>
            </div>

            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg overflow-hidden transition-all duration-500 hover:-translate-y-4 hover:scale-105 hover:shadow-2xl group relative">
                <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-cyan-600 to-cyan-500 transform scale-x-0 transition-transform duration-500 group-hover:scale-x-100 origin-left"></div>
                <div class="p-6 text-center">
                    <div class="w-22 h-22 mx-auto mb-6 rounded-3xl bg-gradient-to-br from-cyan-100 to-cyan-200 flex items-center justify-center transition-all duration-300 group-hover:scale-110 group-hover:rotate-6">
                        <i class="bi bi-search text-5xl text-cyan-600"></i>
                    </div>
                    <h5 class="text-lg font-bold mb-3 text-slate-800">Rechercher</h5>
                    <p class="text-slate-600 mb-6 font-medium">Trouver rapidement un patient spécifique par critères</p>
                    <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=searchPatients"
                       class="inline-block px-6 py-3 bg-gradient-to-r from-cyan-600 to-cyan-500 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                        <i class="bi bi-search mr-2"></i>Rechercher
                    </a>
                </div>
            </div>

            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg overflow-hidden transition-all duration-500 hover:-translate-y-4 hover:scale-105 hover:shadow-2xl group relative">
                <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-green-600 to-green-500 transform scale-x-0 transition-transform duration-500 group-hover:scale-x-100 origin-left"></div>
                <div class="p-6 text-center">
                    <div class="w-22 h-22 mx-auto mb-6 rounded-3xl bg-gradient-to-br from-green-100 to-green-200 flex items-center justify-center transition-all duration-300 group-hover:scale-110 group-hover:rotate-6">
                        <i class="bi bi-list text-5xl text-green-600"></i>
                    </div>
                    <h5 class="text-lg font-bold mb-3 text-slate-800">Liste Patients</h5>
                    <p class="text-slate-600 mb-6 font-medium">Consulter et gérer tous les patients enregistrés</p>
                    <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
                       class="inline-block px-6 py-3 bg-gradient-to-r from-green-600 to-green-500 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                        <i class="bi bi-list mr-2"></i>Liste
                    </a>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Patient Management Section -->
    <c:if test="${param.action == 'listPatients' || param.action == 'addPatientForm' || param.action == 'editPatientForm' || formMode != null}">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-bold text-slate-800"><i class="bi bi-people mr-2"></i> Gestion des Patients</h2>
            <c:if test="${param.action != 'addPatientForm' && formMode != 'add'}">
                <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=addPatientForm"
                   class="px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                    <i class="bi bi-person-plus mr-2"></i> Nouveau Patient
                </a>
            </c:if>
        </div>

        <!-- Patient Form -->
        <c:if test="${param.action == 'addPatientForm' || param.action == 'editPatientForm' || formMode != null}">
            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg mb-6 overflow-hidden">
                <div class="bg-gradient-to-r from-blue-50 to-cyan-50 border-b border-white/20 px-6 py-5">
                    <h5 class="text-xl font-bold text-slate-800">
                        <c:choose>
                            <c:when test="${formMode == 'edit' || not empty patient}">Modifier le Patient</c:when>
                            <c:otherwise>Ajouter un Patient</c:otherwise>
                        </c:choose>
                    </h5>
                </div>
                <div class="p-6">
                    <form action="${pageContext.request.contextPath}/infirmier/dashboard" method="POST">
                        <input type="hidden" name="action" value="savePatient">
                        <c:if test="${not empty patient}">
                            <input type="hidden" name="id" value="${patient.id}">
                        </c:if>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="nom" class="block text-sm font-semibold text-slate-700 mb-2">Nom *</label>
                                <input type="text" id="nom" name="nom" value="${patient.nom}" required
                                       class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">
                            </div>
                            <div>
                                <label for="prenom" class="block text-sm font-semibold text-slate-700 mb-2">Prénom *</label>
                                <input type="text" id="prenom" name="prenom" value="${patient.prenom}" required
                                       class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">
                            </div>
                            <div>
                                <label for="dateNaissance" class="block text-sm font-semibold text-slate-700 mb-2">Date de Naissance *</label>
                                <input type="date" id="dateNaissance" name="dateNaissance" value="${patient.dateNaissance}" required
                                       class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">
                            </div>
                            <div>
                                <label for="numeroSecuriteSociale" class="block text-sm font-semibold text-slate-700 mb-2">Numéro Sécurité Sociale *</label>
                                <input type="text" id="numeroSecuriteSociale" name="numeroSecuriteSociale" value="${patient.numeroSecuriteSociale}" required
                                       class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">
                            </div>
                            <div>
                                <label for="telephone" class="block text-sm font-semibold text-slate-700 mb-2">Téléphone</label>
                                <input type="tel" id="telephone" name="telephone" value="${patient.telephone}"
                                       class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">
                            </div>
                            <div>
                                <label for="mutuelle" class="block text-sm font-semibold text-slate-700 mb-2">Mutuelle</label>
                                <input type="text" id="mutuelle" name="mutuelle" value="${patient.mutuelle}"
                                       class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">
                            </div>
                            <div class="md:col-span-2">
                                <label for="adresse" class="block text-sm font-semibold text-slate-700 mb-2">Adresse</label>
                                <textarea id="adresse" name="adresse" rows="2"
                                          class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">${patient.adresse}</textarea>
                            </div>
                            <div>
                                <label for="antecedents" class="block text-sm font-semibold text-slate-700 mb-2">Antécédents</label>
                                <textarea id="antecedents" name="antecedents" rows="3"
                                          class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">${patient.antecedents}</textarea>
                            </div>
                            <div>
                                <label for="allergies" class="block text-sm font-semibold text-slate-700 mb-2">Allergies</label>
                                <textarea id="allergies" name="allergies" rows="3"
                                          class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">${patient.allergies}</textarea>
                            </div>
                            <div class="md:col-span-2">
                                <label for="traitementsCours" class="block text-sm font-semibold text-slate-700 mb-2">Traitements en Cours</label>
                                <textarea id="traitementsCours" name="traitementsCours" rows="2"
                                          class="w-full px-4 py-3 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">${patient.traitementsCours}</textarea>
                            </div>
                        </div>

                        <div class="mt-6 flex gap-3">
                            <button type="submit"
                                    class="px-6 py-3 bg-gradient-to-r from-green-600 to-green-500 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                                <i class="bi bi-save mr-2"></i> Sauvegarder
                            </button>
                            <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
                               class="px-6 py-3 bg-slate-200 text-slate-700 font-semibold rounded-xl hover:bg-slate-300 hover:-translate-y-1 transition-all duration-300">
                                <i class="bi bi-x-circle mr-2"></i> Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- Patient List -->
        <c:if test="${param.action == 'listPatients' || (param.action != 'addPatientForm' && param.action != 'editPatientForm' && formMode == null)}">
            <!-- Search Bar -->
            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg mb-6 overflow-hidden">
                <div class="bg-gradient-to-r from-cyan-50 to-blue-50 border-b border-white/20 px-6 py-4">
                    <h5 class="text-lg font-bold text-slate-800 flex items-center">
                        <i class="bi bi-search mr-2 text-cyan-600"></i>
                        Rechercher un Patient
                    </h5>
                </div>
                <div class="p-6">
                    <form action="${pageContext.request.contextPath}/infirmier/dashboard" method="GET" class="mb-4">
                        <input type="hidden" name="action" value="listPatients">
                        <div class="flex gap-3">
                            <div class="relative flex-1">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <i class="bi bi-search text-slate-400 text-lg"></i>
                                </div>
                                <input type="text"
                                       name="searchTerm"
                                       value="${param.searchTerm}"
                                       placeholder="Rechercher par nom, prénom, numéro de sécurité sociale ou téléphone..."
                                       class="w-full pl-12 pr-4 py-4 rounded-2xl border-2 border-slate-200 focus:border-cyan-500 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium text-slate-700 placeholder-slate-400 shadow-sm">
                            </div>
                            <button type="submit"
                                    class="px-6 py-4 bg-gradient-to-r from-cyan-600 to-cyan-500 text-white font-semibold rounded-2xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                                <i class="bi bi-search mr-2"></i>Rechercher
                            </button>
                            <c:if test="${not empty param.searchTerm}">
                                <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
                                   class="px-6 py-4 bg-slate-200 text-slate-700 font-semibold rounded-2xl hover:bg-slate-300 hover:-translate-y-1 transition-all duration-300">
                                    <i class="bi bi-x-circle mr-2"></i>Effacer
                                </a>
                            </c:if>
                        </div>
                    </form>

                    <div class="flex flex-wrap gap-2">
                        <span class="text-sm text-slate-600 font-medium">Filtres rapides:</span>
                        <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients&filterStatus=disponible"
                           class="px-3 py-1 text-xs font-semibold rounded-full border-2 transition-all duration-300 ${param.filterStatus == 'disponible' ? 'bg-green-500 text-white border-green-500' : 'border-green-500 text-green-600 hover:bg-green-500 hover:text-white'}">
                            <i class="bi bi-check-circle mr-1"></i>Disponibles
                        </a>
                        <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients&filterStatus=attente"
                           class="px-3 py-1 text-xs font-semibold rounded-full border-2 transition-all duration-300 ${param.filterStatus == 'attente' ? 'bg-amber-500 text-white border-amber-500' : 'border-amber-500 text-amber-600 hover:bg-amber-500 hover:text-white'}">
                            <i class="bi bi-clock mr-1"></i>En attente
                        </a>
                        <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
                           class="px-3 py-1 text-xs font-semibold rounded-full border-2 transition-all duration-300 ${empty param.filterStatus ? 'bg-slate-400 text-white border-slate-400' : 'border-slate-400 text-slate-600 hover:bg-slate-400 hover:text-white'}">
                            <i class="bi bi-list mr-1"></i>Tous
                        </a>
                    </div>
                </div>
            </div>

            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg overflow-hidden">
                <div class="bg-gradient-to-r from-blue-50 to-cyan-50 border-b border-white/20 px-6 py-5">
                    <div class="flex justify-between items-center">
                        <h5 class="text-xl font-bold text-slate-800">Liste des Patients</h5>
                        <div class="text-sm text-slate-600 font-medium">
                            <c:choose>
                                <c:when test="${not empty param.searchTerm or not empty param.filterStatus}">
                                    ${not empty filteredPatients ? filteredPatients.size() : 0} sur ${not empty allPatients ? allPatients.size() : 0} patients
                                </c:when>
                                <c:otherwise>
                                    ${not empty allPatients ? allPatients.size() : 0} patients au total
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="p-6">
                    <c:set var="patientsToDisplay" value="${not empty filteredPatients ? filteredPatients : allPatients}" />

                    <c:choose>
                        <c:when test="${not empty patientsToDisplay}">
                            <div class="overflow-x-auto rounded-2xl">
                                <table class="w-full">
                                    <thead>
                                    <tr class="bg-gradient-to-r from-slate-50 to-slate-100">
                                        <th class="px-5 py-5 text-left text-sm font-bold text-slate-700 tracking-wide">Nom Complet</th>
                                        <th class="px-5 py-5 text-left text-sm font-bold text-slate-700 tracking-wide">Date Naissance</th>
                                        <th class="px-5 py-5 text-left text-sm font-bold text-slate-700 tracking-wide">N° Sécurité Sociale</th>
                                        <th class="px-5 py-5 text-left text-sm font-bold text-slate-700 tracking-wide">Téléphone</th>
                                        <th class="px-5 py-5 text-left text-sm font-bold text-slate-700 tracking-wide">Statut</th>
                                        <th class="px-5 py-5 text-left text-sm font-bold text-slate-700 tracking-wide">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="patient" items="${patientsToDisplay}">
                                        <tr class="border-b border-slate-100 hover:bg-gradient-to-r hover:from-blue-50/50 hover:to-cyan-50/30 transition-all duration-300 hover:scale-[1.01]">
                                            <td class="px-5 py-5 font-medium text-slate-800">${patient.nomComplet}</td>
                                            <td class="px-5 py-5 font-medium text-slate-600">${patient.dateNaissance}</td>
                                            <td class="px-5 py-5 font-medium text-slate-600">${patient.numeroSecuriteSociale}</td>
                                            <td class="px-5 py-5 font-medium text-slate-600">${patient.telephone}</td>
                                            <td class="px-5 py-5">
                                                <c:if test="${patient.enAttente}">
                                                    <span class="inline-block px-4 py-2 bg-gradient-to-r from-amber-600 to-yellow-500 text-white text-xs font-semibold rounded-xl shadow-md">En attente</span>
                                                </c:if>
                                                <c:if test="${!patient.enAttente}">
                                                    <span class="inline-block px-4 py-2 bg-gradient-to-r from-green-600 to-green-500 text-white text-xs font-semibold rounded-xl shadow-md">Disponible</span>
                                                </c:if>
                                            </td>
                                            <td class="px-5 py-5">
                                                <div class="flex gap-2">
                                                    <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=editPatientForm&id=${patient.id}"
                                                       class="px-3 py-2 border-2 border-blue-600 text-blue-600 rounded-xl hover:bg-gradient-to-r hover:from-blue-600 hover:to-cyan-600 hover:text-white hover:border-transparent transition-all duration-300 hover:-translate-y-1"
                                                       title="Modifier le patient">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <c:if test="${!patient.enAttente}">
                                                        <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=addToFileAttente&patientId=${patient.id}"
                                                           class="px-3 py-2 border-2 border-amber-600 text-amber-600 rounded-xl hover:bg-gradient-to-r hover:from-amber-600 hover:to-yellow-500 hover:text-white hover:border-transparent transition-all duration-300 hover:-translate-y-1"
                                                           title="Ajouter à la file d'attente">
                                                            <i class="bi bi-clock"></i>
                                                        </a>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=deletePatient&id=${patient.id}"
                                                       class="px-3 py-2 border-2 border-red-600 text-red-600 rounded-xl hover:bg-gradient-to-r hover:from-red-600 hover:to-red-500 hover:text-white hover:border-transparent transition-all duration-300 hover:-translate-y-1"
                                                       title="Supprimer le patient"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce patient ?')">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-12">
                                <c:choose>
                                    <c:when test="${not empty param.searchTerm or not empty param.filterStatus}">
                                        <i class="bi bi-search text-6xl text-slate-400"></i>
                                        <p class="mt-4 text-slate-600 font-medium">Aucun patient trouvé</p>
                                        <p class="text-sm text-slate-500 mb-4">Essayez de modifier vos critères de recherche</p>
                                        <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
                                           class="inline-block px-6 py-3 bg-gradient-to-r from-slate-600 to-slate-500 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                                            <i class="bi bi-arrow-left mr-2"></i>Voir tous les patients
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-inbox text-6xl text-slate-400"></i>
                                        <p class="mt-4 text-slate-600 font-medium">Aucun patient enregistré</p>
                                        <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=addPatientForm"
                                           class="inline-block mt-4 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                                            <i class="bi bi-person-plus mr-2"></i> Ajouter le premier patient
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
    </c:if>

    <!-- Waiting Queue Section -->
    <c:if test="${param.action == 'fileAttente' || showFileAttente}">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-bold text-slate-800"><i class="bi bi-clock-history mr-2"></i> File d'Attente</h2>
            <span class="px-6 py-3 bg-gradient-to-r from-amber-600 to-yellow-500 text-white font-semibold rounded-xl shadow-lg text-lg">
                    ${not empty patientsEnAttente ? patientsEnAttente.size() : 0} patient(s) en attente
                </span>
        </div>

        <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg p-6">
            <c:choose>
                <c:when test="${not empty patientsEnAttente}">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <c:forEach var="patient" items="${patientsEnAttente}" varStatus="status">
                            <c:if test="${patient.enAttente}">
                                <div class="bg-gradient-to-r from-amber-50/90 to-yellow-50/90 backdrop-blur-md border-l-4 border-amber-500 rounded-2xl shadow-lg transition-all duration-500 hover:-translate-y-3 hover:scale-105 hover:shadow-2xl">
                                    <div class="p-5">
                                        <div class="flex justify-between items-start">
                                            <div>
                                                <h6 class="text-lg font-bold text-slate-800 mb-2">
                                                    <span class="inline-block px-3 py-1 bg-gradient-to-r from-amber-600 to-yellow-500 text-white font-semibold rounded-xl mr-2">${status.index + 1}</span>
                                                        ${patient.nomComplet}
                                                </h6>
                                                <p class="text-sm text-slate-600 font-medium space-y-1">
                                                    <span class="block"><i class="bi bi-calendar mr-2"></i> ${patient.age} ans</span>
                                                    <c:if test="${not empty patient.heureArrivee}">
                                                        <span class="block"><i class="bi bi-clock mr-2"></i> ${patient.heureArrivee.hour}:${patient.heureArrivee.minute < 10 ? '0' : ''}${patient.heureArrivee.minute}</span>
                                                    </c:if>
                                                    <span class="block"><i class="bi bi-telephone mr-2"></i> ${patient.telephone}</span>
                                                </p>
                                            </div>
                                            <div class="flex flex-col gap-2">
                                                <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=removeFromFileAttente&patientId=${patient.id}"
                                                   class="px-3 py-2 border-2 border-red-600 text-red-600 text-sm font-semibold rounded-xl hover:bg-gradient-to-r hover:from-red-600 hover:to-red-500 hover:text-white hover:border-transparent transition-all duration-300 hover:-translate-y-1 text-center"
                                                   onclick="return confirm('Retirer ${patient.nomComplet} de la file d\'attente ?')">
                                                    <i class="bi bi-x"></i> Retirer
                                                </a>
                                                <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=editPatientForm&id=${patient.id}"
                                                   class="px-3 py-2 border-2 border-blue-600 text-blue-600 text-sm font-semibold rounded-xl hover:bg-gradient-to-r hover:from-blue-600 hover:to-cyan-600 hover:text-white hover:border-transparent transition-all duration-300 hover:-translate-y-1 text-center">
                                                    <i class="bi bi-pencil"></i> Modifier
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <c:set var="hasPatientEnAttente" value="false" />
                    <c:forEach var="patient" items="${patientsEnAttente}">
                        <c:if test="${patient.enAttente}">
                            <c:set var="hasPatientEnAttente" value="true" />
                        </c:if>
                    </c:forEach>

                    <c:if test="${!hasPatientEnAttente}">
                        <div class="text-center py-12">
                            <i class="bi bi-clock-history text-6xl text-slate-400"></i>
                            <p class="mt-4 text-slate-600 font-medium">Aucun patient en attente actuellement</p>
                            <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
                               class="inline-block mt-4 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                                <i class="bi bi-people mr-2"></i> Voir la liste des patients
                            </a>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-12">
                        <i class="bi bi-clock-history text-6xl text-slate-400"></i>
                        <p class="mt-4 text-slate-600 font-medium">Aucun patient en attente</p>
                        <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=listPatients"
                           class="inline-block mt-4 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                            <i class="bi bi-people mr-2"></i> Voir la liste des patients
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- Search Section -->
    <c:if test="${param.action == 'searchPatients' || showSearchResults}">
        <h2 class="text-3xl font-bold text-slate-800 mb-6"><i class="bi bi-search mr-2"></i> Recherche de Patients</h2>

        <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg p-6 mb-6">
            <form action="${pageContext.request.contextPath}/infirmier/dashboard" method="GET">
                <input type="hidden" name="action" value="searchPatients">
                <div class="flex gap-3">
                    <input type="text" name="searchTerm"
                           placeholder="Rechercher par nom, prénom ou numéro de sécurité sociale..."
                           value="${searchTerm}"
                           class="flex-1 px-5 py-4 rounded-xl border-2 border-slate-200 focus:border-blue-600 focus:outline-none focus:-translate-y-1 transition-all duration-300 bg-white/90 backdrop-blur-md font-medium">
                    <button type="submit"
                            class="px-8 py-4 bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300">
                        <i class="bi bi-search mr-2"></i> Rechercher
                    </button>
                </div>
            </form>
        </div>

        <c:if test="${not empty patientsFound}">
            <div class="bg-white/95 backdrop-blur-md border border-white/20 rounded-3xl shadow-lg overflow-hidden">
                <div class="bg-gradient-to-r from-blue-50 to-cyan-50 border-b border-white/20 px-6 py-5">
                    <h5 class="text-xl font-bold text-slate-800">Résultats de recherche</h5>
                </div>
                <div class="p-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <c:forEach var="patient" items="${patientsFound}">
                            <div class="bg-white/90 backdrop-blur-md border border-green-500 border-l-4 rounded-2xl shadow-lg p-5 transition-all duration-500 hover:-translate-y-3 hover:scale-105 hover:shadow-2xl">
                                <h6 class="text-lg font-bold text-slate-800 mb-3">${patient.nomComplet}</h6>
                                <p class="text-sm text-slate-600 font-medium space-y-1 mb-4">
                                    <span class="block"><i class="bi bi-calendar mr-2"></i> ${patient.age} ans</span>
                                    <span class="block"><i class="bi bi-telephone mr-2"></i> ${patient.telephone}</span>
                                    <span class="block"><i class="bi bi-credit-card mr-2"></i> ${patient.numeroSecuriteSociale}</span>
                                </p>
                                <c:if test="${!patient.enAttente}">
                                    <a href="${pageContext.request.contextPath}/infirmier/dashboard?action=addToFileAttente&patientId=${patient.id}"
                                       class="inline-block px-5 py-2 bg-gradient-to-r from-amber-600 to-yellow-500 text-white font-semibold rounded-xl shadow-lg hover:-translate-y-1 hover:shadow-xl transition-all duration-300 text-sm">
                                        <i class="bi bi-clock mr-2"></i> Ajouter à la file
                                    </a>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
    </c:if>
</div>

<script>
    // Auto-hide alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => alert.remove(), 300);
            });
        }, 5000);

        // Progressive card animation
        const cards = document.querySelectorAll('[class*="animate-slide-up"], [class*="animate-fade-in"]');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            setTimeout(() => {
                card.style.transition = 'all 0.6s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>
</body>
</html>
