<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Quiz App - Tushar Patil</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
        }
        .about-container {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .about-container:hover {
            transform: scale(1.02);
        }
        .feature-card {
            transition: all 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
        }
    </style>
</head>
 
<body class="antialiased">
<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto bg-white rounded-xl about-container p-8">
            <header class="text-center mb-10">
                <h1 class="text-4xl font-bold text-gray-800 mb-4">About Quiz Application</h1>
                <p class="text-gray-600 text-lg">Developed by Tushar Patil</p>
            </header>

            <section class="mb-10">
                <div class="grid md:grid-cols-2 gap-8">
                    <div>
                        <h2 class="text-2xl font-semibold text-gray-700 mb-4">
                            <i class="ri-lightbulb-line mr-2 text-blue-500"></i>Project Overview
                        </h2>
                        <p class="text-gray-600 leading-relaxed">
                            This Quiz Application is a dynamic web-based platform designed to provide an interactive 
                            and engaging learning experience. Built with modern web technologies, the application 
                            offers a user-friendly interface for taking quizzes across various topics.
                        </p>
                    </div>
                    <div class="flex items-center justify-center">
                        <img src="/api/placeholder/400/300" alt="Quiz App Illustration" 
                             class="rounded-lg shadow-md">
                    </div>
                </div>
            </section>

            <section class="mb-10">
                <h2 class="text-2xl font-semibold text-gray-700 mb-6 text-center">
                    <i class="ri-star-line mr-2 text-yellow-500"></i>Key Features
                </h2>
                <div class="grid md:grid-cols-3 gap-6">
                    <div class="bg-gray-100 p-6 rounded-lg feature-card text-center">
                        <i class="ri-question-line text-4xl text-blue-500 mb-4 block"></i>
                        <h3 class="font-semibold text-xl mb-2">Dynamic Questions</h3>
                        <p class="text-gray-600">
                            Randomly selected questions that keep the quiz experience fresh and challenging.
                        </p>
                    </div>
                    <div class="bg-gray-100 p-6 rounded-lg feature-card text-center">
                        <i class="ri-bar-chart-line text-4xl text-green-500 mb-4 block"></i>
                        <h3 class="font-semibold text-xl mb-2">Instant Results</h3>
                        <p class="text-gray-600">
                            Immediate score calculation and detailed performance breakdown.
                        </p>
                    </div>
                    <div class="bg-gray-100 p-6 rounded-lg feature-card text-center">
                        <i class="ri-responsive-line text-4xl text-purple-500 mb-4 block"></i>
                        <h3 class="font-semibold text-xl mb-2">Responsive Design</h3>
                        <p class="text-gray-600">
                            Fully responsive interface that works seamlessly across devices.
                        </p>
                    </div>
                </div>
            </section>

            <section class="mb-10">
                <h2 class="text-2xl font-semibold text-gray-700 mb-6 text-center">
                    <i class="ri-code-line mr-2 text-red-500"></i>Technologies Used
                </h2>
                <div class="flex flex-wrap justify-center gap-4">
                    <span class="bg-blue-100 text-blue-800 px-4 py-2 rounded-full">JSP</span>
                    <span class="bg-green-100 text-green-800 px-4 py-2 rounded-full">Java</span>
                    <span class="bg-purple-100 text-purple-800 px-4 py-2 rounded-full">Tailwind CSS</span>
                    <span class="bg-yellow-100 text-yellow-800 px-4 py-2 rounded-full">HTML5</span>
                    <span class="bg-red-100 text-red-800 px-4 py-2 rounded-full">JavaScript</span>
                </div>
            </section>

            <section class="text-center">
                <h2 class="text-2xl font-semibold text-gray-700 mb-4">
                    <i class="ri-contact-line mr-2 text-indigo-500"></i>Contact Information
                </h2>
                <p class="text-gray-600 mb-4">
                    Feel free to reach out for any questions or suggestions
                </p>
                <div class="flex justify-center space-x-4">
                    <a href="mailto:tusharpatil@example.com" 
                       class="bg-blue-500 text-white px-6 py-3 rounded-lg hover:bg-blue-600 transition duration-300">
                        <i class="ri-mail-line mr-2"></i>Email Me
                    </a>
                    <a href="#" 
                       class="bg-gray-500 text-white px-6 py-3 rounded-lg hover:bg-gray-600 transition duration-300">
                        <i class="ri-github-line mr-2"></i>GitHub
                    </a>
                </div>
            </section>

            <footer class="mt-10 pt-6 border-t text-center">
                <p class="text-gray-500">
                    © 2025 Quiz Application. All Rights Reserved.
                </p>
            </footer>
        </div>
    </div>

    <script>
        // Optional: Add some interactive elements
        document.querySelectorAll('.feature-card').forEach(card => {
            card.addEventListener('mouseenter', (e) => {
                e.currentTarget.classList.add('shadow-lg');
            });
            card.addEventListener('mouseleave', (e) => {
                e.currentTarget.classList.remove('shadow-lg');
            });
        });
    </script>
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
</body>
</html>