package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Models.User;
import Services.UserService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String bloodGroup = request.getParameter("bloodGroup");
        String isAdmin = request.getParameter("isAdmin");
        User user = new User();
        // Create a new user object
        
        if(isAdmin!=null || isAdmin.equals("admin")) {
        	user.setUsername(username);
        	user.setPassword(password);
        	user.setEmail(email);
        	user.setBloodGroup(bloodGroup);
        	user.setRole("admin");
        }else {
        	user.setUsername(username);
        	user.setPassword(password);
        	user.setEmail(email);
        	user.setBloodGroup(bloodGroup);
        	user.setRole("user");
        }

        try {
			int otp = (int)(Math.random() * 9000) + 1000;
			HttpSession session = request.getSession();
	        session.setAttribute("otp", otp);
	        session.setAttribute("email", email);
	        session.setAttribute("user", user);
	        user.sendNotificationToUser(otp);
	        response.sendRedirect("otp_verification.jsp");
	        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}



