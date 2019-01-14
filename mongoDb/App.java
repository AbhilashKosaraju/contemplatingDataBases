package MongoDb;

/*

Write a Java program to read the access.log file (attached), and insert into a collection in a Mongo Database 

Once the data are inserted into MongoDB, create a console app  to ask the user to perform several operations on the data. Such as, the user might search the IP addresses, or another keyword, and then display the results.

*/

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

public class App {

	public static void main(String[] args) {
		MongoClient mongoClient = new MongoClient("localhost",27017);
		DB db = mongoClient.getDB("games");
		DBCollection collection1 = db.getCollection("myLogs");
		List<DBObject> documents = new ArrayList<>();
		
		
		try {
            FileInputStream fstream = new FileInputStream("Enter \\the\file\location\\here");
            BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
            String strLine;
            /* read log line by line */
            while ((strLine = br.readLine()) != null) {
                /* parse strLine to obtain what you want */
                System.out.println(strLine);
                DBObject document = new BasicDBObject ();
                document.put("Log",strLine);
                documents.add(document);
                collection1.insert(documents);
            }
            fstream.close();
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
		 System.out.println("Enter the IP address you would like to see");
		    Scanner sc = new Scanner(System.in);
		    String keyword = sc.nextLine();
		    
		    DBCollection table = db.getCollection("myLogs");
		    BasicDBObject searchQuery = new BasicDBObject();
		    searchQuery.put("Log", keyword);
		    
		    DBCursor cursor = table.find(searchQuery);
		    while (cursor.hasNext()) {
		    	System.out.println(cursor.next());
		    }
	}
}
