package Servlets.AdminSide;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import Models.BloodRequest;
import Models.Donation;
import Services.BloodInventoryService;
import Services.BloodRequestService;
import Services.DonationService;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private BloodRequestService requestService = new BloodRequestService();
    private DonationService donationService = new DonationService();
    private BloodInventoryService inventoryService = new BloodInventoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetching blood requests, donations, and inventory data
        List<BloodRequest> requests = requestService.getAllRequests();
        List<Donation> donations = donationService.getAllDonations();
        Map<String, Integer> inventory = inventoryService.getAllInventory();

        // Setting attributes for the JSP
        request.setAttribute("requests", requests);
        request.setAttribute("donations", donations);
        request.setAttribute("inventory", inventory);

        // Forwarding to the dashboard JSP
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
}
