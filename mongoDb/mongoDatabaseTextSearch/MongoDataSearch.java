package bigdatamongo;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import static com.mongodb.client.model.Filters.eq;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Arrays;
import java.util.Scanner;
import org.bson.Document;
/**
 *
 * @author Abhi
 */
public class MongoDataSearch {

    /**
     * The Movielens dataset with collections movies, ratings , tags has been created in the MongoDB 
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        
        MongoDatabase database = mongoClient.getDatabase("Moviez");
        
        MongoCollection<Document> collectionMovies = database.getCollection("movies");
        MongoCollection<Document> collectionRatings = database.getCollection("ratings");
        MongoCollection<Document> collectionTags = database.getCollection("tags");
        
        Movies movies = new Movies();
        Ratings ratings = new Ratings();
        Tags tags = new Tags();
        
        movies.saveMovies(collectionMovies);
        ratings.saveRatings(collectionRatings);
        tags.saveTags(collectionTags);
        
        System.out.println("Please give input");
        Scanner sc = new Scanner(System.in); 
  
        // String input 
        String movieName = sc.nextLine();
        
        System.out.println("User Input :" + movieName);
        System.out.println(" Is it case sensitive");
        boolean caseSensitive = sc.nextBoolean();
        System.out.println("Is it diactricSensitive");
        boolean diactricSensitive = sc.nextBoolean();
        fullTextSearch(movieName, caseSensitive,diactricSensitive);
        
//        movies.findMovie(collectionMovies, movieName);
        
    }
    
    public static void fullTextSearch(String query, boolean caseSensitive, boolean diacriticSensitive) {
 
        MongoClient mongoClient = new MongoClient(new MongoClientURI("mongodb://localhost:27017"));
        MongoDatabase database = mongoClient.getDatabase("myMovies");
        MongoCollection<Document> collection = database.getCollection("movies");
 
        try {
            MongoCursor<Document> cursor = null;
            cursor = collection.find(new Document("$text", new Document("$search", query).append("$caseSensitive", new Boolean(caseSensitive)).append("$diacriticSensitive", new Boolean(diacriticSensitive)))).iterator();
 
            while (cursor.hasNext()) {
                Document article = cursor.next();
                System.out.println(article);
            }
 
            cursor.close();
 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            mongoClient.close();
        }
 
    }
}

