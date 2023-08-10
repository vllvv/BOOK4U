package reserv;

public class reserv {
	
	
	private String userID;
	private int id;
	private int price;
	private String checkin;
	private String checkout;
	private String reservID;
	private String title;

	
	public String getuserID() {
		return userID;
	}
	public void setuserID(String userID) {
		this.userID = userID;
	}
	public int getid() {
		return id;
	}
	public void setid(int id) {
		this.id = id;
	}
	public int getprice() {
		return price;
	}
	public void setprice(int price) {
		this.price = price;
	}
	public String getcheckin() {
		return checkin;
	}
	public void setcheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getcheckout() {
		return checkout;
	}
	public void setcheckout(String checkout) {
		this.checkout = checkout;
	}
	public String getreservID() {
		return reservID;
	}
	public void setreservID(String reservID) {
		this.reservID = reservID;
	}
	public String gettitle() {
		return title;
	}
	public void settitle(String title) {
		this.title = title;
	}

}
