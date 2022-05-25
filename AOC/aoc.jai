#import "Basic";
#import "File";
#import "String";

DAY_1_DATA_PATH :: "AOC/day_1_data.txt";
SONAR :: "AOC/sonardata.txt";
TEST_PATH :: "AOC/test.txt";

main :: ()
{
	data, success := file_to_int_array(DAY_1_DATA_PATH);
	defer free(data.data);
	
	count :int;
	previous :int;
	for data
	{
		current := it;

		if it_index > 0
		{
			if (current > previous)
				count += 1;
		}
		previous = current;
	}

	print("%\n", count);
}

file_to_int_array :: (name : string) -> [] int, bool
{
	file_string, success := read_entire_file(name);

	split_strings := split(file_string, "\r\n");

	int_array := NewArray(split_strings.count, int);

	for split_strings
		int_array[it_index] = to_integer(it);

	return int_array, true;
}
