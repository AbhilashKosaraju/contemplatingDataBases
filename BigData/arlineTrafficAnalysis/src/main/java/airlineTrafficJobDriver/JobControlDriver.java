package airlineTrafficJobDriver;

import java.io.IOException;

import ordering.OrderDriver;
import ordering.OrderMapper;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.filecache.DistributedCache;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.jobcontrol.ControlledJob;
import org.apache.hadoop.mapreduce.lib.jobcontrol.JobControl;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.mapreduce.lib.reduce.LongSumReducer;

import secSort.CompositeKeyWritable;
import secSort.GroupingComparator;
import secSort.NaturalKeyPartitioner;
import secSort.SecondarySortCompKeySortComparator;
import secSort.TopGDPMapper;
import secSort.TopGDPReducer;
import topKHDI.TopKMapper;
import topKHDI.TopKReducer;
import airlineCities.AirlineJobChainingDriver;
import airlineCities.CityBinningMapper;
import airlineCities.CityCountMapper;
import airlineCities.CitySumReducer;

public class JobControlDriver {

	public static final String BIN_ORDERED_OUTPUT = "orderedBin";
	public static final String SEC_SORTED_OUTPUT = "secsorted";
	public static final String TOPK_OUTPUT = "topk";
	public static final String BLOOM_OUTPUT = "bloom";

	public static void main(String[] args) throws Exception {

		if (args.length != 4) {
			System.err
					.println("Usage: JobChainingDriver <posts> <users> <belowavgrepout> <aboveavgrepout>");
			System.exit(2);
		}

		Path airlineTraffic = new Path(args[0]);
		Path cache = new Path(args[1]);
		Path flightCount = new Path(args[2] + "_Count");
		Path binningRootDir = new Path(args[2]);
		Path binningOutputLower = new Path(binningRootDir + "/"
				+ AirlineJobChainingDriver.MULTIPLE_OUTPUTS_BELOW_NAME);
		Path binningOutputAbove = new Path(binningRootDir + "/"
				+ AirlineJobChainingDriver.MULTIPLE_OUTPUTS_ABOVE_NAME);

		Path belowAverageFlightsOutput = new Path(args[3]);
		Path aboveAverageFlightsOutput = new Path(args[3]+"_OPB");

		Path topBinOrderedOutput = new Path(binningOutputAbove + "/"
				+ BIN_ORDERED_OUTPUT);
		Path bottomBinOrdredOutput = new Path(binningOutputLower + "/"
				+ BIN_ORDERED_OUTPUT);

		Path topbinSecSorted = new Path(aboveAverageFlightsOutput + "/"
				+ SEC_SORTED_OUTPUT);
		Path bottomSecSorted = new Path(belowAverageFlightsOutput + "/"
				+ SEC_SORTED_OUTPUT);

		Path topbinTopKHdi = new Path(aboveAverageFlightsOutput + "/"
				+ TOPK_OUTPUT);
		Path bottombinTopKHdi = new Path(belowAverageFlightsOutput + "/"
				+ TOPK_OUTPUT);

		Path topBloomFiltered = new Path(aboveAverageFlightsOutput + "/"
				+ BLOOM_OUTPUT);
		Path bottomBloomFiltered = new Path(belowAverageFlightsOutput + "/"
				+ BLOOM_OUTPUT);

		Job countingJob = getFlightCountJob(airlineTraffic, flightCount);

		int code = 1;
		if (countingJob.waitForCompletion(true)) {
			ControlledJob binningControlledJob = new ControlledJob(
					getBinsJobConf(countingJob, flightCount, cache,
							binningRootDir));

			ControlledJob belowAvgControlledJob = new ControlledJob(
					getOrderJobConf(binningOutputLower,
							belowAverageFlightsOutput));
			belowAvgControlledJob.addDependingJob(binningControlledJob);

			ControlledJob aboveAvgControlledJob = new ControlledJob(
					getOrderJobConf(binningOutputAbove,
							aboveAverageFlightsOutput));
			aboveAvgControlledJob.addDependingJob(binningControlledJob);

			ControlledJob secSortedTopBinControlledJob = new ControlledJob(
					getSecSortedJob(aboveAverageFlightsOutput, topbinSecSorted));
			secSortedTopBinControlledJob.addDependingJob(aboveAvgControlledJob);
			
			
			
			ControlledJob secSortedBottomBinControlledJob = new ControlledJob(
					getSecSortedJob(belowAverageFlightsOutput,
							bottomBinOrdredOutput));
			secSortedBottomBinControlledJob
					.addDependingJob(belowAvgControlledJob);

			ControlledJob topKTopBinControlledJob = new ControlledJob(getTopK(
					topbinSecSorted, topbinTopKHdi));
			topKTopBinControlledJob
					.addDependingJob(secSortedTopBinControlledJob);
			ControlledJob topKBottomBinControlledJob = new ControlledJob(
					getTopK(bottomBinOrdredOutput, bottombinTopKHdi));
			topKBottomBinControlledJob
					.addDependingJob(secSortedBottomBinControlledJob);

			ControlledJob bloomFilterTopJob = new ControlledJob(
					getBloomFiltered(topbinTopKHdi, topBloomFiltered));
			bloomFilterTopJob.addDependingJob(topKTopBinControlledJob);
			ControlledJob bloomFilterBottomJob = new ControlledJob(
					getBloomFiltered(bottombinTopKHdi, bottomBloomFiltered));
			bloomFilterBottomJob.addDependingJob(topKBottomBinControlledJob);

			JobControl jc = new JobControl("AverageReputation");
			jc.addJob(binningControlledJob);
			jc.addJob(aboveAvgControlledJob);
			jc.addJob(belowAvgControlledJob);
			jc.addJob(secSortedTopBinControlledJob);
			jc.addJob(secSortedBottomBinControlledJob);
			jc.addJob(topKTopBinControlledJob);
			jc.addJob(topKBottomBinControlledJob);
			jc.addJob(bloomFilterTopJob);
			jc.addJob(bloomFilterBottomJob);

			jc.run();
			code = jc.getFailedJobList().size() == 0 ? 0 : 1;
		}

		FileSystem fs = FileSystem.get(new Configuration());
		fs.delete(flightCount, true);
		fs.delete(binningRootDir, true);

		System.out.println("All Done");
		System.exit(code);
	}

