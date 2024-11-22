package Servlets.PaymentSide;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Services.PaymentService;

/**
 * Servlet implementation class StorePaymentServlet
 */
@WebServlet("/storePayment")
public class StorePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PaymentService paymentService = new PaymentService();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 String paymentId = request.getParameter("paymentId");
		 String name = request.getParameter("name");
		 String phoneNo = request.getParameter("phoneno");
		 String amount = request.getParameter("amount");
		 if(paymentService.addPaymentDetails(name, phoneNo, amount, paymentId)) {
			 response.getWriter().write("Payment successfully stored!");
		 }else {
			 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	         response.getWriter().write("Failed to store payment details.");
		 }
	}

}
