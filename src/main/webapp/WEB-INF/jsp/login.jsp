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
    <style>
        @keyframes float {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.5;
            }
            50% {
                transform: translateY(-20px) rotate(180deg);
                opacity: 0.8;
            }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-slide-up {
            animation: slideInUp 0.6s ease-out;
        }

        .stagger-1 { animation-delay: 0.1s; }
        .stagger-2 { animation-delay: 0.2s; }
        .stagger-3 { animation-delay: 0.3s; }
        .stagger-4 { animation-delay: 0.4s; }

        .floating-element {
            animation: float 6s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            animation-delay: 2s;
        }

        .floating-element:nth-child(3) {
            animation-delay: 4s;
        }

        .floating-element:nth-child(4) {
            animation-delay: 1s;
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-blue-50 via-cyan-50 to-slate-50 relative overflow-x-hidden bg-fixed">

<!-- Background Effects -->
<div class="fixed inset-0 -z-20" style="background-image: radial-gradient(circle at 20% 80%, rgba(37, 99, 235, 0.15) 0%, transparent 50%), radial-gradient(circle at 80% 20%, rgba(8, 145, 178, 0.15) 0%, transparent 50%), radial-gradient(circle at 40% 40%, rgba(6, 182, 212, 0.1) 0%, transparent 50%), radial-gradient(circle at 60% 70%, rgba(59, 130, 246, 0.08) 0%, transparent 50%);"></div>

<div class="fixed inset-0 -z-10 pointer-events-none" style="background: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'0.03\'%3E%3Ccircle cx=\'30\' cy=\'30\' r=\'2\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>

<!-- Floating Decorative Elements -->
<div class="fixed inset-0 w-full h-full pointer-events-none -z-10">
    <div class="floating-element absolute rounded-full bg-gradient-to-br from-blue-600/10 to-cyan-600/10 w-20 h-20 top-[20%] left-[10%]"></div>
    <div class="floating-element absolute rounded-full bg-gradient-to-br from-blue-600/10 to-cyan-600/10 w-15 h-15 top-[60%] right-[15%]"></div>
    <div class="floating-element absolute rounded-full bg-gradient-to-br from-blue-600/10 to-cyan-600/10 w-25 h-25 bottom-[20%] left-[20%]"></div>
    <div class="floating-element absolute rounded-full bg-gradient-to-br from-blue-600/10 to-cyan-600/10 w-10 h-10 top-[30%] right-[30%]"></div>
</div>

<div class="w-full max-w-md">
    <!-- Logo and Title -->
    <div class="text-center mb-8 animate-slide-up">
        <div class="inline-flex items-center justify-center w-20 h-20 rounded-2xl mb-4 bg-gradient-to-br from-blue-600 to-cyan-600 shadow-xl shadow-blue-600/40">
            <i class="fas fa-stethoscope text-3xl text-white"></i>
        </div>
        <h1 class="text-3xl font-bold text-gray-800 mb-2 stagger-1 animate-slide-up">Télé-Expertise Médicale</h1>
        <p class="text-gray-600 stagger-2 animate-slide-up">Connectez-vous à votre compte</p>
    </div>

    <!-- Login Card -->
    <div class="bg-white/95 backdrop-blur-xl border border-white/30 rounded-2xl p-8 stagger-3 animate-slide-up shadow-2xl">
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg backdrop-blur-sm">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle text-red-500 mr-3"></i>
                    <p class="text-red-700 text-sm">${error}</p>
                </div>
            </div>
        </c:if>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/auth/login" method="post" class="space-y-6">
            <!-- CSRF Token -->
            <input type="hidden" name="csrfToken" value="${csrfToken}">

            <!-- Username Field -->
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
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 outline-none bg-white/80 backdrop-blur-sm hover:shadow-lg focus:-translate-y-1 focus:shadow-xl focus:shadow-blue-600/10"
                        placeholder="Entrez votre identifiant">
            </div>

            <!-- Password Field -->
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
                            class="w-full px-4 py-3 pr-12 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 outline-none bg-white/80 backdrop-blur-sm hover:shadow-lg focus:-translate-y-1 focus:shadow-xl focus:shadow-blue-600/10"
                            placeholder="Entrez votre mot de passe">
                    <button
                            type="button"
                            onclick="togglePassword()"
                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 transition-colors p-1 rounded-md hover:bg-gray-100">
                        <i id="eyeIcon" class="fas fa-eye"></i>
                    </button>
                </div>
            </div>

            <!-- Additional Options -->
            <div class="flex items-center justify-between text-sm">
                <label class="flex items-center cursor-pointer group">
                    <input
                            type="checkbox"
                            name="remember"
                            class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500 cursor-pointer">
                    <span class="ml-2 text-gray-600 group-hover:text-gray-800 transition-colors">Se souvenir de moi</span>
                </label>
                <a href="#" class="text-blue-600 hover:text-blue-700 hover:underline transition-colors font-medium">
                    Mot de passe oublié ?
                </a>
            </div>

            <!-- Login Button -->
            <button
                    type="submit"
                    class="w-full bg-gradient-to-br from-blue-600 to-cyan-600 text-white py-3 rounded-lg font-semibold shadow-lg shadow-blue-600/30 hover:shadow-xl hover:shadow-blue-600/40 hover:-translate-y-1 focus:ring-4 focus:ring-blue-300 active:scale-[0.98] transition-all duration-300">
                <i class="fas fa-sign-in-alt mr-2"></i>
                Se connecter
            </button>
        </form>

        <!-- Additional Information -->
        <div class="mt-6 text-center">
            <p class="text-xs text-gray-500">
                En vous connectant, vous acceptez nos conditions d'utilisation
            </p>
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

    // Auto-focus on first field and animations
    document.addEventListener('DOMContentLoaded', function() {
        const usernameInput = document.getElementById('username');
        if (usernameInput && !usernameInput.value) {
            setTimeout(() => usernameInput.focus(), 500);
        }
    });
</script>

</body>
</html>