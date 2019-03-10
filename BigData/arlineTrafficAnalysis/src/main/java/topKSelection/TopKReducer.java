package topKSelection;

import java.io.IOException;
import java.util.TreeMap;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
 
public class TopKReducer extends Reducer<NullWritable, Text, NullWritable, Text> {

	private TreeMap<Integer, Text> recordsMap;
	
	@Override
	protected void setup(Reducer<NullWritable, Text, NullWritable, Text>.Context context)
			throws IOException, InterruptedException {
		this.recordsMap = new TreeMap<Integer, Text>();
	}
	
	@Override
	protected void reduce(NullWritable arg0, Iterable<Text> arg1,
			Reducer<NullWritable, Text, NullWritable, Text>.Context arg2) throws IOException, InterruptedException {
		
		for (Text t : arg1) {
			String values[] = t.toString().split("\t");
			String userId = values[0];
			String reputation = values[2];
			recordsMap.put(Integer.parseInt(reputation), new Text("UserId: "+ userId + "\t" + "Reputation: " + reputation));
		}
		
		if (recordsMap.size() > 10) {
			recordsMap.remove(recordsMap.firstKey());
		}
	}
	
	@Override
	protected void cleanup(Reducer<NullWritable, Text, NullWritable, Text>.Context context)
			throws IOException, InterruptedException {
		for (Text t : recordsMap.values()) {
			context.write(NullWritable.get(), t);
		}
	}
}