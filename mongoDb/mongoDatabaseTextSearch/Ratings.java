/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bigdatamongo;

import com.mongodb.client.MongoCollection;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import org.bson.Document;
/**
 *
 * @author Abhi
 */
public class Ratings {
    public void saveRatings(MongoCollection<Document> collectionRatings){
            
        try {
            File inputFile = new File("C:\\Users\\harsh\\Desktop\\Big Data\\ml-10m\\ml-10M100K\\ratings.DAT");
            //FileInputStream fis = new FileInputStream(inputFile);

            BufferedReader in = new BufferedReader(new FileReader(inputFile));
            String line;
            while ((line = in.readLine()) != null) {
                String[] tokens = line.split("::");
                String UserID = tokens[0];
                String MovieID = tokens[1];
                String Rating = tokens[2];
                String Timestamp = tokens[3];

                System.out.println("UserID: " + UserID + "\nMovieID:  " + MovieID + "\nRating: " + Rating + "\nTimestamp" + Timestamp);
                System.out.println("---------------------------------");
                    
                Document doc = new Document("UserID", UserID)
                .append("MovieID", MovieID)
                .append("Rating", Rating)
                .append("Timestamp", Timestamp);
            
                collectionRatings.insertOne(doc);
            }

            System.out.println("File Opened!");
        } catch (Exception ex) {
            System.out.println("FileNotFoundException: " + ex.getMessage());
        }
    }
}

