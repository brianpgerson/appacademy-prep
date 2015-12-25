require "byebug"
class Code
	attr_reader :pegs

	PEGS = {
		"B" => :blue,
		"O" => :orange,
		"R" => :red,
		"G" => :green,
		"Y" => :yellow,
		"P" => :purple
	}

	def self.parse(input)
		pegs = input.downcase.split("")
		pegs.each do |peg|
			raise "Not a valid color!" unless PEGS.has_key? (peg.upcase)
		end
		Code.new(pegs)
	end

	def self.random
		random_code = []
		choices = %w[B O R G Y P]
		4.times do 
			random_code << choices[Random.rand(6)]
		end
		Code.new(random_code)
	end

	def initialize(pegs)
		@pegs = pegs
	end

	def [](i)
		pegs[i]
	end

	def == (code_object)
		return false if code_object.class != Code
		return true if self.pegs == code_object.pegs
	end

	def exact_matches(other_code)
		num_matches = 0
		0.upto(self.pegs.length - 1) do |i|
			if self[i] == other_code[i]
				num_matches += 1
			end
		end
		num_matches
	end

	def near_matches(other_code)
		near_matches = 0
		indices = []
		0.upto(self.pegs.length - 1) do |i|
			times_this_letter_matched = 0
			0.upto(other_code.pegs.length - 1) do |j|
				if self[i] == other_code[j] && !indices.include?(j) && times_this_letter_matched == 0
					indices << j
					near_matches += 1
					times_this_letter_matched += 1
				end
			end
		end
		near_matches - self.exact_matches(other_code)
	end

end

class Game
	attr_reader :secret_code

	def initialize(secret_code = nil)
		if secret_code == nil
			@secret_code = Code.random
		else 
			@secret_code = secret_code
		end
	end

	def get_guess
		input = $stdin
		Code.new(input)
	end

	def display_matches(guess)
		puts "exact matches: #{secret_code.exact_matches(guess)}"
		puts "near matches: #{secret_code.near_matches(guess)}"
	end

end


















