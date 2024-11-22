<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="Models.User" %>
<%@ page import="Models.Donation" %>
<%@ page import="Services.DonationService" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    DonationService ds = new DonationService();
   
    List<Donation> donors = ds.getAllDonations();
    
    String sortOrder = request.getParameter("sortOrder");
    if (sortOrder == null || "asc".equals(sortOrder)) {
        donors.sort(Comparator.comparing(Donation::getQuantity));
        sortOrder = "desc";  // Set next toggle to descending
    } else {
        donors.sort(Comparator.comparing(Donation::getQuantity).reversed());
        sortOrder = "asc";  // Set next toggle to ascending
    }
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");  // Define the desired format
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Donors </title>
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
            margin-top: 20px;
            margin-bottom: 20px;
            color: #dc3545;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Manage Donors Section -->
    <div class="table-container">
        <h2>Manage Donors (Admin)</h2>
        
        <!-- Sort Toggle Form -->
        <form method="get" action="" class="mb-3">
            <input type="hidden" name="sortOrder" value="<%= sortOrder %>">
            <button type="submit" class="btn btn-primary">
                Sort by Quantity (<%= "asc".equals(sortOrder) ? "Asc" : "Desc" %>)
            </button>
        </form>
        
        <table class="table table-bordered table-hover">
            <thead class="table-danger">
                <tr>
                    <th>ID</th>
                   <th>Donor Name</th>
                    <th>Blood Group</th>
                    <th>Quantity</th>
                    <th>Date</th>
                    <th>Actions</th>
                    
                </tr>
            </thead>
            <tbody>
                <% for (Donation donor : donors) { %>
                    <tr>
                        <td><%= donor.getDonationId() %></td>
                        <td><%= donor.getUsername() %></td>
                        <td><%= donor.getBloodGroup() %></td>
                        <td><%= donor.getQuantity() %></td>
                        <td>
                         <% 
                                // If date is LocalDate, format it as a string
                                if (donor.getDate() != null) {
                                    LocalDate donationDate = donor.getDate(); // Assuming donor.getDate() returns LocalDate
                                    String formattedDate = donationDate.format(formatter);
                                    out.print(formattedDate);
                                }else{
                                	out.print("not found");
                                }
                                
                            %>
                          </td>
                        <td>
                            <form action="manageDonorsAndRequests" method="post" class="d-inline">
                                <input type="hidden" name="id" value="<%= donor.getDonationId() %>" />
                                <input type="hidden" name="action" value="deleteDonor" />
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
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
    <% }else if (request.getAttribute("msg") != null) { %>
        <div class="alert alert-success mt-3"><%= request.getAttribute("msg") %></div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
