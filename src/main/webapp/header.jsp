<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user != null && "user".equals(user.getRole())) {
    	
%>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	    <div class="container">
	        <a class="navbar-brand" href="#">Blood Donation System</a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	            <span class="navbar-toggler-icon"></span>
	        </button>
	        <div class="collapse navbar-collapse" id="navbarNav">
	            <ul class="navbar-nav ms-auto">
	             	<li class="nav-item">
	                    <a class="nav-link" href="MoneyDonate.jsp">Donate money</a>
	                </li>
	            	<li class="nav-item">
	                    <a class="nav-link" href="userDashboard.jsp">Dashboard</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="requestblood.jsp">Request Blood</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="donateblood.jsp">Donate Blood</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="viewRequests.jsp">View My Requests</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link text-danger" href="logout">Logout</a>
	                </li>
	            </ul>
	        </div>
	    </div>
	</nav>
<%} else if(user!=null && "admin".equals(user.getRole())) { %>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
	    <div class="container">
	        <a class="navbar-brand" href="#">Blood Donation System</a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	            <span class="navbar-toggler-icon"></span>
	        </button>
	        <div class="collapse navbar-collapse" id="navbarNav">
	            <ul class="navbar-nav ms-auto">
	            	<li class="nav-item">
	                    <a class="nav-link" href="adminDashboard.jsp">Dashboard</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="managedonors.jsp">Manage Blood Donors</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="managerequests.jsp">Manage Blood Requests</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="manageInventory.jsp">Manage Blood Inventory</a>
	                </li>
	                 <li class="nav-item">
	                    <a class="nav-link " href="viewAllPayments.jsp">view all payments</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link text-danger" href="logout">Logout</a>
	                </li>
	            </ul>
	        </div>
	    </div>
	</nav>
<% }else{
	response.sendRedirect("login.jsp");
	return;
	} %>
</body>