	public static Job getFlightCountJob(Path airLineTrafficInput,
			Path cityCountOutput) throws IOException {
		// Setup first job to counter user posts
		@SuppressWarnings("deprecation")
		Job countingJob = new Job(new Configuration(), "JobChaining-Counting");
		countingJob.setJarByClass(AirlineJobChainingDriver.class);

		// Set our mapper and reducer, we can use the API's long sum reducer for
		// a combiner!
		countingJob.setMapperClass(CityCountMapper.class);
		countingJob.setCombinerClass(LongSumReducer.class);
		countingJob.setReducerClass(CitySumReducer.class);

		countingJob.setOutputKeyClass(Text.class);
		countingJob.setOutputValueClass(LongWritable.class);

		countingJob.setInputFormatClass(TextInputFormat.class);

		TextInputFormat.addInputPath(countingJob, airLineTrafficInput);

		countingJob.setOutputFormatClass(TextOutputFormat.class);
		TextOutputFormat.setOutputPath(countingJob, cityCountOutput);

		return countingJob;
	}

	@SuppressWarnings("deprecation")
	public static Configuration getBinsJobConf(Job countingJob,
			Path jobchainOutdir, Path userInput, Path binningOutput)
			throws IOException {
		// Calculate the average posts per user by getting counter values
		double numRecords = (double) countingJob
				.getCounters()
				.findCounter(AirlineJobChainingDriver.AVERAGE_CALC_GROUP,
						CityCountMapper.RECORDS_COUNTER_NAME).getValue();
		double numUsers = (double) countingJob
				.getCounters()
				.findCounter(AirlineJobChainingDriver.AVERAGE_CALC_GROUP,
						CitySumReducer.USERS_COUNTER_NAME).getValue();

		double averageFlightsPerCity = numRecords / numUsers;

		// Setup binning job
		@SuppressWarnings("deprecation")
		Job binningJob = new Job(new Configuration(), "JobChaining-Binning");
		binningJob.setJarByClass(AirlineJobChainingDriver.class);

		// Set mapper and the average posts per user
		binningJob.setMapperClass(CityBinningMapper.class);
		CityBinningMapper.setAverageFlightsPerCity(binningJob,
				averageFlightsPerCity);

		binningJob.setNumReduceTasks(0);

		binningJob.setInputFormatClass(TextInputFormat.class);
		TextInputFormat.addInputPath(binningJob, jobchainOutdir);

		// Add two named outputs for below/above average
		MultipleOutputs.addNamedOutput(binningJob,
				AirlineJobChainingDriver.MULTIPLE_OUTPUTS_BELOW_NAME,
				TextOutputFormat.class, Text.class, Text.class);

		MultipleOutputs.addNamedOutput(binningJob,
				AirlineJobChainingDriver.MULTIPLE_OUTPUTS_ABOVE_NAME,
				TextOutputFormat.class, Text.class, Text.class);
		MultipleOutputs.setCountersEnabled(binningJob, true);

		TextOutputFormat.setOutputPath(binningJob, binningOutput);

		// Add the user files to the DistributedCache
		FileStatus[] userFiles = FileSystem.get(new Configuration())
				.listStatus(userInput);
		for (FileStatus status : userFiles) {
			DistributedCache.addCacheFile(status.getPath().toUri(),
					binningJob.getConfiguration());
		}

		// Execute job and grab exit code
		return binningJob.getConfiguration();
	}

