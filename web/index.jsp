<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String user = (userSession != null) ? (String) userSession.getAttribute("user") : null;
%>

<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mega City Cab - Reliable Taxi Service</title>
    <meta name="description" content="Mega City Cab - Book your ride instantly with the best rates and reliable service.">
    <meta name="keywords" content="Mega City Cab, taxi, cab booking, online ride, transport">
    <meta name="author" content="Mega City Cab Team">
    <meta name="robots" content="index, follow">
    <meta property="og:title" content="Mega City Cab - Reliable Taxi Service">
    <meta property="og:description" content="Book your ride instantly with the best rates and reliable service.">
    <meta property="og:image" content="<%= request.getContextPath() %>/assets/images/hero-bg.jpg">
    <meta property="og:url" content="https://www.megacitycab.com">

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/assets/images/favicon.png">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Custom CSS -->
    <style>
        /* Hero Section with Background Image and Glass Effect */
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)), url('<%= request.getContextPath() %>/assets/images/hero-bg.jpg') no-repeat center/cover;
            background-attachment: fixed;
            height: 100vh;
            margin-top: 56px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .hero-section .container {
            background: rgba(255, 255, 255, 0.1); /* Semi-transparent white background */
            backdrop-filter: blur(10px); /* Glass effect */
            padding: 2rem;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2); /* Light border */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        .hero-section h1 {
            font-size: 3.5rem;
            font-weight: bold;
            color: #fff;
        }
        .hero-section p {
            font-size: 1.5rem;
            color: #fff;
        }
        .hero-section .btn {
            font-size: 1.2rem;
            padding: 0.75rem 2rem;
        }

        /* Glass Effect for Cards */
        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .glass-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(198, 230, 115, 0.5), 0 0 30px rgba(198, 230, 115, 0.3);
        }

        /* Double Glowing Effect for Buttons */
        .glow-button {
            background: #C6E073;
            border: none;
            transition: all 0.3s ease;
        }
        .glow-button:hover {
            box-shadow: 0 0 15px #C6E073, 0 0 30px #C6E073;
            transform: scale(1.05);
        }

        /* Social Media Icon Hover Effect */
        .social-icon {
            transition: transform 0.3s ease, color 0.3s ease;
        }
        .social-icon:hover {
            transform: scale(1.2);
            color: #C6E073 !important;
            text-shadow: 0 0 10px #C6E073, 0 0 20px #C6E073;
        }

        /* Footer Gradient Background */
        footer {
            background: linear-gradient(135deg, #1e1e2f, #2a2a40);
            border-top: 2px solid #C6E073;
        }

        /* Key Features Section */
        .key-features {
            background: #f8f9fa;
            padding: 4rem 0;
        }
        .key-features .card i {
            font-size: 2.5rem;
            color: #C6E073;
            margin-bottom: 1rem;
        }

        /* Fade-In Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 1s ease-out;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm fixed-top">
        <div class="container">
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                   
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <% if (user == null) { %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Log In</a></li>
                        <li class="nav-item"><a class="btn glow-button text-dark px-3" href="register.jsp">Sign Up</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link" href="customer/dashboard.jsp">Dashboard</a></li>
                        <li class="nav-item">
                            <form action="LogoutController" method="post" class="d-inline">
                                <button type="submit" class="btn btn-danger text-white px-3">Logout</button>
                            </form>
                        </li>
                    <% } %>
                </ul>
            
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero-section text-center text-white d-flex align-items-center justify-content-center" 
        style="background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)), url('https://nypost.com/wp-content/uploads/sites/2/2018/04/032818cabs6bs_157198452.jpg?quality=75&strip=all') no-repeat center/cover;">
    <div class="container fade-in">
        <h1 class="display-2 fw-bold">Your Journey Starts Here with Mega City Cab</h1>
        <p class="lead fs-4">Reliable. Affordable. Safe.</p>
        <a href="<%= (user == null) ? "login.jsp" : "customer/dashboard.jsp" %>" 
           class="btn btn-lg mt-3 glow-button text-dark fw-bold px-5">Book a Ride Now</a>
    </div>
</header>

    <!-- Special Offers Section -->
    <section class="container my-5 text-center">
        <h2 class="fw-bold mb-4 text-danger">🔥 Special Offers from Mega City Cab 🔥</h2>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                    <i class="fas fa-percent fa-3x text-success mb-3"></i>
                    <h3 class="fw-bold text-success">20% Off First Ride</h3>
                    <p>Sign up and get 20% off your first ride with Mega City Cab!</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                    <i class="fas fa-star fa-3x text-primary mb-3"></i>
                    <h3 class="fw-bold text-primary">Loyalty Program</h3>
                    <p>Earn points for every ride and redeem exciting rewards with Mega City Cab.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                    <i class="fas fa-plane-departure fa-3x text-warning mb-3"></i>
                    <h3 class="fw-bold text-warning">Airport Rides at $9.99</h3>
                    <p>Enjoy a flat rate to the airport from select locations with Mega City Cab.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Key Features Section -->
    <section class="key-features">
        <div class="container text-center">
            <h2 class="fw-bold mb-5">Our Services at Mega City Cab</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                        <i class="fas fa-city fa-3x text-C6E073 mb-3"></i>
                        <h3 class="fw-bold">City Rides</h3>
                        <p>Quick and efficient transport within the city with Mega City Cab.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                        <i class="fas fa-plane-departure fa-3x text-C6E073 mb-3"></i>
                        <h3 class="fw-bold">Airport Transfers</h3>
                        <p>Hassle-free travel to and from the airport with Mega City Cab.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                        <i class="fas fa-briefcase fa-3x text-C6E073 mb-3"></i>
                        <h3 class="fw-bold">Corporate Travel</h3>
                        <p>Professional travel solutions for businesses with Mega City Cab.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                        <i class="fas fa-road fa-3x text-C6E073 mb-3"></i>
                        <h3 class="fw-bold">Long Distance</h3>
                        <p>Comfortable rides for long-distance travel with Mega City Cab.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                        <i class="fas fa-car fa-3x text-C6E073 mb-3"></i>
                        <h3 class="fw-bold">Luxury Rides</h3>
                        <p>Travel in style with our premium luxury vehicles at Mega City Cab.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card glass-card shadow-sm p-4 h-100 fade-in">
                        <i class="fas fa-clock fa-3x text-C6E073 mb-3"></i>
                        <h3 class="fw-bold">Hourly Rentals</h3>
                        <p>Flexible hourly rentals for your convenience with Mega City Cab.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5 style="color: #C6E073;">Contact Mega City Cab</h5>
                    <p class="text-white">
                        📍 Mega City Cab HQ, Main Street, Mega City<br>
                        📞 +1 234 567 890<br>
                        📧 support@megacitycab.com
                    </p>
                </div>
                <div class="col-md-4 mb-4 text-center">
                    <!-- Removed the footer logo here -->
                </div>
                <div class="col-md-4 mb-4">
                    <h5 style="color: #C6E073;">Follow Mega City Cab</h5>
                    <p class="d-flex justify-content-center">
                        <a href="https://www.facebook.com/megacitycab" class="text-white mx-2 social-icon">
                            <i class="fab fa-facebook fa-2x"></i>
                        </a>
                        <a href="https://www.instagram.com/megacitycab" class="text-white mx-2 social-icon">
                            <i class="fab fa-instagram fa-2x"></i>
                        </a>
                        <a href="https://www.twitter.com/megacitycab" class="text-white mx-2 social-icon">
                            <i class="fab fa-twitter fa-2x"></i>
                        </a>
                    </p>
                </div>
            </div>
            <hr style="border-color: #C6E073;">
            <p class="text-center mb-0 text-white">&copy; 2025 Mega City Cab. All Rights Reserved.</p>
        </div>
    </footer>

    <!-- Back-to-Top Button -->
    <button id="back-to-top" class="btn glow-button btn-lg rounded-circle shadow" style="position: fixed; bottom: 20px; right: 20px; display: none;">
        <i class="fas fa-arrow-up"></i>
    </button>

    <!-- Bootstrap Script -->
    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <!-- Back-to-Top Script -->
    <script>
        const backToTopButton = document.getElementById("back-to-top");
        window.addEventListener("scroll", () => {
            if (window.scrollY > 300) {
                backToTopButton.style.display = "block";
            } else {
                backToTopButton.style.display = "none";
            }
        });
        backToTopButton.addEventListener("click", () => {
            window.scrollTo({ top: 0, behavior: "smooth" });
        });
    </script>

    <!-- Fade-In Animation Script -->
    <script>
        const fadeInElements = document.querySelectorAll(".fade-in");
        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("visible");
                }
            });
        }, { threshold: 0.1 });

        fadeInElements.forEach((element) => {
            observer.observe(element);
        });
    </script>
</body>