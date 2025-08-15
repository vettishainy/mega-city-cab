<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user_email") : null;
    String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("user_name") : "Guest";

    if (userEmail == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #C6E073;
            --background: #000000;
            --text: #FFFFFF;
            --glass: rgba(0, 0, 0, 0.5);
            --overlay: rgba(0, 0, 0, 0.7);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            color: var(--text);
            min-height: 100vh;
            background: var(--background);
            position: relative;
            transition: all 0.5s ease;
        }

        .background-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--overlay);
            z-index: -1;
        }

        .navbar {
            width: 100%;
            padding: 1.5rem 2rem;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(15px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0;
            border-bottom: 1px solid var(--primary);
            box-shadow: 0 0 20px rgba(198, 224, 115, 0.1);
            z-index: 1000;
        }

        .brand {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary);
            text-shadow: 0 0 15px rgba(198, 224, 115, 0.4);
        }

        .nav-controls {
            display: flex;
            gap: 1.5rem;
            align-items: center;
        }

        .glass-btn {
            padding: 0.8rem 1.5rem;
            background: rgba(198, 224, 115, 0.1);
            border: 1px solid var(--primary);
            border-radius: 8px;
            color: var(--primary);
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .glass-btn:hover {
            background: rgba(198, 224, 115, 0.2);
            box-shadow: 0 0 20px rgba(198, 224, 115, 0.3);
        }

        .dashboard-container {
            display: flex;
            gap: 2rem;
            padding: 2rem;
            margin-top: 5rem;
        }

        .sidebar {
            width: 280px;
            height: fit-content;
            background: var(--glass);
            backdrop-filter: blur(15px);
            padding: 1.5rem;
            border-radius: 15px;
            border: 1px solid rgba(198, 224, 115, 0.2);
            position: sticky;
            top: 7rem;
        }

        .nav-menu {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .nav-item {
            padding: 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .nav-item:hover {
            background: rgba(198, 224, 115, 0.1);
            transform: translateX(5px);
        }

        .nav-link {
            color: var(--text);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.1rem;
        }

        .nav-link i {
            width: 25px;
            font-size: 1.2rem;
        }

        .dashboard-content {
            flex: 1;
            display: grid;
            gap: 2rem;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .glass-card {
            background: var(--glass);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 15px;
            border: 1px solid rgba(198, 224, 115, 0.2);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 30px rgba(198, 224, 115, 0.2);
        }

        .stat-number {
            font-size: 2.5rem;
            color: var(--primary);
            margin: 1rem 0;
            text-shadow: 0 0 15px rgba(198, 224, 115, 0.3);
        }

        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                position: relative;
                top: 0;
            }
        }
    </style>
</head>
<body>
    <div class="background-overlay"></div>
    
    <nav class="navbar">
        <span class="brand">Mega City Cab</span>
        <div class="nav-controls">
            <button class="glass-btn" id="themeToggle">
                <i class="fas fa-moon"></i>
            </button>
            <button class="glass-btn" id="backgroundToggle">
                <i class="fas fa-image"></i>
            </button>
            <a href="../logout.jsp" class="glass-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </nav>

    <div class="dashboard-container">
        <aside class="sidebar">
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="booking.jsp" class="nav-link">
                        <i class="fas fa-taxi"></i>Book Ride
                    </a>
                </li>
                <li class="nav-item">
                    <a href="bookingHistory.jsp" class="nav-link">
                        <i class="fas fa-history"></i>History
                    </a>
                </li>
                <li class="nav-item">
                    <a href="payment.jsp" class="nav-link">
                        <i class="fas fa-wallet"></i>Payment
                    </a>
                </li>
                <li class="nav-item">
                    <a href="paymentHistory.jsp" class="nav-link">
                        <i class="fas fa-receipt"></i>Receipts
                    </a>
                </li>
                <li class="nav-item">
                    <a href="vehicles.jsp" class="nav-link">
                        <i class="fas fa-car"></i>Vehicles
                    </a>
                </li>
            </ul>
        </aside>

        <main class="dashboard-content">
            <h1>Welcome Back, <%= userName %>!</h1>
            
            <div class="card-grid">
                <div class="glass-card">
                    <h3>Total Rides</h3>
                    <div class="stat-number">15</div>
                    <button class="glass-btn full-width">
                        View Details <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
                
                <div class="glass-card">
                    <h3>Active Rides</h3>
                    <div class="stat-number">2</div>
                    <button class="glass-btn full-width">
                        Track Now <i class="fas fa-location-dot"></i>
                    </button>
                </div>
                
                <div class="glass-card">
                    <h3>Total Spent</h3>
                    <div class="stat-number">$200</div>
                    <button class="glass-btn full-width">
                        Payment History <i class="fas fa-clock-rotate-left"></i>
                    </button>
                </div>
            </div>
        </main>
    </div>

    <script>
        const themes = {
            dark: {
                primary: '#C6E073',
                background: '#000000',
                text: '#FFFFFF',
                glass: 'rgba(0, 0, 0, 0.5)',
                overlay: 'rgba(0, 0, 0, 0.7)',
                image: ''
            },
            light: {
                primary: '#2A2A2A',
                background: '#FFFFFF',
                text: '#000000',
                glass: 'rgba(255, 255, 255, 0.5)',
                overlay: 'rgba(255, 255, 255, 0.3)',
                image: ''
            },
            image: {
                primary: '#C6E073',
                background: 'url("https://s3-prod.crainsnewyork.com/s3fs-public/TRANSPORTATION_131219880_AR_-1_PKYBUJGOWYMA.jpg")',
                text: '#FFFFFF',
                glass: 'rgba(0, 0, 0, 0.4)',
                overlay: 'rgba(0, 0, 0, 0.6)'
            }
        };

        const root = document.documentElement;
        const body = document.body;
        const overlay = document.querySelector('.background-overlay');

        function setTheme(theme) {
            const config = themes[theme];
            
            root.style.setProperty('--primary', config.primary);
            root.style.setProperty('--text', config.text);
            root.style.setProperty('--glass', config.glass);
            root.style.setProperty('--overlay', config.overlay);
            
            body.style.background = config.image 
                ? `${config.background} center/cover fixed`
                : config.background;

            overlay.style.display = config.image ? 'block' : 'none';
            localStorage.setItem('theme', theme);
            
            document.getElementById('themeToggle').innerHTML = theme === 'dark' 
                ? '<i class="fas fa-sun"></i>' 
                : '<i class="fas fa-moon"></i>';
        }

        document.getElementById('themeToggle').addEventListener('click', () => {
            const currentTheme = localStorage.getItem('theme') || 'dark';
            setTheme(currentTheme === 'dark' ? 'light' : 'dark');
        });

        document.getElementById('backgroundToggle').addEventListener('click', () => {
            setTheme('image');
        });

        // Initialize theme
        const savedTheme = localStorage.getItem('theme') || 'dark';
        setTheme(savedTheme);

        // Dynamic card hover effects
        document.querySelectorAll('.glass-card').forEach(card => {
            card.addEventListener('mousemove', (e) => {
                const rect = card.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                card.style.setProperty('--mouse-x', `${x}px`);
                card.style.setProperty('--mouse-y', `${y}px`);
            });
        });
    </script>
</body>
</html>