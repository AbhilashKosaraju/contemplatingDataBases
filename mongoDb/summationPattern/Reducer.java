package lab4;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.SortedMapWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.mapreduce.Reducer;
 
public class Reducer extends Reducer<Text, DoubleWritable, Text, MedianStdDevWritable> {
	
	MedianStdDevWritable result = new MedianStdDevWritable();
	ArrayList<Double> ratingList = new ArrayList<Double>();
	
	public void reduce(Text key,Iterable<DoubleWritable> values,Context context) throws IOException, InterruptedException {
		
		double sum = 0.0;
		int count = 0;
		ratingList.clear();
		
		// calculate sum & count; add ratings into arraylist
		for (DoubleWritable value : values) {
			ratingList.add(value.get());
			sum += value.get();
			count += 1;
		}
		
		// sort arraylist
		Collections.sort(ratingList);
		
		// calculate median
		double median;
		if(count % 2 == 0) {
			median = (ratingList.get(count/2 - 1) + ratingList.get(count/2)) / 2;
			result.setMedian(String.valueOf(median));
		}else {
			median = ratingList.get(count/2);
			result.setMedian(String.valueOf(median));
		}
		
		// calculate standard deviation
		double mean = sum /count;
		double sumOfSquares = 0.0;
		for(Double d : ratingList) {
			sumOfSquares += (d -mean) * (d -mean);
		}
		double stdDev = Math.sqrt(sumOfSquares/(count -1));
		result.setStdDev(String.valueOf(stdDev));
		
		context.write(key, result);
	}
}