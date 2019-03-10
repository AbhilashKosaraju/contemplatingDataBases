package bloomFilterCites;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.filecache.DistributedCache;

import com.google.common.hash.BloomFilter;
import com.google.common.hash.Funnel;
import com.google.common.hash.Sink;

public class BloomFilterMapper extends Mapper<Object, Text, Text, NullWritable> {
	Funnel<City> c = new Funnel<City>() {

		@Override
		public void funnel(City city, Sink in) {
			// TODO Auto-generated method stub
			in.putString(city.userId);
		}

	};
	private BloomFilter<City> cities = BloomFilter.create(c, 500, 0.1);

	@SuppressWarnings("deprecation")
	@Override
	public void setup(Context context) throws IOException, InterruptedException {

		City p1 = new City("Houston");
		City p2 = new City("Philadelphia");
		City p3 = new City("Chicago");
		City p4 = new City("San Jose");
		City p5 = new City("New York");

		ArrayList<City> cityList = new ArrayList<City>();
		cityList.add(p1);
		cityList.add(p2);
		cityList.add(p3);
		cityList.add(p4);
		cityList.add(p5);

		for (City ci : cityList) {
			cities.put(ci);
		}

		try {
			Path[] files = DistributedCache.getLocalCacheFiles(context
					.getConfiguration());
			ArrayList<City> selectedCities = new ArrayList<City>();

			if (files == null || files.length == 0) {
				System.out.println("files are null ");
				throw new RuntimeException(
						"TopK user information is not set in DistributedCache");
			}

			for (Path p : files) {
				System.out.println("This is the file result "
						+ p.getName().toString().trim().equals("cache.txt"));
				System.out.println(p.getName().toString().trim());
				if (p.getName().toString().trim().equals("cache.txt")) {
					@SuppressWarnings("resource")
					BufferedReader rdr = new BufferedReader(new FileReader(
							p.toString()));

					String line;
					while ((line = rdr.readLine()) != null) {
						String[] tokens = line.toString().split("\t");
						City c = new City(tokens[0]);
						selectedCities.add(c);
					}

				}
			}
			for (City ci : selectedCities) {
				cities.put(ci);
			}

		} catch (Exception e) {
			System.out.print(e);
		}

	}

	@Override
	public void map(Object key, Text value, Context context)
			throws IOException, InterruptedException {
		String values[] = value.toString().split(",");
		System.out.println("The second value is " + values[0]);
		String userId = values[0];
		City c = new City(userId);

		if (cities.mightContain(c)) {
			context.write(value, NullWritable.get());
		}

	}

}
