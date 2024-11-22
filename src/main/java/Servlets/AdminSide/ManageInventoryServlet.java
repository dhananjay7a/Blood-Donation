package Servlets.AdminSide;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

import Services.BloodInventoryService;

// Mapping the servlet to /admin/manageInventory to keep it under admin access
@WebServlet("/admin/manageInventory")
public class ManageInventoryServlet extends HttpServlet {
    private BloodInventoryService inventoryService = new BloodInventoryService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Integer> inventory = inventoryService.getAllInventory();
        request.setAttribute("inventory", inventory);
        request.getRequestDispatcher("/admin/jsp/manageInventory.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bloodGroup = request.getParameter("bloodGroup");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String action = request.getParameter("action");

        if ("increase".equals(action)) {
            inventoryService.updateInventory(bloodGroup, quantity);
        } else if ("decrease".equals(action)) {
            inventoryService.updateInventory(bloodGroup, -quantity);
        }

        response.sendRedirect("manageInventory");
    }
}
