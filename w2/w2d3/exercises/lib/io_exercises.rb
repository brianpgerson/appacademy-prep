# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
	my_number = rand(1..100)
	puts "Guess a number!"
	guess = gets.chomp.to_i
	num_guesses = 1
	while guess != my_number
		puts guess
		puts "too high" if guess > my_number
		puts "too low" if guess < my_number
		num_guesses += 1
		guess = gets.chomp.to_i
	end
	puts guess
	puts num_guesses
end

def file_shuffle
	if ARGV != ""
		file_name = ARGV[0]
	else 
		puts "What shall we shuffle today, master!?!?!"
		file_name = gets.chomp
	end
	contents = File.readlines(file_name)
	contents.shuffle!
	puts contents

	File.open("#{file_name.split(".")[0]}-shuffled.txt", "w") do |f|
		f.puts "This is the new version"
		f.puts contents
		f.close
	end
end

file_shuffle

