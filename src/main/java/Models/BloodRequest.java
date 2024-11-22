package Models;

public class BloodRequest {
    private int requestId;
    private int userId;
    private String bloodGroup;
    private int quantity;
    private String status;
    private String username;

    //for admin to see requests
    public BloodRequest(int requestId ,int userId, String bloodGroup, int quantity, String status , String username) {
    	this.requestId = requestId;
        this.userId = userId;
        this.bloodGroup = bloodGroup;
        this.quantity = quantity;
        this.status = status;
        this.username = username;
    }
    
    
    
	//for user to see his requests
    public BloodRequest(int userId, String bloodGroup, int quantity, String status) {
        this.userId = userId;
        this.bloodGroup = bloodGroup;
        this.quantity = quantity;
        this.status = status;
    }
// Getters and setters for each field
    
	public int getRequestId() {
		return requestId;
	}

	public void setRequestId(int requestId) {
		this.requestId = requestId;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}


    
    
}
