//Keep in mind that this is not endian-safe, not even safe in the broader sense.

	public uint8[] str2bin (string address_string) requires (address_string.data.length %2 == 0) {
		var data = address_string.to_utf8 ();
		int i =0;
		int j = 0;
		var retval = new uint8[data.length /2];
		for ( i = 0; i < data.length; i+=2, j++) {
			char c = data[i];
			int val1 = c.xdigit_value () << 4;
			c = data[i+1];
			val1 += c.xdigit_value ();
			retval[j] = (uint8) val1;
		}
		return retval;
	}
	
	public string bin2str (uint8[] address) {
		var sb = new StringBuilder ();
		
		foreach (uint8 data in address) {
			var str = "".printf("%02x", data);
			sb.append(str);
		}
		var retval = (string) sb.data;
		retval.up ();
		return retval;		
	}
