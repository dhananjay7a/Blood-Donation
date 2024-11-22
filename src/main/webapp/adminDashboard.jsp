<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ include file="header.jsp" %>
<%@ page import="Models.User" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="Models.BloodRequest" %>
<%@ page import="Models.Donation" %>
<%@ page import="Services.BloodRequestService" %>
<%@ page import="Services.DonationService" %>
<%@ page import="Services.BloodInventoryService" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    BloodInventoryService bis = new BloodInventoryService();
    BloodRequestService brs = new BloodRequestService();
    DonationService ds = new DonationService();
    
    List<BloodRequest> requests = brs.getAllRequests();
    List<Donation> donations = ds.getAllDonations();
    Map<String, Integer> inventory = bis.getAllInventory();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");  // Define the desired format
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://plus.unsplash.com/premium_photo-1682309740788-04a5451ee019?q=80&w=1824&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #ffffff;
        }
        .card {
            background: rgba(0, 0, 0, 0.75);
            color: #ffffff;
            border-radius: 8px;
        }
        table {
            color: #ffffff;
        }
    </style>
</head>
<body>
	<div class="container dashboard-container">
    <h2 class="text-center" style="color: red;">Welcome, <%= user.getUsername() %></h2>
	</div>
	
    <div class="container my-5">
        <!-- Blood Requests Summary -->
        <div class="card mb-4 p-4">
            <h3 class="card-title">Blood Requests</h3>
            <table class="table table-striped table-dark">
                <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>User Name</th>
                        <th>Blood Group</th>
                        <th>Quantity</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (BloodRequest req : requests) { %>
                    <tr>
                        <td><%= req.getRequestId() %></td>
                        <td><%= req.getUsername() %></td>
                        <td><%= req.getBloodGroup() %></td>
                        <td><%= req.getQuantity() %></td>
                        <td><%= req.getStatus() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Donations Summary -->
        <div class="card mb-4 p-4">
            <h3 class="card-title">Donation Records</h3>
            <table class="table table-striped table-dark">
                <thead>
                    <tr>
                        <th>Donor ID</th>
                        <th>Donor Name</th>
                        <th>Blood Group</th>
                        <th>Quantity</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Donation donation : donations) { %>
                    <tr>
                        <td><%= donation.getDonationId() %></td>
                        <td><%= donation.getUsername() %></td>
                        <td><%= donation.getBloodGroup() %></td>
                        <td><%= donation.getQuantity() %></td>
                        <td>
                         <% 
                                // If date is LocalDate, format it as a string
                                if (donation.getDate() != null) {
                                    LocalDate donationDate = donation.getDate(); 
                                    String formattedDate = donationDate.format(formatter);
                                    out.print(formattedDate);
                                }else{
                                	out.print("not found");
                                }
                            %>
                       	</td>
                        
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Blood Inventory Summary -->
        <div class="card mb-4 p-4">
            <h3 class="card-title">Blood Inventory</h3>
            <table class="table table-striped table-dark">
                <thead>
                    <tr>
                        <th>Blood Group</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map.Entry<String, Integer> entry : inventory.entrySet()) { %>
                    <tr>
                        <td><%= entry.getKey() %></td>
                        <td><%= entry.getValue() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
