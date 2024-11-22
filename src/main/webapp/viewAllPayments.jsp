<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="Models.User" %>
<%@ page import="Services.PaymentService" %>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    PaymentService paymentService = new PaymentService();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        let sortOrder = "asc"; // Default sort order is ascending

        function sortPaymentsByDateTime() {
            const table = document.getElementById("paymentTable");
            if (!table) {
                console.error("Table with ID 'paymentTable' not found.");
                return;
            }

            const rows = Array.from(table.querySelectorAll("tbody tr")); // Get all rows in the tbody

            rows.sort((rowA, rowB) => {
                const dateTimeA = new Date(rowA.cells[5].innerText.trim());
                const dateTimeB = new Date(rowB.cells[5].innerText.trim());

                return sortOrder === "asc" ? dateTimeA - dateTimeB : dateTimeB - dateTimeA;
            });

            const tableBody = table.querySelector("tbody");
            if (!tableBody) {
                console.error("No <tbody> found in the table.");
                return;
            }

            tableBody.innerHTML = ""; // Clear tbody
            rows.forEach(row => tableBody.appendChild(row)); // Append sorted rows

            // Toggle the sort order for next click
            sortOrder = sortOrder === "asc" ? "desc" : "asc";
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Payment Records</h2>
        <div class="text-end mb-3">
    		<button class="btn btn-primary" onclick="sortPaymentsByDateTime()">Sort by Date and Time</button>
		</div>
        <table class="table table-bordered table-striped" id="paymentTable">
            <thead class="table-dark">
                <tr>
                    <th>Order ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Amount</th>
                    <th>Payment ID</th>
                    <th>Payment Date and Time</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Retrieve payments list from request or session
                    List<Map<String, String>> payments = (List<Map<String, String>>)paymentService.getAllPayments() ;
                    if (payments != null && !payments.isEmpty()) {
                        for (Map<String, String> payment : payments) {
                            out.println("<tr>");
                            out.println("<td>" + payment.get("order_id") + "</td>");
                            out.println("<td>" + payment.get("name") + "</td>");
                            out.println("<td>" + payment.get("phone") + "</td>");
                            out.println("<td>" + payment.get("amount") + "</td>");
                            out.println("<td>" + payment.get("payment_id") + "</td>");
                            out.println("<td>" + payment.get("time") + "</td>");
                            out.println("</tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='6' class='text-center'>No payment records found</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
