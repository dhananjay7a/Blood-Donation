package Services;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Util.DatabaseUtil;

public class PaymentService{
	public boolean addPaymentDetails(String name , String phone , String amount ,String paymentId) {
		String sql = "INSERT INTO payments ( name, phone, amount, paymentId) VALUES ( ?, ?, ?, ?)";
		try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	            stmt.setString(1, name); 
	            stmt.setString(2, phone);
	            stmt.setString(3, amount);
	            stmt.setString(4, paymentId);
	            
	            return stmt.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	}
	public List<Map<String , String>> getAllPayments(){
		String query = "select * from payments";
        List<Map<String, String>> payments = new ArrayList<>();
		 try (Connection conn = DatabaseUtil.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query);
	             ResultSet rs = ps.executeQuery()) {

	          
	            // Store data in request attribute
	            while (rs.next()) {
	                Map<String, String> payment = new HashMap<>();
	                payment.put("order_id", rs.getString("id"));
	                payment.put("name", rs.getString("name"));
	                payment.put("phone", rs.getString("phone"));
	                payment.put("amount", rs.getString("amount"));
	                payment.put("payment_id", rs.getString("paymentId"));
	                payment.put("time", rs.getString("created_at"));
	                payments.add(payment);
	            }

		 }catch (SQLException e) {
	       e.printStackTrace();
			 
		 }
		 return payments;

	}
}