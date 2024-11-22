package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Models.User;
import Util.DatabaseUtil;

public class UserService {
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email, blood_group, role , isDonar) VALUES (?, ?, ?, ?, ?,?)";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword()); 
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getBloodGroup());
            stmt.setString(5, user.getRole());
            stmt.setBoolean(6, false);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User authenticateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password); // In a real app, hash the password for comparison

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"),
                                rs.getString("username"),
                                rs.getString("password"),
                                rs.getString("email"),
                                rs.getString("blood_group"),
                                rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<User> getAllDonors() {
        List<User> donors = new ArrayList<>();
        String query = "SELECT * FROM users WHERE isDonar = true"; 
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("userId"));
                user.setUsername(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setBloodGroup(rs.getString("bloodGroup"));
                donors.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return donors;
    }

	public boolean deleteUser(int id) {
		 String query = "Delete  FROM users WHERE userId = ? "; 

	        try (Connection conn = DatabaseUtil.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)){
	        	ps.setInt(1, id);
	            	 return ps.executeUpdate() > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	}
	public boolean updateUserDonor(int id) {
		 String query = "update users set isDonar= true where id = ? "; 

	        try (Connection conn = DatabaseUtil.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)){
	        	ps.setInt(1, id);
	            	 return ps.executeUpdate() > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	}
	
}
