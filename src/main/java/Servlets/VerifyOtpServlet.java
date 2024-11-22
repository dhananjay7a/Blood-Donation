package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import Models.User;
import Services.UserService;

/**
 * Servlet implementation class VerifyOtpServlet
 */
@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService uservice = new UserService();
		int  enteredOtp = Integer.parseInt(request.getParameter("otp"));

        // Get the OTP saved in the session
        HttpSession session = request.getSession();
        int savedOtp = (int) session.getAttribute("otp");

        // Verify if the entered OTP matches the saved OTP
        if (enteredOtp == savedOtp) {
            // OTP is correct
        	User user = (User) session.getAttribute("user");
   
                // Save user details to the database
        	if(uservice.registerUser(user) ) { 
                	//otp verified
                	response.getWriter().write("success");
        	}else {
                	
                // Handle exception (e.g., log error, redirect to an error page)
                response.getWriter().write("DataFieldError");
                response.sendRedirect("registration.jsp");
        	}
                
        }else {
        	//otp failed
        	response.getWriter().write("failure");
        }
	}
}