	public static Configuration getOrderJobConf(Path averageOutputDir,
			Path outputDir) throws IOException {

		@SuppressWarnings("deprecation")
		Job getOrderJob = new Job(new Configuration(),
				"ParallelJobs-OrderingBins");
		getOrderJob.setJarByClass(OrderDriver.class);

		getOrderJob.setMapperClass(OrderMapper.class);

		getOrderJob.setOutputKeyClass(NullWritable.class);
		getOrderJob.setOutputValueClass(Text.class);
		getOrderJob.setNumReduceTasks(0);

		getOrderJob.setInputFormatClass(TextInputFormat.class);
		TextInputFormat.addInputPath(getOrderJob, averageOutputDir);

		getOrderJob.setInputFormatClass(TextInputFormat.class);
		TextOutputFormat.setOutputPath(getOrderJob, outputDir);

		// Execute job and grab exit code
		return getOrderJob.getConfiguration();
	}

	public static Configuration getSecSortedJob(Path inputPath, Path outputDir)
			throws IOException {

		@SuppressWarnings("deprecation")
		Job secJob = new Job(new Configuration(), "SecondarySortingJob");
		secJob.setJarByClass(TopGDPMapper.class);
		secJob.setGroupingComparatorClass(GroupingComparator.class);
		secJob.setPartitionerClass(NaturalKeyPartitioner.class);
		secJob.setSortComparatorClass(SecondarySortCompKeySortComparator.class);

		// Setup MapReduce
		secJob.setMapperClass(TopGDPMapper.class);
		secJob.setReducerClass(TopGDPReducer.class);
		secJob.setNumReduceTasks(1);

		// Specify key / value
		secJob.setMapOutputKeyClass(CompositeKeyWritable.class);
		secJob.setMapOutputValueClass(NullWritable.class);
		secJob.setOutputKeyClass(CompositeKeyWritable.class);
		secJob.setOutputValueClass(NullWritable.class);

		// Input
		FileInputFormat.addInputPath(secJob, inputPath);
		secJob.setInputFormatClass(TextInputFormat.class);

		// Output
		FileOutputFormat.setOutputPath(secJob, outputDir);
		return secJob.getConfiguration();
	}

	public static Configuration getTopK(Path inputPath, Path outputDir)
			throws IOException {

		@SuppressWarnings("deprecation")
		Job topKJob = new Job(new Configuration(), "TopKJob");
		topKJob.setJarByClass(TopKMapper.class);

		// Setup MapReduce
		topKJob.setMapperClass(TopKMapper.class);
		topKJob.setReducerClass(TopKReducer.class);
		topKJob.setNumReduceTasks(1);

		// Specify key / value
		topKJob.setMapOutputKeyClass(NullWritable.class);
		topKJob.setMapOutputValueClass(Text.class);
		topKJob.setOutputKeyClass(NullWritable.class);
		topKJob.setOutputValueClass(Text.class);

		// Input
		FileInputFormat.addInputPath(topKJob, inputPath);
		topKJob.setInputFormatClass(TextInputFormat.class);

		// Output
		FileOutputFormat.setOutputPath(topKJob, outputDir);
		return topKJob.getConfiguration();
	}

	public static Configuration getBloomFiltered(Path inputPath, Path outputDir)
			throws IOException {

		return null;
	}

}
