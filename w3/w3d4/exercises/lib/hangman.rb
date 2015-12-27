require 'io/console'
require "byebug"
class Hangman
	attr_reader :guesser, :referee, :board

	def initialize(players)
		@guesser = players[:guesser]
		@referee = players[:referee]
		@board = nil
		@guesses_remaining = 10
	end

	def setup
		length = @referee.pick_secret_word
		@guesser.register_secret_length(length)
		@board = Array.new(length)
	end

	def take_turn
		guess = @guesser.guess(@board)
		response = @referee.check_guess(guess)
		update_board(guess, response)
		guesser.handle_response(guess, response)
		@guesses_remaining -= 1
	end

	def update_board(letter, indices)
		indices.each { |i| board[i] = letter }
	end

	def play
		setup
		until @guesses_remaining == 0
			if won?
				puts "You win!"
				break
			else
				take_turn
			end
		end
	end
	
	def won?
		return true if !@board.include?(nil)
		false
	end

end

class HumanPlayer
	def initialize
		@secret_word = nil
		@secret_length = nil

	end

	def pick_secret_word
		if self.class == HumanPlayer
			@secret_word =  passwd = `read -s -p "Your secret word: " word; echo $word`.chomp
			puts "The word is #{@secret_word.length} letters long."
		else
			@secret_word = gets.chomp
		end
		@secret_word.length
	end

	def check_guess(letter)
		indices = []
		@secret_word.split("").each.with_index do |secret_letter, index|
			indices << index if letter == secret_letter
		end
		indices
	end

	def register_secret_length(length)
    puts "Secret is #{length} letters long"
	end


	def guess(board)
		display = board.map do |space| 
			if space == nil 
				space = "_" 
			else
				space = space
			end
		end
		print "#{display.join("")}\n"
		puts "Time to guess a letter, dumbass."
		guess = $stdin.gets.chomp
	end

	def handle_response(letter, indices)
		puts "Your guess of #{letter} was present #{indices.length} times."
	end

end

class ComputerPlayer
	 def self.player_with_dict_file(dict_file_name)
    ComputerPlayer.new(File.readlines(dict_file_name).map(&:chomp))
  end

	attr_reader :dictionary

	def initialize(dictionary)
		@dictionary = dictionary
		@secret_word = nil
		@secret_length = nil
		@candidate_words = []
		@guesses = []
	end

	def candidate_words
		@candidate_words
	end

	def pick_secret_word
		@secret_word = @dictionary[Random.rand(@dictionary.length)]
		@secret_word.length
	end

	def check_guess(letter)
		indices = []
		@secret_word.split("").each.with_index do |secret_letter, index|
			indices << index if letter == secret_letter
		end
		indices
	end

	def register_secret_length(length)
		@secret_length = length
		@candidate_words = @dictionary.select { |word| word.length == @secret_length }
	end


	def guess(board)
		common = get_common_letter(board)
		@guesses << common
		puts common
		common
	end


	def get_common_letter(board)
		letters = @candidate_words.join("")
		uniques = letters.split("").uniq
		most_common_letter_frequency = 0
		most_common_letter = nil
		uniques.each do |letter|
			if letters.scan(letter).length >= most_common_letter_frequency &&
				!@guesses.include?(letter) && !board.include?(letter)
				most_common_letter_frequency = letters.scan(letter).length
				most_common_letter = letter
			end
		end
		most_common_letter
	end

	def handle_response(letter, indices)
		if !indices.empty?
			narrowed_down = @candidate_words.select do |word|
				indices.map { |i| word[i] }.uniq[0] == letter && 
				word.scan(letter).length == indices.length 
			end
		else
			narrowed_down = @candidate_words.reject do |word|
				word.index(letter) != nil
			end
		end
		@candidate_words = narrowed_down
	end

end

if __FILE__ == $PROGRAM_NAME
  # use print so that user input happens on the same line
  print "Guesser: Computer (yes/no)? "
  if gets.chomp == "yes"
    guesser = ComputerPlayer.player_with_dict_file("lib/dictionary.txt")
  else
    guesser = HumanPlayer.new
  end

  print "Referee: Computer (yes/no)? "
  if gets.chomp == "yes"
    referee = ComputerPlayer.player_with_dict_file("lib/dictionary.txt")
  else
    referee = HumanPlayer.new
  end

  Hangman.new({ :guesser=>guesser,:referee=>referee }).play
end