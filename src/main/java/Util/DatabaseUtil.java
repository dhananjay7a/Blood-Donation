package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/blood_donation";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "12345678";
    

    public static Connection getConnection() throws SQLException {
    	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
