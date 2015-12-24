require 'byebug'
# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
	attr_reader :towers

	def initialize
		@towers = [[3,2,1],[],[]] 
	end

	def move(from_tower, to_tower)
		if valid_move?(from_tower, to_tower)
			moving_disc = self.towers[from_tower].pop
			self.towers[to_tower] << moving_disc
		end
	end

	def valid_move?(from_tower, to_tower)
		return false if self.towers[from_tower].empty? || (self.towers[from_tower] == nil || self.towers[to_tower] == nil)
		if !self.towers[to_tower].empty?
			return false if self.towers[to_tower].last < self.towers[from_tower].last
		end
		true
	end

	def won?
		return true if self.towers[1].length == 3 || self.towers[2].length == 3
		false
	end

	def render
		print "The current Towers of Hanoi: #{self.towers}\n\n"
	end

	def play
		instructions
		while !won?
			self.render
			puts "Enter your next move."
			input = gets.chomp
			while input.scan(/\d\s\d/)[0] == nil
				if input == "exit"
					return
				end
				puts "Try again, using valid input."
				input = gets.chomp
			end
			from_tower, to_tower = input.split(" ")[0].to_i, input.split(" ")[1].to_i
			if valid_move?(from_tower, to_tower)
				move(from_tower, to_tower)
			else
				puts "That didn't work!"
			end
		end
		puts "You've WON!"
	end

	def instructions
		puts "Welcome to Towers of Hanoi!\n\nHere is the current setup: #{self.towers}\n\nPick a tower to move the top (right-most) disk from, and a tower to move it to.\n\nYou can move a disk to any tower that is empty, or where the moving disk is smaller than the top disk of the receiving tower. You will win when all three disks have successfully moved from the first tower.\n\nEnter your input like this: '0 1' to move a disk from the first tower to the second."
	end
end

game = TowersOfHanoi.new
towers = game.towers
game.play







