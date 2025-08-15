<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Mega City Cab</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        /* Custom Styles */
        body {
            background: linear-gradient(135deg, #C6E073, #A8D46D);
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        header {
            width: 100%;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo h1 {
            color: #000000;
            font-weight: bold;
            margin: 0;
        }

        nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 1.5rem;
        }

        nav ul li a {
            text-decoration: none;
            color: #000000;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        nav ul li a:hover {
            color: #C6E073;
        }

        .register-btn {
            background: linear-gradient(135deg, #C6E073, #A8D46D);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            color: #000000;
            box-shadow: 0 4px 15px rgba(198, 224, 115, 0.4);
            transition: all 0.3s ease;
        }

        .register-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(198, 224, 115, 0.6);
        }

        .about {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 2rem;
            width: 90%;
            max-width: 800px;
            margin: 2rem 0;
            text-align: center;
        }

        .about h2 {
            color: #000000;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        .about p {
            color: #333333;
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        footer {
            width: 100%;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            box-shadow: 0 -4px 30px rgba(0, 0, 0, 0.1);
            border-top: 1px solid rgba(255, 255, 255, 0.3);
            padding: 1rem;
            text-align: center;
            color: #000000;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <header>
        <div class="logo">
            <h1>Mega City Cab</h1>
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="auth/login.jsp">Login</a></li>
                <li><a href="auth/register.jsp" class="register-btn">Sign Up</a></li>
            </ul>
        </nav>
    </header>

    <!-- About Section -->
    <section class="about">
        <h2>About MC_CAB</h2>
        <p>MC_CAB is a fast, reliable, and affordable cab booking service designed to make your travel easier.</p>
        <p>Our mission is to provide a seamless and safe transportation experience for our customers.</p>
        <p>With real-time tracking, verified drivers, and a user-friendly interface, MC_CAB ensures a smooth ride every time.</p>
    </section>

    <!-- Footer -->
    <footer>
        <p>© 2025 MC_CAB. All Rights Reserved.</p>
    </footer>

</body>
</html>