package bloomFilterCites;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.filecache.DistributedCache;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


import com.google.common.base.Charsets;
import com.google.common.hash.BloomFilter;
import com.google.common.hash.Funnel;
import com.google.common.hash.Sink;

public class BloomFilterAnalysis {
	
	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws Exception {

		Configuration conf = new Configuration();
		Path inputPath = new Path(args[0]);
		Path outputDir = new Path(args[1]);
//		Path cache = new Path(args[2]);
		Job job = Job.getInstance(conf, "Bloom Filter");
		job.setJarByClass(BloomFilterAnalysis.class);
		job.setMapperClass(BloomFilterMapper.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(NullWritable.class);
		job.setNumReduceTasks(0);
		FileInputFormat.addInputPath(job, inputPath);
		FileOutputFormat.setOutputPath(job, outputDir);
//
//		FileStatus[] userFiles = FileSystem.get(new Configuration())
//				.listStatus(cache);
//		if (userFiles != null) {
//			System.out
//					.println("And yes here the file has been read in to the buffer");
//		} else {
//			System.out
//					.println("Here the files has not been read in to the buffer");
//		}
//
//		for (FileStatus status : userFiles) {
//			DistributedCache.addCacheFile(status.getPath().toUri(),
//					job.getConfiguration());
//		}

		// delete output if exist
		FileSystem hdfs = FileSystem.get(conf);
		if (hdfs.exists(outputDir))
			hdfs.delete(outputDir, true);

		boolean success = job.waitForCompletion(true);
		System.out.println(success);

	}
}