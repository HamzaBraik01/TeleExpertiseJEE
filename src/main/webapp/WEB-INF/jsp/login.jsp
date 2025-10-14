<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Télé-Expertise Médicale</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gradient-to-br from-blue-50 via-white to-cyan-50 min-h-screen flex items-center justify-center p-4">

<div class="w-full max-w-md">
    <!-- Logo et titre -->
    <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-2xl shadow-lg mb-4">
            <i class="fas fa-stethoscope text-3xl text-white"></i>
        </div>
        <h1 class="text-3xl font-bold text-gray-800 mb-2">Télé-Expertise Médicale</h1>
        <p class="text-gray-600">Connectez-vous à votre compte</p>
    </div>

    <!-- Carte de connexion -->
    <div class="bg-white rounded-2xl shadow-xl p-8 border border-gray-100">

        <!-- Message d'erreur -->
        <c:if test="${not empty error}">
        <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg">
            <div class="flex items-center">
                <i class="fas fa-exclamation-circle text-red-500 mr-3"></i>
                <p class="text-red-700 text-sm">${error}</p>
            </div>
        </div>
        </c:if>

        <!-- Formulaire -->
        <form action="${pageContext.request.contextPath}/auth/login" method="post" class="space-y-6">

            <!-- Token CSRF -->
            <input type="hidden" name="csrfToken" value="${csrfToken}">

            <!-- Champ Username -->
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700 mb-2">
                    <i class="fas fa-user mr-2 text-gray-400"></i>
                    Nom d'utilisateur ou Email
                </label>
                <input
                        type="text"
                        id="username"
                        name="username"
                        value="<c:out value='${username}' default='' />"
                        required
                        autofocus
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none"
                        placeholder="Entrez votre identifiant">
            </div>

            <!-- Champ Password -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                    <i class="fas fa-lock mr-2 text-gray-400"></i>
                    Mot de passe
                </label>
                <div class="relative">
                    <input
                            type="password"
                            id="password"
                            name="password"
                            required
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none pr-12"
                            placeholder="Entrez votre mot de passe">
                    <button
                            type="button"
                            onclick="togglePassword()"
                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 transition">
                        <i id="eyeIcon" class="fas fa-eye"></i>
                    </button>
                </div>
            </div>

            <!-- Options supplémentaires -->
            <div class="flex items-center justify-between text-sm">
                <label class="flex items-center cursor-pointer group">
                    <input
                            type="checkbox"
                            name="remember"
                            class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500 cursor-pointer">
                    <span class="ml-2 text-gray-600 group-hover:text-gray-800 transition">Se souvenir de moi</span>
                </label>
                <a href="#" class="text-blue-600 hover:text-blue-700 hover:underline transition">
                    Mot de passe oublié ?
                </a>
            </div>

            <!-- Bouton de connexion -->
            <button
                    type="submit"
                    class="w-full bg-gradient-to-r from-blue-600 to-cyan-600 text-white py-3 rounded-lg font-semibold hover:from-blue-700 hover:to-cyan-700 focus:ring-4 focus:ring-blue-300 transition duration-200 transform hover:scale-[1.02] active:scale-[0.98] shadow-lg">
                <i class="fas fa-sign-in-alt mr-2"></i>
                Se connecter
            </button>

        </form>

        <!-- Informations supplémentaires -->
        <div class="mt-6 text-center">
            <p class="text-xs text-gray-500">
                En vous connectant, vous acceptez nos conditions d'utilisation
            </p>
        </div>

        <!-- Utilisateurs de test -->
        <div class="mt-8 bg-blue-50 rounded-xl p-4 border border-blue-200">
            <h3 class="font-semibold text-blue-800 mb-3 flex items-center">
                <i class="fas fa-info-circle mr-2"></i>
                Comptes de test disponibles
            </h3>
            <div class="space-y-2 text-sm">
                <div class="flex justify-between bg-white p-2 rounded border">
                    <span class="font-medium text-gray-700">Généraliste:</span>
                    <span class="text-blue-600 font-mono">generaliste / password123</span>
                </div>
                <div class="flex justify-between bg-white p-2 rounded border">
                    <span class="font-medium text-gray-700">Spécialiste:</span>
                    <span class="text-blue-600 font-mono">specialiste / password123</span>
                </div>
                <div class="flex justify-between bg-white p-2 rounded border">
                    <span class="font-medium text-gray-700">Infirmier:</span>
                    <span class="text-blue-600 font-mono">infirmier / password123</span>
                </div>
            </div>
        </div>
    </div>


</div>

<script>
    function togglePassword() {
        const passwordInput = document.getElementById('password');
        const eyeIcon = document.getElementById('eyeIcon');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        }
    }

    // Auto-focus sur le premier champ
    document.addEventListener('DOMContentLoaded', function() {
        const usernameInput = document.getElementById('username');
        if (usernameInput && !usernameInput.value) {
            usernameInput.focus();
        }
    });
</script>

</body>
</html>
