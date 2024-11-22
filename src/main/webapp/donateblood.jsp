<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donate Blood</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://source.unsplash.com/1600x900/?blood,donation');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .form-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 10px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2, h4 {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="form-container">
            <h2>Donate Blood</h2>
            <form action="DonateBloodServlet" method="post">
                <div class="mb-3">
                    <label for="bloodGroup" class="form-label">Blood Group:</label>
                    <select name="bloodGroup" id="bloodGroup" class="form-select" required>
                        <option value="">Select Blood Group</option>
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="quantity" class="form-label">Quantity (Units):</label>
                    <input type="number" name="quantity" id="quantity" class="form-control" required min="1">
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-danger">Donate Blood</button>
                </div>
            </form>
            
            <% if (request.getAttribute("error") != null) { %>
                <h4 class="text-danger mt-3"><%= request.getAttribute("error") %></h4>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
