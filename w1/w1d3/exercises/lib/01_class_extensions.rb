# String: Caesar cipher
#
# * Implement a Caesar cipher: http://en.wikipedia.org/wiki/Caesar_cipher
#
# Example:
#   `"hello".caesar(3) # => "khoor"`
#
# * Assume the text is all lower case letters.
# * You'll probably want to map letters to numbers (so you can shift
#   them). You could do this mapping yourself, but you will want to use
#   the [ASCII codes][wiki-ascii], which are accessible through
#   `String#ord` or `String#each_byte`. To convert back from an ASCII code
#   number to a character, use `Fixnum#chr`.
# * Important point: ASCII codes are all consecutive!
#     * In particular, `"b".ord - "a".ord == 1`.
# * Lastly, be careful of the letters at the end of the alphabet, like
#   `"z"`! Ex.: `caesar("zany", 2) # => "bcpa"`

class String
	def caesar(shift)
		code_hash = {
			97 => "a", 
			98 => "b", 
			99 => "c", 
			100 => "d",
			101 => "e",
			102 => "f",
			103 => "g",
			104 => "h",
			105 => "i",
			106 => "j",
			107 => "k",
			108 => "l",
			109 => "m",
			110 => "n",
			111 => "o",
			112 => "p",
			113 => "q",
			114 => "r",
			115 => "s",
			116 => "t",
			117 => "u",
			118 => "v",
			119 => "w",
			120 => "x",
			121 => "y",
			122 => "z"
		}
		new_arr = self.split("");
		codes = new_arr.map do |letter|
			if letter.ord + shift > 122
				(letter.ord + shift) - 26
			else
				letter.ord + shift
			end
		end
		new_word = (codes.map {|num| code_hash[num] }).join("")
	end
end

# Hash: Difference
#
# Write a method, `Hash#difference(other_hash)`. Your method should return
# a new hash containing only the keys that appear in one or the other of
# the hashes (but not both!) Thus:
#
# ```ruby
# hash_one = { a: "alpha", b: "beta" }
# hash_two = { b: "bravo", c: "charlie" }
# hash_one.difference(hash_two)
#  # => { a: "alpha", c: "charlie" }
# ```

class Hash
	def difference(other_hash)
		new_hash = {}
		self.each do |key, value|
			if !(self.include?(key) && other_hash.include?(key))
				new_hash[key] = value
			end
		end
		other_hash.each do |key, value|
			if !(other_hash.include?(key) && self.include?(key))
				new_hash[key] = value
			end
		end
		new_hash
	end
end

# Stringify
#
# In this exercise, you will define a method `Fixnum#stringify(base)`,
# which will return a string representing the original integer in a
# different base (up to base 16). **Do not use the built-in
# `#to_s(base)`**.
#
# To refresh your memory, a few common base systems:
#
# |Base 10 (decimal)     |0   |1   |2   |3   |....|9   |10  |11  |12  |13  |14  |15  |
# |----------------------|----|----|----|----|----|----|----|----|----|----|----|----|
# |Base 2 (binary)       |0   |1   |10  |11  |....|1001|1010|1011|1100|1101|1110|1111|
# |Base 16 (hexadecimal) |0   |1   |2   |3   |....|9   |A   |B   |C   |D   |E   |F   |
#
# Examples of strings your method should produce:
#
# ```ruby
# 5.stringify(10) #=> "5"
# 5.stringify(2)  #=> "101"
# 5.stringify(16) #=> "5"
#
# 234.stringify(10) #=> "234"
# 234.stringify(2)  #=> "11101010"
# 234.stringify(16) #=> "EA"
# ```
#
# Here's a more concrete example of how your method might arrive at the
# conversions above:
#
# ```ruby
# 234.stringify(10) #=> "234"
# (234 / 1)   % 10  #=> 4
# (234 / 10)  % 10  #=> 3
# (234 / 100) % 10  #=> 2
#                       ^
#
# 234.stringify(2) #=> "11101010"
# (234 / 1)   % 2  #=> 0
# (234 / 2)   % 2  #=> 1
# (234 / 4)   % 2  #=> 0
# (234 / 8)   % 2  #=> 1
# (234 / 16)  % 2  #=> 0
# (234 / 32)  % 2  #=> 1
# (234 / 64)  % 2  #=> 1
# (234 / 128) % 2  #=> 1
#                      ^
# ```
#
# The general idea is to each time divide by a greater power of `base`
# and then mod the result by `base` to get the next digit. Continue until
# `num / (base ** pow) == 0`.
#
# You'll get each digit as a number; you need to turn it into a
# character. Make a `Hash` where the keys are digit numbers (up to and
# including 15) and the values are the characters to use (up to and
# including `F`).
class Fixnum
	def stringify(base)
		digit_hash = {
			0 => "0",
			1 => "1", 
			2 => "2", 
			3 => "3", 
			4 => "4", 
			5 => "5", 
			6 => "6", 
			7 => "7", 
			8 => "8", 
			9 => "9", 
			10 => "a", 
			11 => "b", 
			12 => "c", 
			13 => "d", 
			14 => "e", 
			15 => "f", 
			16 => "g"
		}
		basepower = 1
		digits = []
		if base == 10
			return self.to_s
		elsif self <= base
			return digit_hash[self]
		end
		while basepower < self
			digits << ((self/basepower)%base)
			basepower *= base
		end
		digits.reverse!
		coded = (digits.map { |dig| digit_hash[dig] }).join("")
	end
end

# Bonus: Refactor your `String#caesar` method to work with strings containing
# both upper- and lowercase letters.
