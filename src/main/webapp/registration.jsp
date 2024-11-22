<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .registration-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #dc3545;
        }
        .loader {
            display: none; /* Hidden by default */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 3rem;
            height: 3rem;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #dc3545;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            z-index: 9999;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

<div class="container registration-container">
    <h2 class="text-center">Register as a New User</h2>
    <form action="RegisterServlet" method="post" onsubmit="showLoader()">
        <!-- Username -->
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label for="password" class="form-label">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <!-- Blood Group -->
        <div class="mb-3">
            <label for="bloodGroup" class="form-label">Blood Group:</label>
            <select class="form-select" name="bloodGroup" id="bloodGroup" required>
                <option value="A+">A+</option>
                <option value="A-">A-</option>
                <option value="B+">B+</option>
                <option value="B-">B-</option>
                <option value="AB+">AB+</option>
                <option value="AB-">AB-</option>
                <option value="O+">O+</option>
                <option value="O-">O-</option>
            </select>
        </div>

        <!-- Admin Checkbox -->
        <input type="hidden" name="isAdmin" value="user">
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="isAdmin" name="isAdmin" value="admin">
            <label class="form-check-label" for="isAdmin">Register as Admin</label>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-danger w-100">Register</button>
    </form>

    <div class="text-center mt-3">
        <h6>Already a user?</h6>
        <a href="login.jsp" class="btn btn-outline-primary">Login here</a>
    </div>
</div>

<!-- Loader -->
<div class="loader" id="loader"></div>

<script>
    function showLoader() {
        document.getElementById('loader').style.display = 'block';
    }
</script>

</body>
</html>
