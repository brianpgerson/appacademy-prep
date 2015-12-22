require "byebug"

class Fixnum
	def hash_nums 
		hash_nums = 
		{
			0 => "zero",
			1 => "one",
			2 => "two",
			3 => "three",
			4 => "four",
			5 => "five",
			6 => "six",
			7 => "seven",
			8 => "eight",
			9 => "nine",
			10 => "ten",
			11 => "eleven",
			12 => "twelve",
			13 => "thirteen",
			14 => "fourteen",
			15 => "fifteen",
			16 => "sixteen",
			17 => "seventeen",
			18 => "eighteen",
			19 => "nineteen",
			20 => "twenty",
			30 => "thirty",
			40 => "forty",
			50 => "fifty",
			60 => "sixty",
			70 => "seventy",
			80 => "eighty",
			90 => "ninety"
		}
	end

	def in_words
		arr = self.to_s.split("")
		n = arr.length
		if n < 4 then variable_length_period(arr).strip
		else
			the_rest = arr.slice(n%3..-1).join("").scan(/.{1,3}/)
			trailing_periods = the_rest.map.with_index do |el, i| 
				if el != "000"
					"#{three_digit_period(el.split(""))}#{groups(the_rest.length - i)}"
				end
			end
			first_period = variable_length_period(arr.slice(0, n%3))
			"#{first_period}#{groups((n/3) + 1)} #{trailing_periods.join(" ")}".gsub!(/\s+/, " ").strip
		end
	end

	def variable_length_period(digits)
		case digits.length
		when 0
			""
		when 1
			hash_nums[digits[0].to_i]
		when 2
			tens_and_ones(digits)
		when 3
			three_digit_period(digits)
		end
	end

	def tens_and_ones(two_digits)
		if special_case?(two_digits, true)
			tens_n_ones = special_case?(two_digits)
		elsif two_digits[0] != "0" && two_digits[1] != "0"
			tens_n_ones = "#{hash_nums[(two_digits[0].to_i) * 10]} #{hash_nums[two_digits[1].to_i]}" 
		elsif two_digits[0] != "0"
			tens_n_ones = "#{hash_nums[(two_digits[0].to_i) * 10]}"
		else
			tens_n_ones = "#{hash_nums[two_digits[1].to_i]}"
		end
	end

	def special_case?(two_digits, checking = false)
		teen = two_digits.join("").to_i.between?(11,19)
		zeros = two_digits.join("") == "00"
		if checking
			teen || zeros
		else
			if teen
				hash_nums[two_digits.join("").to_i]
			else
				""
			end
		end
	end

	def three_digit_period(one_period)
		if one_period[0] != "0" 
			hundreds = "#{hash_nums[one_period[0].to_i]} hundred "
		else 
			hundreds == ""
		end
		tens_n_ones = tens_and_ones(one_period.slice(1..-1))
		sect_answer = "#{hundreds}#{tens_n_ones}"
		sect_answer
	end

	def groups(n)
		case n
		when 0, 1 
			""
		when 2
			" thousand"
		when 3
			" million"
		when 4
			" billion"
		when 5 
			" trillion"
		end
	end

end

print 4.in_words

