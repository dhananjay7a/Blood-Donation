package Servlets.UserSide;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Models.BloodRequest;
import Models.User;
import Services.BloodRequestService;

/**
 * Servlet implementation class RequestBloodServlet
 */
@WebServlet("/RequestBlood")
public class RequestBloodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BloodRequestService bloodRequestService = new BloodRequestService();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    User user = (User) session.getAttribute("user");

	    String bloodGroup = request.getParameter("bloodGroup");
	    int quantity = Integer.parseInt(request.getParameter("quantity"));

	    BloodRequest bloodRequest = new BloodRequest(user.getId(), bloodGroup, quantity, "Pending");
		if(bloodRequestService .addRequest(bloodRequest)) {
			response.sendRedirect("userDashboard.jsp");
		}else {
			response.sendRedirect("requestblood.jsp");
		}
	}

}
