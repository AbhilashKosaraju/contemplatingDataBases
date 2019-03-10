package bloomFilterCites;

public class City {

	final String userId ;
	
   City(String userId) {
		this.userId = userId;
	}


	@Override
	public String toString() {
		return "City [userId=" + userId  +"]";
	}

}
