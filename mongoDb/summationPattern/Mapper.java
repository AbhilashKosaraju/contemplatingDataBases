package lab4;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class Mapper extends Mapper<LongWritable, Text, Text, DoubleWritable> {
	
	Text brand = new Text();
	DoubleWritable rating = new DoubleWritable();

	public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

		String values[] = value.toString().split(",");
		try {
			brand.set(values[0]);
			rating.set(Double.parseDouble(values[2]));
			
			context.write(brand, rating);
			
		} catch (Exception e) {
			System.out.println("Exception is " + e);
		}
	}
}