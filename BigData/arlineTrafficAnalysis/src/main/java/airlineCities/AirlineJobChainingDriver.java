package airlineCities;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.filecache.DistributedCache;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.mapreduce.lib.reduce.LongSumReducer;
import org.apache.hadoop.util.GenericOptionsParser;

public class AirlineJobChainingDriver {
	public static final String AVERAGE_CALC_GROUP = "AverageCalculation";
	public static final String MULTIPLE_OUTPUTS_ABOVE_NAME = "aboveavg";
	public static final String MULTIPLE_OUTPUTS_BELOW_NAME = "belowavg";

	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();

		if (otherArgs.length != 2) {
			System.err.println("Usage: AirlineJobChainingDriver <AirlineTraffics> <Cache Files> <out>");
			System.exit(2);
		}

		Path airTraffic = new Path(otherArgs[0]);
		Path cache = new Path(otherArgs[1]);
		Path outputDirIntermediate = new Path(otherArgs[2] + "_int");
		Path outputDir = new Path(otherArgs[2]);

		// Setup first job to counter user posts

		Job countingJob = Job.getInstance(conf, "JobChaining-Counting");
		countingJob.setJarByClass(AirlineJobChainingDriver.class);

		// Set our mapper and reducer, we can use the API's long sum reducer for
		// a combiner!
		countingJob.setMapperClass(CityCountMapper.class);
		countingJob.setCombinerClass(LongSumReducer.class);
		countingJob.setReducerClass(CitySumReducer.class);

		countingJob.setOutputKeyClass(Text.class);
		countingJob.setOutputValueClass(LongWritable.class);

		countingJob.setInputFormatClass(TextInputFormat.class);

		TextInputFormat.addInputPath(countingJob, airTraffic);

		countingJob.setOutputFormatClass(TextOutputFormat.class);
		TextOutputFormat.setOutputPath(countingJob, outputDirIntermediate);

		// Execute job and grab exit code
		int code = countingJob.waitForCompletion(true) ? 0 : 1;

		if (code == 0) {
			// Calculate the average posts per user by getting counter values
			double numRecords = (double) countingJob.getCounters()
					.findCounter(AVERAGE_CALC_GROUP, CityCountMapper.RECORDS_COUNTER_NAME).getValue();
			double numFlights = (double) countingJob.getCounters()
					.findCounter(AVERAGE_CALC_GROUP, CitySumReducer.USERS_COUNTER_NAME).getValue();

			double averageFlightsPerCity = numRecords / numFlights;

			// Setup binning job
			Job binningJob = Job.getInstance(conf, "JobChaining-Binning");
			binningJob.setJarByClass(AirlineJobChainingDriver.class);

			// Set mapper and the average posts per user
			binningJob.setMapperClass(CityBinningMapper.class);
			CityBinningMapper.setAverageFlightsPerCity(binningJob, averageFlightsPerCity);

			binningJob.setNumReduceTasks(0);

			binningJob.setInputFormatClass(TextInputFormat.class);
			TextInputFormat.addInputPath(binningJob, outputDirIntermediate);

			// Add two named outputs for below/above average
			MultipleOutputs.addNamedOutput(binningJob, MULTIPLE_OUTPUTS_BELOW_NAME, TextOutputFormat.class, Text.class,
					Text.class);

			MultipleOutputs.addNamedOutput(binningJob, MULTIPLE_OUTPUTS_ABOVE_NAME, TextOutputFormat.class, Text.class,
					Text.class);
			MultipleOutputs.setCountersEnabled(binningJob, true);

			TextOutputFormat.setOutputPath(binningJob, outputDir);

			// Add the user files to the DistributedCache
			FileStatus[] cacheFiles = FileSystem.get(conf).listStatus(cache);
			for (FileStatus status : cacheFiles) {
				DistributedCache.addCacheFile(status.getPath().toUri(), binningJob.getConfiguration());
			}

			// Execute job and grab exit code
			code = binningJob.waitForCompletion(true) ? 0 : 1;
		}

		// Clean up the intermediate output
		FileSystem.get(conf).delete(outputDirIntermediate, true);

		System.exit(code);
	}
}
