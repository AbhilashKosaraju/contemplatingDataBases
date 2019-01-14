package MongoDb;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

public class Connection {

	public static void main(String[] args) throws UnknownHostException {
		
		MongoClient mongoClient = new MongoClient("localhost",27017);
		DB db = mongoClient.getDB("games");
		DBCollection collection1 = db.getCollection("myMovies");
		DBCollection collection2 = db.getCollection("myTags");
		DBCollection collection3 = db.getCollection("myRatings");
	    List<DBObject> documents = new ArrayList<>();
	    System.out.println("Enter the movie title or any keyword");
	    
	    try {
            File inputFile = new File("C:\\Users\\sowjanya\\Desktop\\Abhi\\BigData\\ml-latest-small\\", "movies.csv");

            BufferedReader in = new BufferedReader(new FileReader(inputFile));
            String line;
            while ((line = in.readLine()) != null) {
                String[] tokens = line.split(",");
                String movieId = tokens[0];
                String title = tokens[1];
                String genres = tokens[2];
                
                System.out.println("MOVIE: " + movieId + "\nTITLE: " + title + "\nGENRE: " + genres);
                System.out.println("---------------------------------");
                DBObject document = new BasicDBObject ();
                document.put("movieId",movieId);
                document.put("title",title);
                document.put("genres",genres);
                documents.add(document);
                collection1.insert(documents);
                } 
            }catch (Exception ex) {
                System.out.println("FileNotFoundException: " + ex.getMessage());
            }
	    try {
            File inputFile = new File("C:\\Users\\sowjanya\\Desktop\\Abhi\\BigData\\ml-latest-small\\", "tags.csv");

            BufferedReader in = new BufferedReader(new FileReader(inputFile));
            String line;
            while ((line = in.readLine()) != null) {
                String[] tokens = line.split(",");
                String userId = tokens[0];
                String movieId = tokens[1];
                String tag = tokens[2];
                String timestamp = tokens[3];
                
                System.out.println("USERID: " + userId + "\nMOVIEID: " + movieId + "\nTAG: " + tag +"\nTIMESTAMP:" + timestamp);
                System.out.println("---------------------------------");
                DBObject document = new BasicDBObject ();
                document.put("UserId", userId);
                document.put("movieId",movieId);
                document.put("tag",tag);
                document.put("timestamp",timestamp);
                documents.add(document);
                collection2.insert(documents);
                } 
            }catch (Exception ex) {
                System.out.println("FileNotFoundException: " + ex.getMessage());
            }
	    try {
            File inputFile = new File("C:\\Users\\sowjanya\\Desktop\\Abhi\\BigData\\ml-latest-small\\", "ratings.csv");

            BufferedReader in = new BufferedReader(new FileReader(inputFile));
            String line;
            while ((line = in.readLine()) != null) {
                String[] tokens = line.split(",");
                String userId = tokens[0];
                String movieId = tokens[1];
                String rating = tokens[2];
                String timeStamp = tokens[3];
                
                System.out.println("USERID: " + userId + "\nMOVIEID: " + movieId + "\nRATING: " + rating + "\nTIMESTATMP" + timeStamp);
                System.out.println("---------------------------------");
                DBObject document = new BasicDBObject ();
                document.put("userId",userId);
                document.put("movieId",movieId);
                document.put("rating",rating);
                document.put("timeStamp", timeStamp);
                documents.add(document);
                collection3.insert(documents);
                } 
            }catch (Exception ex) {
                System.out.println("FileNotFoundException: " + ex.getMessage());
            }
	    
	    System.out.println("Enter the movie title you would like to see");
	    Scanner sc = new Scanner(System.in);
	    String keyword = sc.nextLine();
	    
	    DBCollection table = db.getCollection("myMovies");
	    BasicDBObject searchQuery = new BasicDBObject();
	    searchQuery.put("title", keyword);
	    
	    DBCursor cursor = table.find(searchQuery);
	    while (cursor.hasNext()) {
	    	System.out.println(cursor.next());
	    }
		mongoClient.close();
		
	}	
}
