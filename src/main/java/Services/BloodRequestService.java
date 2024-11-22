package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Models.BloodRequest;
import Util.DatabaseUtil;

public class BloodRequestService {
    public boolean addRequest(BloodRequest request) {
        String sql = "INSERT INTO bloodrequests (user_id, blood_group, quantity, status) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, request.getUserId());
            stmt.setString(2, request.getBloodGroup());
            stmt.setInt(3, request.getQuantity());
            stmt.setString(4, request.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //this is for admin
    public List<BloodRequest> getAllRequests() {
    	 List<BloodRequest> requests = new ArrayList<>();
         String query = "SELECT br.id, br.user_id, br.blood_group, br.quantity, br.status, u.username " +
                        "FROM bloodrequests br " +
                        "JOIN users u ON br.user_id = u.id";
         try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             ResultSet rs = ps.executeQuery();
             while (rs.next()) {
                 BloodRequest request = new BloodRequest(
                		 rs.getInt("id"),
                		 rs.getInt("user_id"),
                		 rs.getString("blood_group"),
                		 rs.getInt("quantity"),
                		 rs.getString("status"),
                		 rs.getString("username")
                		 );
                 requests.add(request);
             }
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return requests;
     
    }
    //this is for user
    public List<BloodRequest> getAllUserRequests(int userId) {
        List<BloodRequest> requests = new ArrayList<>();
        String sql = "SELECT * FROM bloodrequests where user_id=?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);){
        	 stmt.setInt(1, userId);
             ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BloodRequest request = new BloodRequest(
                    rs.getInt("id"),
                    rs.getString("blood_group"),
                    rs.getInt("quantity"),
                    rs.getString("status")
                );
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public boolean updateRequestStatus(int requestId, String status) {
        String sql = "UPDATE bloodrequests SET status = ? WHERE id = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, requestId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

	public boolean rejectRequest(int id) {
		String sql = "Update bloodrequests set status = Cancelled  WHERE id = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
        	
            stmt.setInt(1, id);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
		
	}
}
