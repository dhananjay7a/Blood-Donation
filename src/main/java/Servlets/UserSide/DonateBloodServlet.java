package Servlets.UserSide;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

import Models.Donation;
import Models.User;
import Services.BloodInventoryService;
import Services.DonationService;
import Services.UserService;

@WebServlet("/DonateBloodServlet")
public class DonateBloodServlet extends HttpServlet {

    private BloodInventoryService bloodInventoryService = new BloodInventoryService();
    private DonationService donationService = new DonationService();
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data from donateBlood.jsp
        String bloodGroup = request.getParameter("bloodGroup");
        int quantity;
        
        try {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid quantity");
            request.getRequestDispatcher("donateblood.jsp").forward(request, response);
            return;
        }

        // Get the current user from the session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Update the blood inventory
        boolean inventoryUpdated = bloodInventoryService.updateBloodQuantity(bloodGroup, quantity,true);
        if (!inventoryUpdated) {
            request.setAttribute("error", "Unable to update blood inventory. Please try again.");
            request.getRequestDispatcher("donateblood.jsp").forward(request, response);
            return;
        }

        // Create a new Donation record and save it
        Donation donation = new Donation(user.getId(),bloodGroup,quantity,LocalDate.now());

        boolean donationSaved = donationService.addDonation(donation,user);
        if (!donationSaved) {
            request.setAttribute("error", "Error in saving donation record. Please try again.");
            request.getRequestDispatcher("donateblood.jsp").forward(request, response);
            return;
        }
        boolean userIsDonor = userService.updateUserDonor(user.getId());

        // Success message and redirect
        request.setAttribute("success", "Thank you for your donation!");
        request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
    }
}
