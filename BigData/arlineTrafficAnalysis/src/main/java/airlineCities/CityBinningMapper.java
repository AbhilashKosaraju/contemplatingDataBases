package airlineCities;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.filecache.DistributedCache;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;

public class CityBinningMapper extends Mapper<Object, Text, Text, Text> {

	public static final String AVERAGE_POSTS_PER_USER = "avg.posts.per.user";
	public static final String MULTIPLE_OUTPUTS_ABOVE_NAME = "aboveavg";
	public static final String MULTIPLE_OUTPUTS_BELOW_NAME = "belowavg";

	public static void setAverageFlightsPerCity(Job job, double avg) {
		job.getConfiguration()
				.set(AVERAGE_POSTS_PER_USER, Double.toString(avg));
	}

	public static double getAverageFlightsPerCity(Configuration conf) {
		return Double.parseDouble(conf.get(AVERAGE_POSTS_PER_USER));
	}

	private double average = 0.0;
	private MultipleOutputs<Text, Text> mos = null;
	private Text outkey = new Text(), outvalue = new Text();
	private HashMap<String, String> stateReputation = new HashMap<String, String>();
	private HashMap<String, String> cityRanking = new HashMap<String, String>();

	@SuppressWarnings("deprecation")
	protected void setup(Context context) throws IOException,
			InterruptedException {
		average = getAverageFlightsPerCity(context.getConfiguration());
		mos = new MultipleOutputs<Text, Text>(context);

		try {
			Path[] files = DistributedCache.getLocalCacheFiles(context
					.getConfiguration());
			System.out.println("This here inside try" + files);

			if (files == null || files.length == 0) {
				System.out.println("files are null ");
				throw new RuntimeException(
						"User information is not set in DistributedCache");

			}

			// Read all files in the DistributedCache
			for (Path p : files) {
				if (p.getName().toString().trim().equals("States.csv")) {
					@SuppressWarnings("resource")
					BufferedReader read = new BufferedReader(new FileReader(
							p.toString()));

					String line;
					// For each record in the user file
					while ((line = read.readLine()) != null) {

						// Get the user ID and reputation
						String[] tokens = line.toString().split(",");

						String stateId = tokens[0];
						String StateName = tokens[1];
						String GDP = tokens[2];
						String HDI = tokens[3];

						String state = stateId + "\t" + StateName;
						String index = GDP + "\t" + HDI;

						if (state != null && index != null) {
							// Map the user ID to the reputation
							stateReputation.put(stateId, index);
						}
					}
				}

				if (p.getName().toString().trim().equals("Cities.csv")) {
					BufferedReader reader = new BufferedReader(new FileReader(
							p.toString()));
					String line;
					while ((line = reader.readLine()) != null) {
						String[] tokens = line.toString().split(",");

						String city = tokens[1];
						String ranking = tokens[0];

						if (city != null && ranking != null) {
							// Map the user ID to the reputation
							cityRanking.put(city, ranking);
						}
					}
				}

			}

		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void map(Object key, Text value, Context context)
			throws IOException, InterruptedException {

		String[] tokens = value.toString().split("\t");
        String airport = tokens[0];
		int flights = Integer.parseInt(tokens[1]);
		
		String airportTokens[] = airport.split(",");
		String city = airportTokens[0];
		String cityName = city.substring(1);
		String state = airportTokens[1];
		String stateId =state.substring(0, state.length()-1);
		


		outkey.set(airport);
		outvalue.set((long) flights + "\t" + stateReputation.get(stateId)+ "\t"+ cityRanking.get(cityName));

		if ((double) flights < average) {
			mos.write(MULTIPLE_OUTPUTS_BELOW_NAME, outkey, outvalue,
					MULTIPLE_OUTPUTS_BELOW_NAME + "/part");
		} else {
			mos.write(MULTIPLE_OUTPUTS_ABOVE_NAME, outkey, outvalue,
					MULTIPLE_OUTPUTS_ABOVE_NAME + "/part");
		}

	}

	protected void cleanup(Context context) throws IOException,
			InterruptedException {
		mos.close();
	}
}
