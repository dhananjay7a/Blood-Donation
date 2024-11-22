package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import Models.Donation;
import Models.User;
import Util.DatabaseUtil;
import jakarta.servlet.http.HttpSession;

public class DonationService {
    public boolean addDonation(Donation donation,User user) {
        String sql = "INSERT INTO donations (user_id, blood_group, quantity , donation_date) VALUES (?, ?, ? ,?)";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, donation.getUserId());
            stmt.setString(2, donation.getBloodGroup());
            stmt.setInt(3, donation.getQuantity());
            java.sql.Date donationDate = java.sql.Date.valueOf(donation.getDate()); // Convert LocalDate to java.sql.Date
            stmt.setDate(4, donationDate);
            if(stmt.executeUpdate() > 0) {
            	sendMsg(user.getUsername(),user.getEmail());
            	return true;
            }else {
            	return false;
            }
           
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Donation> getAllDonations() {
        List<Donation> donations = new ArrayList<>();
        String sql = "SELECT d.id, d.user_id , d.blood_group, d.quantity, u.username , d.donation_date " +
                "FROM donations d " +
                "JOIN Users u ON d.user_id = u.id";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
            	java.sql.Date sqlDate = rs.getDate("donation_date");

                // Convert java.sql.Date to LocalDate
                java.time.LocalDate donationDate = sqlDate != null ? sqlDate.toLocalDate() : null;

                // Create the Donation object with the converted LocalDate
                Donation donation = new Donation(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("blood_group"),
                    rs.getInt("quantity"),
                    rs.getString("username"),
                    donationDate 
                );
                donations.add(donation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donations;
    }
    
    //for users who donated see their donations
    public List<Donation> getAllUserDonations(int userId) {
        List<Donation> donations = new ArrayList<>();
        String sql = "SELECT * FROM donations where user_id=?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)){
        	 stmt.setInt(1, userId);
             ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
            	java.sql.Date sqlDate = rs.getDate("donation_date");

                // Convert java.sql.Date to LocalDate
                java.time.LocalDate donationDate = sqlDate != null ? sqlDate.toLocalDate() : null;
                
                Donation donation = new Donation(
                    rs.getInt("id"),
                    rs.getString("blood_group"),
                    rs.getInt("quantity"),
                    donationDate
                );
                donations.add(donation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donations;
    }
    
    public void sendMsg(String username, String email) {
        try {
            // Your Email & App Password here
            String fromMail = "dhananjay9a@gmail.com";
            String pass = "yourapp pass from your google account";
            String toMail = email;

            // Setting up Properties
            Properties pr = new Properties();
            pr.setProperty("mail.smtp.host", "smtp.gmail.com");
            pr.setProperty("mail.smtp.port", "587");
            pr.setProperty("mail.smtp.auth", "true");
            pr.setProperty("mail.smtp.starttls.enable", "true");

            // Mail Session
            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromMail, pass);
                }
            });

            // BUILDING THE EMAIL
            MimeMessage message = new MimeMessage(session);

            // Setting Receiver & Sender
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
            message.setFrom(new InternetAddress(fromMail));

            // Setting Subject
            message.setSubject("Heartfelt Thanks for Your Blood Donation!");

            // Creating the Body Part
            MimeBodyPart textBodyPart = new MimeBodyPart();
            textBodyPart.setText(
                "Dear " + username + ",\n\n" +
                "We are deeply grateful for your selfless act of donating blood. " +
                "Your generosity has the power to save lives and bring hope to many in need. " +
                "Thank you for making a difference and being a hero to someone.\n\n" +
                "Warm regards,\n" +
                "Blood Donation Team"
            );

            // Attaching an Image
			
			  MimeBodyPart imageBodyPart = new MimeBodyPart();
			  imageBodyPart.attachFile("C:\\Users\\Dhananjay\\eclipse-workspace1\\Blood Donation\\src\\main\\webapp\\images\\thankyou.jpg");
			  imageBodyPart.setHeader("Content-ID", "<thankyou>");
			 

            // Combining Text and Image
            MimeMultipart multipart = new MimeMultipart();
            multipart.addBodyPart(textBodyPart); 
            multipart.addBodyPart(imageBodyPart); 

            message.setContent(multipart);

            // Sending the Email
            Transport.send(message);

            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

