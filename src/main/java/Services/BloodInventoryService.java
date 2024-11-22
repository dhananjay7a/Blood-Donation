package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import Util.DatabaseUtil;

public class BloodInventoryService {
    public boolean updateInventory(String bloodGroup, int quantity) {
        String sql = "UPDATE bloodinventory SET quantity = quantity + ? WHERE blood_group = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setString(2, bloodGroup);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateBloodQuantity(String bloodGroup, int quantity, boolean increase) {
        String checkQuery = "SELECT quantity FROM bloodinventory WHERE blood_group = ?";
        String updateQuery = "UPDATE bloodinventory SET quantity = ? WHERE blood_group = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
             PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {

            // Check current quantity
            checkStmt.setString(1, bloodGroup);
            ResultSet rs = checkStmt.executeQuery();
            int currentQuantity = 0;

            if (rs.next()) {
                currentQuantity = rs.getInt("quantity");
            } else {
            	System.out.println("blood group not found");
                return false; // Blood group not found
            }

            // Calculate new quantity
            int newQuantity = increase ? currentQuantity + quantity : currentQuantity - quantity;

            if (newQuantity < 0) {
            	System.out.println("cannot have negative quantity");
                return false; // Cannot have negative quantity
            }

            // Update quantity in the database
            updateStmt.setInt(1, newQuantity);
            updateStmt.setString(2, bloodGroup);
            int rowsAffected = updateStmt.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("error in sql");
            return false;
        }
    }

    public int getInventoryForBloodGroup(String bloodGroup) {
        String sql = "SELECT quantity FROM bloodinventory WHERE blood_group = ?";
        int quantity = 0;

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, bloodGroup);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

    public Map<String, Integer> getAllInventory() {
        Map<String, Integer> inventory = new HashMap<>();
        String sql = "SELECT * FROM bloodinventory";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                inventory.put(rs.getString("blood_group"), rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inventory;
    }
}
