package Models;

public class BloodInventory {
    private String bloodGroup;
    private int quantity;

    public BloodInventory(String bloodGroup, int quantity) {
        this.bloodGroup = bloodGroup;
        this.quantity = quantity;
    }
// Getters and setters for each field
    
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
