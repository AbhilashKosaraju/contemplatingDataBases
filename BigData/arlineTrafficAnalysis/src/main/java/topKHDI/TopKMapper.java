package topKHDI;

import java.io.IOException;
import java.util.TreeMap;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class TopKMapper extends Mapper<Object, Text, NullWritable, Text> {

	private TreeMap<Double, Text> recordsMap;

	@Override
	protected void setup(
			Mapper<Object, Text, NullWritable, Text>.Context context)
			throws IOException, InterruptedException {
		this.recordsMap = new TreeMap<Double, Text>();
	}

	@Override
	protected void map(Object key, Text value,
			Mapper<Object, Text, NullWritable, Text>.Context context)
			throws IOException, InterruptedException {

		String values[] = value.toString().split("\t");
		try {

			String hdi = values[2];
			if (hdi != null) {
				recordsMap.put(Double.valueOf(hdi), new Text(values[0] + "\t"
						+ values[1] + "\t" + values[2]));
			}

		} catch (Exception e) {
		}

		if (recordsMap.size() > 5) {
			recordsMap.remove(recordsMap.firstKey());
		}
	}

	@Override
	protected void cleanup(
			Mapper<Object, Text, NullWritable, Text>.Context context)
			throws IOException, InterruptedException {
		for (Text t : recordsMap.values()) {
			context.write(NullWritable.get(), t);
		}
	}
}