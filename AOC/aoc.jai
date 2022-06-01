#import "Basic";
#import "File";
#import "String";

main :: ()
{
	TEST_PATH :: "AOC/test.txt";

	DAY_1_DATA_PATH :: "AOC/day_1_data.txt";
	{
		print("\nDay 1:\n");
		data, success := file_to_int_array(DAY_1_DATA_PATH);
		defer free(data.data);

		if !success
			print("Something went wrong!");

		day_1_part_1(data);
		day_1_part_2(data);
	}

	DAY_2_DATA_PATH :: "AOC/day_2_data.txt";
	{
		print("\nDay 2:\n");
		commands := file_to_commmands(DAY_2_DATA_PATH);

		day_2_part_1(commands);
		day_2_part_2(commands);
	}

	DAY_3_DATA_PATH :: "AOC/day_3_data.txt";
	{
		print("\nDay 3:\n");
		// Read in the data
		file_string, success := read_entire_file(DAY_3_DATA_PATH);
		//file_string, success := read_entire_file(TEST_PATH);
		numbers := split(file_string, "\r\n");

		day_3_part_1(numbers);
		day_3_part_2(numbers);
	}
}


day_3_part_2 :: (numbers : [] string)
{
	// Get number of digits per binary number
	number_of_digits := numbers[0].count;

	valid_numbers : [..] string;
	for numbers
	{
		array_add(*valid_numbers, it);
	}

	oxygen_rating : u64 = 0;
	{
		for i : 0..number_of_digits-1
		{
			if valid_numbers.count == 1
				break;

			count := 0;
			for valid_numbers
			{
				character := it[i];

				if (character == #char "0")
					count -= 1;
				else 
					count += 1;
			}

			target_char := #char "0";
			if count >= 0
			{
				target_char = #char "1";
			}

			for valid_numbers
			{
				character := it[i];

				if character != target_char
				{
					remove it;
				}
			}
		}

		oxygen_rating = binary_number_string_to_u64(valid_numbers[0]);
	}

	array_reset(*valid_numbers);
	for numbers
	{
		array_add(*valid_numbers, it);
	}

	scrubber_rating : u64 = 0;
	{
		for i : 0..number_of_digits-1
		{
			if valid_numbers.count == 1
				break;

			count := 0;
			for valid_numbers
			{
				character := it[i];

				if (character == #char "0")
					count -= 1;
				else 
					count += 1;
			}

			target_char := #char "0";
			if count < 0
			{
				target_char = #char "1";
			}

			for valid_numbers
			{
				character := it[i];

				if character != target_char
				{
					remove it;
				}
			}
		}

		scrubber_rating = binary_number_string_to_u64(valid_numbers[0]);
	}
	
	print("Part 2 :: (Oxygen: %, Scrubber %) MULT: %\n", oxygen_rating, scrubber_rating, oxygen_rating * scrubber_rating);
}

binary_number_string_to_u64 :: (number : string) -> u64
{
	number_of_digits := number.count;

	result : u64 = 0;

	for d : 0..number_of_digits-1
	{
		// We're little endian so flip
		shift := cast(u64) ((number_of_digits-1) - d);

		if (number[d] == #char "1" )
			result |= cast(u64)1 << shift;
	}

	return result;
}

day_3_part_1 :: (numbers : [] string)
{
	// Get number of digits per binary number
	number_of_digits := numbers[0].count;

	// Create an array with a count per bit 
	per_bit_count := NewArray(number_of_digits, int);
	defer free(per_bit_count.data);

	// Go over every binary number
	for numbers
	{
		current_number := it;

		// Then over every one of their bits to tally their frequency
		for i : 0..number_of_digits-1
		{
			character := current_number[i];

			if (character == #char "0")
				per_bit_count[i] -= 1;
			else 
				per_bit_count[i] += 1;
		}
	}

	// Get the most common bit and pass it to decimal
	gamma : u64 = 0;
	epsilon : u64 = 0;

	for  d : 0..number_of_digits-1
	{
		// We're little endian so flip
		shift := cast(u64) ((number_of_digits-1) - d);

		num : u64 = cast(u64)1 << shift;
		if (per_bit_count[d] > 0)
			gamma |= num;
		else 
			epsilon |= num;
	}

	print("Part 1 :: (Gamma: %, Epsilon: %) MULT: %\n", gamma, epsilon, gamma * epsilon);
}

Command_Type :: enum u32
{
	NULL;
	FORWARD;
	DOWN;
	UP;
}

Command :: struct
{
	command : Command_Type;
	value : int;
};

day_2_part_2 :: (commands : [] Command)
{
	position := 0;
	depth := 0;
	aim := 0;

	for commands
	{
		if it.command == 
		{
			case .DOWN;
				aim += it.value;
			case .UP;
				aim -= it.value;
			case .FORWARD;
				position += it.value;
				depth += it.value * aim;
		}
	}

	print("Part 2 :: (Position: %, Depth: %) MULT: %\n", position, depth, position * depth);
}

day_2_part_1 :: (commands :[] Command)
{
	pos_x := 0;
	pos_y := 0;

	for commands
	{
		if it.command == 
		{
			case .DOWN;
				pos_y += it.value;
			case .UP;
				pos_y -= it.value;
			case .FORWARD;
				pos_x += it.value;
		}
	}

	print("Part 1 :: (%, %) MULT: %\n", pos_x, pos_y, pos_x * pos_y);
}

day_1_part_2 :: (numbers : [] int)
{
	count := 0;
	previous := 0;

	for numbers 
	{
		if (it_index + 2) == numbers.count
			break;

		current := numbers[it_index + 0] + numbers[it_index + 1] + numbers[it_index + 2];

		if it_index > 0
		{
			if (current > previous)
				count += 1;
		}

		previous = current;
	}

	print("Part 2 :: %\n", count);
}

day_1_part_1 :: (numbers : [] int)
{
	count := 0;
	previous := 0;

	for numbers
	{
		current := it;

		if it_index > 0
		{
			if (current > previous)
				count += 1;
		}
		previous = current;
	}
	print("Part 1 :: %\n", count);
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

file_to_commmands :: (name :string) -> [..] Command
{
	// Get the data
	commands : [..] Command;
	file_string, success := read_entire_file(name);
	split_strings := split(file_string, "\r\n");

	for split_strings
	{
		command_as_string := split(it, " ");
		c : Command;
		c.command = string_to_command(command_as_string[0]);
		c.value = to_integer(command_as_string[1]);

		array_add(*commands, c);
	}

	return commands;
}

string_to_command :: (s : string) -> Command_Type
{
	if s.data[0] == 
	{
		case #char "f";
			return .FORWARD;
		case #char "u";
			return .UP;
		case #char "d";
			return .DOWN;
	}

	return .NULL;
}
