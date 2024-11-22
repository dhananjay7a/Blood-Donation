package Models;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Donation {
    private int donationId;
    private int userId;
    private String bloodGroup;
    private int quantity;
    private String username;
    private LocalDate date;

    //this is for saving the data in database
    public Donation(int userId, String bloodGroup, int quantity ,LocalDate date) {
        this.userId = userId;
        this.bloodGroup = bloodGroup;
        this.quantity = quantity;
        this.date = date;
    }
    
    public LocalDate getDate() {
		return date;
	}
	public void setDate(LocalDate date) {
		this.date = date;
	}
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	//this is for admin
    public Donation(int donationId, int userId, String bloodGroup, int quantity , String username , LocalDate date) {
    	this.donationId=donationId;
        this.userId = userId;
        this.bloodGroup = bloodGroup;
        this.quantity = quantity;
        this.username = username;
        this.date = date;
    }
 // Getters and setters for each field
	public int getDonationId() {
		return donationId;
	}

	public void setDonationId(int donationId) {
		this.donationId = donationId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getBloodGroup() {
		return bloodGroup;
	}

	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

   
    
    
}
