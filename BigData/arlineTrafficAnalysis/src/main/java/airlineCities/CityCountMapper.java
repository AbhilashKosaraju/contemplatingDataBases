package airlineCities;


import java.io.IOException;
import java.util.Map;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class CityCountMapper extends Mapper<Object, Text, Text, LongWritable> {
	public static final String AVERAGE_CALC_GROUP = "AverageCalculation";
	public static final String RECORDS_COUNTER_NAME = "Records";

	private static final LongWritable ONE = new LongWritable(1);
	private Text outkey = new Text();

	@Override
	public void map(Object key, Text value, Context context) throws IOException, InterruptedException {

// Parse the input into a nice map.
//		Map<String, String> parsed = AnalysisUtils.transformXmlToMap(value.toString());
		String[] tokens = value.toString().split(",");

// Get the value for the OwnerUserId attribute
		String cityName = tokens[6];
		String stateId =tokens[7];
		String airport = cityName+","+stateId;

		if (cityName != null) {
			outkey.set(airport);
			context.write(outkey, ONE);
			context.getCounter(AVERAGE_CALC_GROUP, RECORDS_COUNTER_NAME).increment(1);
		}
	}
}
