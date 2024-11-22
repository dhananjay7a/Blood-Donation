package Models;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class User {
    private int id;
    private String username;
    private String password;
    private String email;
    private String bloodGroup;
    private String role;
    private boolean isDonar;

    public User() {
		
	}
	public boolean isDonar() {
		return isDonar;
	}
	public void setDonar(boolean isDonar) {
		this.isDonar = isDonar;
	}
	public User(int id ,String username, String password, String email, String bloodGroup, String role) {
    	this.id=id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.bloodGroup = bloodGroup;
        this.role = role;
    }
    public User(String username, String password, String email, String bloodGroup, String role) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.bloodGroup = bloodGroup;
        this.role = role;
    }
// Getters and setters for each field
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBloodGroup() {
		return bloodGroup;
	}

	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public boolean sendNotificationToUser(int otp) 
	{
		boolean flag=false;
		
		try
		{
			//Your Email & Pass here
			String fromMail = "dhananjay9a@gmail.com";
			String pass = "yourapp pass from your google account";
			String toMail = email;
			
			//Setting up
			Properties pr = new Properties();
			pr.setProperty("mail.smtp.host", "smtp.gmail.com");
			pr.setProperty("mail.smtp.port", "587");
			pr.setProperty("mail.smtp.auth", "true");
			pr.setProperty("mail.smtp.starttls.enable", "true");
			pr.setProperty("mail.smtp.socketFactory.port", "587");
			pr.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			
			//Mail Session
			Session session = Session.getInstance(pr, new Authenticator() {
				
				@Override  //Giving access to our mail that it can send mail
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromMail,pass);
				}
				
			});
			
			//BUILDING MAIL
			Message message = new MimeMessage(session);
			
			//SETTING RECIEVER & SENDER
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
			message.setFrom(new InternetAddress(fromMail));
			
			//SETTING MESSAGE
			message.setSubject("Registration Notification");
			message.setText("Thank you "+username+" for registering in blood donation  website."+"your otp verification code is "+otp+" Don't share this code with anyone. ");
			
			
			Transport.send(message);
			flag=true;
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return(flag);
	}
    
    
    
}
