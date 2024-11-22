<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="Models.User" %>
<%@ page import="Models.BloodRequest" %>
<%@ page import="Models.Donation" %>
<%@ page import="Services.BloodRequestService" %>
<%@ page import="Services.DonationService" %>

<%
	User u = (User) session.getAttribute("user");
	if (u == null) {
	    response.sendRedirect("login.jsp");
	    return;
	}
	BloodRequestService brs = new BloodRequestService();
	DonationService ds = new DonationService();
	List<BloodRequest> requests = brs.getAllUserRequests(user.getId());
	List<Donation> donations = ds.getAllUserDonations(user.getId());
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");  // Define the desired format
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Requests</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        h2 {
            color: #dc3545;
        }
        table {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">My Blood Requests</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Blood Group</th>
                <th>Quantity</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
        <% 
        for (BloodRequest req : requests) { 
        %>
            <tr>
                <td><%= req.getBloodGroup() %></td>
                <td><%= req.getQuantity() %></td>
                <td><%= req.getStatus() %></td>
            </tr>
        <% 
        } 
        %>
        </tbody>
    </table>

    <h2 class="text-center">My Donations</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Blood Group</th>
                <th>Quantity</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
        <% 
        for (Donation donation : donations) { 
        %>
            <tr>
                <td><%= donation.getBloodGroup() %></td>
                <td><%= donation.getQuantity() %></td>
                <td>
                 <% 
                                // If date is LocalDate, format it as a string
                                if (donation.getDate() != null) {
                                    LocalDate donationDate = donation.getDate(); // Assuming donor.getDate() returns LocalDate
                                    String formattedDate = donationDate.format(formatter);
                                    out.print(formattedDate);
                                }
                  %>
                  </td>
            </tr>
        <% 
        }
        %>
        </tbody>
    </table>
    
    <div class="text-center">
        <a href="userDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
