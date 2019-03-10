package ordering;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class OrderDriver {

	public static void main(String[] args) throws Exception {

		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args)
				.getRemainingArgs();

		if (otherArgs.length != 4) {
			System.err
					.println("Usage: ParallelJobs <belowAverageInput> <belowAverageOutput> <belowAverageIutput> <aboveAverageOutput>");
			System.exit(2);
		}

		Path belowAvgInputDir = new Path(otherArgs[0]);
		Path aboveAvgInputDir = new Path(otherArgs[1]);

		Path belowAvgOutputDir = new Path(otherArgs[2]);
		Path aboveAvgOutputDir = new Path(otherArgs[3]);

		Job belowAvgJob = submitJob(conf, belowAvgInputDir, belowAvgOutputDir);
		Job aboveAvgJob = submitJob(conf, aboveAvgInputDir, aboveAvgOutputDir);

		// While both jobs are not finished, sleep
		while (!belowAvgJob.isComplete() || !aboveAvgJob.isComplete()) {
			Thread.sleep(5000);
		}

		if (belowAvgJob.isSuccessful()) {
			System.out.println("Below average job completed successfully!");
		} else {
			System.out.println("Below average job failed!");
		}

		if (aboveAvgJob.isSuccessful()) {
			System.out.println("Above average job completed successfully!");
		} else {
			System.out.println("Above average job failed!");
		}

		System.exit(belowAvgJob.isSuccessful() && aboveAvgJob.isSuccessful() ? 0
				: 1);
	}

	private static Job submitJob(Configuration conf, Path inputDir,
			Path outputDir) throws IOException, InterruptedException,
			ClassNotFoundException {

		Job job = new Job(conf, "ParallelJobs-OrderingBins");
		job.setJarByClass(OrderMapper.class);

		job.setMapperClass(OrderMapper.class);

		job.setOutputKeyClass(NullWritable.class);
		job.setOutputValueClass(Text.class);
		job.setNumReduceTasks(0);

		job.setInputFormatClass(TextInputFormat.class);
		TextInputFormat.addInputPath(job, inputDir);

		job.setOutputFormatClass(TextOutputFormat.class);
		TextOutputFormat.setOutputPath(job, outputDir);

		job.submit();
		return job;
	}
}
