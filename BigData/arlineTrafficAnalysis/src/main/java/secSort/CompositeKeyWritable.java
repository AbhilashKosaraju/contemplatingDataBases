package secSort;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

import org.apache.hadoop.io.Writable;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableUtils;

public class CompositeKeyWritable implements Writable,
		WritableComparable<CompositeKeyWritable> {

	private String gdp;
	private String rank;
	private String city;
	private String hdi;

	public CompositeKeyWritable() {

	}

	public CompositeKeyWritable(String gdp, String rank, String city, String hdi) {
		super();
		this.gdp = gdp;
		this.rank = rank;
		this.city = city;
		this.hdi = hdi;
	}

	public int compareTo(CompositeKeyWritable o) {

		int result = gdp.compareTo(o.gdp);
		if (result == 0) {
			result = rank.compareTo(o.rank);
		}
		return result;
	}

	public void write(DataOutput d) throws IOException {

		WritableUtils.writeString(d, gdp);
		WritableUtils.writeString(d, rank);
		WritableUtils.writeString(d, city);
		WritableUtils.writeString(d, hdi);

	}

	public void readFields(DataInput di) throws IOException {

		gdp = WritableUtils.readString(di);
		rank = WritableUtils.readString(di);
		hdi = WritableUtils.readString(di);
		city = WritableUtils.readString(di);

	}

	public String getZipcode() {
		return gdp;
	}

	public void setZipcode(String zipcode) {
		this.gdp = zipcode;
	}

	public String getBikeId() {
		return rank;
	}

	public void setBikeId(String bikeId) {
		this.rank = bikeId;
	}

	public String toString() {
//		return (new StringBuilder().append(city).append("\t").append(gdp)
//				.append("\t").append(rank).append("\t").append("hdi")
//				.toString());
		
		return (hdi + "\t" + rank + "\t" + city);
	}

}
