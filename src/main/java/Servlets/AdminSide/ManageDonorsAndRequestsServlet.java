package Servlets.AdminSide;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import Models.BloodRequest;
import Models.User;
import Services.BloodInventoryService;
import Services.BloodRequestService;
import Services.UserService;

@WebServlet("/manageDonorsAndRequests")
public class ManageDonorsAndRequestsServlet extends HttpServlet {
	private UserService userService = new UserService();
    private BloodRequestService requestService = new BloodRequestService();
    private BloodInventoryService inventoryService = new BloodInventoryService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> donors = userService.getAllDonors();
        List<BloodRequest> requests = requestService.getAllRequests();
        request.setAttribute("donors", donors);
        request.setAttribute("requests", requests);
        request.getRequestDispatcher("manageDonorsAndRequests.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String action = request.getParameter("action");
        String bloodGroup = request.getParameter("bloodGroup");
        String quantityParam = request.getParameter("quantity");
        String idParam = request.getParameter("id");

        // Check if `quantity` or `id` is null
        if (quantityParam == null || idParam == null) {
            request.setAttribute("error", "Missing required parameters.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        int quantity = Integer.parseInt(quantityParam);
        int id = Integer.parseInt(idParam);

        if ("deleteDonor".equals(action)) {
            if (userService.deleteUser(id)) {
                request.setAttribute("msg", "Donor Deleted Successfully");
                request.getRequestDispatcher("managedonors.jsp").forward(request, response);
                return;
            }
        } else if ("rejectRequest".equals(action)) {
            if (requestService.updateRequestStatus(id, "Cancelled")) {
                request.setAttribute("msg", "Request Rejected Successfully");
                request.getRequestDispatcher("managerequests.jsp").forward(request, response);
                return;
            }
        } else if ("acceptRequest".equals(action)) {
            boolean flag = requestService.updateRequestStatus(id, "fulfilled");
            boolean flag1 = inventoryService.updateBloodQuantity(bloodGroup, quantity, false);
            if (flag && flag1) {
                request.setAttribute("msg", "Request Accepted  Successfully");
                request.getRequestDispatcher("managerequests.jsp").forward(request, response);
                return;
            }
        }

        request.setAttribute("error", "Error in managing donor and requests.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
}
