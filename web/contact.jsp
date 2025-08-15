<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Mega City Cab</title>
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

        .contact {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 2rem;
            width: 90%;
            max-width: 600px;
            margin: 2rem 0;
        }

        .contact h2 {
            color: #000000;
            font-weight: bold;
            text-align: center;
            margin-bottom: 1rem;
        }

        .contact p {
            color: #333333;
            text-align: center;
            margin-bottom: 2rem;
        }

        .contact form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .contact label {
            font-weight: bold;
            color: #000000;
        }

        .contact input, .contact textarea {
            padding: 0.75rem;
            border-radius: 10px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .contact input:focus, .contact textarea:focus {
            border-color: #C6E073;
            box-shadow: 0 0 0 3px rgba(198, 224, 115, 0.2);
        }

        .contact button {
            background: linear-gradient(135deg, #C6E073, #A8D46D);
            border: none;
            border-radius: 25px;
            padding: 0.75rem;
            font-size: 1rem;
            font-weight: bold;
            color: #000000;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .contact button:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(198, 224, 115, 0.6);
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

    <!-- Contact Section -->
    <section class="contact">
        <h2>Contact Us</h2>
        <p>Have any questions or need help? Reach out to us!</p>
        <form action="contactServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="4" required></textarea>
            
            <button type="submit">Send Message</button>
        </form>
    </section>

    <!-- Footer -->
    <footer>
        <p>© 2025 MC_CAB. All Rights Reserved.</p>
    </footer>

</body>
</html>