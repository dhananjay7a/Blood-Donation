package Servlets.BloodInventory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Models.BloodInventory;
import Services.BloodInventoryService;

/**
 * Servlet implementation class UpdateInventoryServlet
 */
@WebServlet("/updateInventory")
public class UpdateInventoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private BloodInventoryService bloodInventoryService;
	 public void init() throws ServletException {
	        super.init();
	        bloodInventoryService = new BloodInventoryService();
	    }
	 
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String bloodGroup = request.getParameter("blood_group");
	    String quantityParam = request.getParameter("quantity");
	    String action = request.getParameter("action");

	    if (action != null && bloodGroup != null) {
	        int quantity = 0;
	        try {
	            quantity = Integer.parseInt(quantityParam);
	        } catch (NumberFormatException e) {
	            request.setAttribute("error", "Invalid quantity");
	            request.getRequestDispatcher("manageInventory.jsp").forward(request, response);
	            return;
	        }

	        boolean success = false;
	        if (action.equals("increase")) {
	            if(success = bloodInventoryService.updateBloodQuantity(bloodGroup, quantity, true)) {
	            	 request.setAttribute("msg", "increased Successfully");
	            }
	        } else if (action.equals("decrease")) {
	            if(success = bloodInventoryService.updateBloodQuantity(bloodGroup, quantity, false)) {
	            	request.setAttribute("msg", "decreased Successfully");
	            }
	        }

	        if (success) {
	            response.sendRedirect("manageInventory.jsp");
	        } else {
	            request.setAttribute("error", "Failed to update inventory");
	            request.getRequestDispatcher("manageInventory.jsp").forward(request, response);
	        }
	    } else {
	        request.setAttribute("error", "Invalid request parameters");
	        request.getRequestDispatcher("manageInventory.jsp").forward(request, response);
	    }
	}

	

}
