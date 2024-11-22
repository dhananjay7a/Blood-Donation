<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="Models.User" %>
<%@ page import="Models.BloodRequest" %>
<%@ page import="Services.BloodRequestService" %>
<%@ page import="Services.UserService" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    BloodRequestService bloodRequestService = new BloodRequestService();

    List<BloodRequest> requests = bloodRequestService.getAllRequests();
    
    String sortOrder = request.getParameter("sortOrder");
    if (sortOrder == null || "asc".equals(sortOrder)) {
        requests.sort(Comparator.comparing(BloodRequest::getStatus));
        sortOrder = "desc";  // Set next toggle to descending
    } else {
        requests.sort(Comparator.comparing(BloodRequest::getStatus).reversed());
        sortOrder = "asc";  // Set next toggle to ascending
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blood Requests</title>
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
    <!-- Blood Requests Section -->
    <div class="table-container mt-5">
        <h2>Blood Requests (Admin)</h2>
        
        <!-- Sort Toggle Form -->
        <form method="get" action="" class="mb-3">
            <input type="hidden" name="sortOrder" value="<%= sortOrder %>">
            <button type="submit" class="btn btn-primary">
                Sort by Status (<%= "asc".equals(sortOrder) ? "Asc" : "Desc" %>)
            </button>
        </form>
        <table class="table table-bordered table-hover">
            <thead class="table-danger">
                <tr>
                    <th>Request ID</th>
                    <th>User Name</th>
                    <th>Blood Group</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Actions</th>
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
				            <td>
				                <!-- Reject Form -->
				                <form action="manageDonorsAndRequests" method="post" class="d-inline">
				                    <input type="hidden" name="id" value="<%= req.getRequestId() %>" />
				                    <input type="hidden" name="bloodGroup" value="<%= req.getBloodGroup() %>" />
				                    <input type="hidden" name="quantity" value="<%= req.getQuantity() %>" />
				                    <input type="hidden" name="action" value="rejectRequest" />
				                    <button type="submit" class="btn btn-danger btn-sm">Reject</button>
				                </form>
				                
				                <!-- Accept Form -->
				                <form action="manageDonorsAndRequests" method="post" class="d-inline">
				                    <input type="hidden" name="id" value="<%= req.getRequestId() %>" />
				                    <input type="hidden" name="bloodGroup" value="<%= req.getBloodGroup() %>" />
				                    <input type="hidden" name="quantity" value="<%= req.getQuantity() %>" />
				                    <input type="hidden" name="action" value="acceptRequest" />
				                    <button type="submit" class="btn btn-success btn-sm">Accept</button>
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
