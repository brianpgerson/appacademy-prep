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
		random_pegs = random_code.join("").downcase
		Code.new(random_pegs)
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
		@turns_left = 10
	end

	def get_guess
		puts "Make a guess...if you dare. You have #{@turns_left} remaining."
		puts "(You must be feeling nervous...)" if @turns_left == 2
		puts "(Only one turn left, foolish human...)" if @turns_left == 1
		input = gets.chomp
		if input == "info"
			puts instructions
		end
		unless input =~ /([rbgopy][rbgopy][rbgopy][rbgopy])/
			puts "Please enter four colors. Your choices are RED, BLUE, GREEN, ORANGE, YELLOW, PURPLE."
			input = gets.chomp
		end
		guess = Code.new(input)
	end

	def display_matches(guess)
		puts "Your last guess was #{guess.pegs.split("")}. Here's how you did:"
		puts "Exact matches: #{secret_code.exact_matches(guess)}"
		puts "Near matches: #{secret_code.near_matches(guess)}\n"
	end

	def play_turn
		guess = get_guess
		if check_winner(guess)
			@turns_left = 0
		end
		display_matches(guess)
	end

	def check_winner(guess)
		if guess == @secret_code
			puts "You've broken my code! Robert Knuth would be so proud."
			true
		end
	end

	def instructions
		"I, as a superintelligent computing machine, have selected a code. That code consists of 4 colors (for example, red, blue, green, orange) in a particular order.\n\nThe possible colors are RED, BLUE, GREEN, ORANGE, YELLOW, and PURPLE. Your job is to guess the combination of colors that I have chosen.\n\nTo do so, enter a guess. To guess the example above, you'd type in 'rbgo'. Once you've guessed, I will tell you the number of exact matches — or correct colors in the correct positions — and near matches, which are the right colors in the wrong spots.\n\nIf my chosen code was 'brgo', the example you guessed would have two exact matches (green and orange), and two near matches (blue and red). The same color may be used more than once, so 'rrrr' is a valid guess.\n\nUse the clues to guess my code...and I will let you live. To display this information again, enter 'info'."
	end

	def play
		puts instructions
		while @turns_left > 0
			play_turn
			@turns_left -= 1
		end
		if @turns_left == 0
			puts "It's all over. Your human soul now belongs to me! The correct code was #{secret_code.pegs.split("")}" 
		end
	end

end






 game = Game.new
 game.play
