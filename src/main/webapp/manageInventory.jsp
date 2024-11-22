<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="Models.User" %>
<%@ page import="Models.BloodInventory" %>
<%@ page import="Services.BloodInventoryService" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    BloodInventoryService bis = new BloodInventoryService();

    Map<String, Integer> inventory = bis.getAllInventory();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blood Inventory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 20px;
        }
        .table-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #dc3545;
        }
        .btn {
            margin-left: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Blood Inventory Section -->
    <div class="table-container">
        <h2>Blood Inventory</h2>
        <table class="table table-bordered table-hover">
            <thead class="table-danger">
                <tr>
                    <th>Blood Group</th>
                    <th>Quantity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map.Entry<String, Integer> entry : inventory.entrySet()) { %>
                    <tr>
                        <td><%= entry.getKey() %></td>
                        <td><%= entry.getValue() %> Units</td>
                        <td>
                            <form action="updateInventory" method="post" class="d-inline">
                                <input type="hidden" name="blood_group" value="<%= entry.getKey() %>">
                                <div class="input-group">
                                    <input type="number" name="quantity" class="form-control" placeholder="Enter quantity" required>
                                    <button type="submit" name="action" value="increase" class="btn btn-success btn-sm">Increase</button>
                                    <button type="submit" name="action" value="decrease" class="btn btn-danger btn-sm">Decrease</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <a href="adminDashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>

    <!-- Error and Success Messages -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger mt-3"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("msg") != null) { %>
        <div class="alert alert-success mt-3"><%= request.getAttribute("msg") %></div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
