package search;
public class Lodging {
    private int id;
    private String img;
    private String title;
    private int price;
    private String location;

    public Lodging() {
        this.id = id;
        this.img = img;
        this.title = title;
        this.price = price;
        this.location = location;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
    	this.id = id;
    	
    }
    public String getImg() {
        return img;
    }
    public void setImg(String img) {
    	this.img = img;
    	
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
    	this.title = title;
    	
    }

    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
    	this.price = price;
    	
    }

    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
    	this.location = location;
    	
    }
}
