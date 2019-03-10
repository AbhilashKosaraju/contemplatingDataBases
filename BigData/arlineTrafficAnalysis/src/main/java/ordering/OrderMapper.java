package ordering;

import java.io.IOException;
import java.util.TreeMap;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class OrderMapper extends Mapper<Object, Text, NullWritable, Text> {

	// IntWritable order = new IntWritable();

	@Override
	protected void map(Object key, Text value,
			Mapper<Object, Text, NullWritable, Text>.Context context)
			throws IOException, InterruptedException {

		String values[] = value.toString().split("\t");
		try {

			String rank = values[4];
			String city = values[0];
			String GDP = values[2];
			String HDI = values[3];
			int orderedRank = Integer.parseInt(rank);
			if (orderedRank <= 10) {
				// order.set(orderedRank);
				context.write(NullWritable.get(), new Text(city + "\t" + GDP
						+ "\t" + HDI + "\t" + orderedRank));
			}

		} catch (Exception e) {
			System.out.println("The exception caught" + e);
		}

	}

}