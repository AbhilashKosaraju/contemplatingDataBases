/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bigdatamongo;

import com.mongodb.client.MongoCollection;
import static com.mongodb.client.model.Filters.eq;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import org.bson.Document;
/**
 *
 * @author Abhi
 */
public class Movies {
    
    public void saveMovies(MongoCollection<Document> collectionMovies){
            
        try {
            File inputFile = new File("C:\\Users\\harsh\\Desktop\\Big Data\\ml-10m\\ml-10M100K\\movies.DAT");
            //FileInputStream fis = new FileInputStream(inputFile);

            BufferedReader in = new BufferedReader(new FileReader(inputFile));
            String line;
            while ((line = in.readLine()) != null) {
                String[] tokens = line.split("::");
                String MovieID = tokens[0];
                String Title = tokens[1];
                String Genres = tokens[2];

                System.out.println("MovieID: " + MovieID + "\nTitle:  " + Title + "\nGenres: " + Genres);
                System.out.println("---------------------------------");
                    
                Document doc = new Document("MovieID", MovieID)
                .append("Title", Title)
                .append("Genres", Genres);
            
                collectionMovies.insertOne(doc);
            }

            System.out.println("File Opened!");
        } catch (Exception ex) {
            System.out.println("FileNotFoundException: " + ex.getMessage());
        }
    }
    
    public void findMovie(MongoCollection<Document> collectionMovies, String movieName){
        Document myDoc = collectionMovies.find(eq("Title", movieName)).first(); 
        System.out.println("Movie found :" + myDoc.toJson());
    }
    
}

