package secSort;

import java.io.IOException;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class TopGDPMapper extends
		Mapper<Object, Text, CompositeKeyWritable, NullWritable> {

	public void map(Object key, Text value, Context context)
			throws IOException, InterruptedException {

		String values[] = value.toString().split("\t");
		// System.out.println(value.toString());
		String gdp = null;
		String rank = null;
		String city = null;
		String hdi = null;

		try {
			city = values[0];
			gdp = values[1];
			hdi = values[2];
			rank = values[3];
		} catch (Exception e) {
			// TODO: handle exception
		}

		if (null != gdp || null != rank) {

			CompositeKeyWritable cw = new CompositeKeyWritable(gdp, rank, city,
					hdi);

			try {

				context.write(cw, NullWritable.get());

			} catch (Exception e) {
				System.out.println(cw);
				System.out.println(values[8]);
				System.out.println("" + e.getMessage());
			}
		}
	}
}