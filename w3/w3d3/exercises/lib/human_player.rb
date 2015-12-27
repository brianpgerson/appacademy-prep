require "byebug"
require_relative "ship"

class HumanPlayer
	attr_accessor :input, :name, :board, :turns_left, :ships

	def initialize(name, board)
		@name = name
		@board = board
		@turns_left = 20
		@ships = []
	end

	def count
		count = @ships.length
	end

	def get_play
		puts "Where should we focus our attack, sir!?"
		input = gets.chomp.scan(/\d/).map { |e| e.to_i }
	end

	def create_ship
		ship_choices = %w[carrier battleship sub cruiser pt]
		ship_choices.each do |type|
			@board.own_board
			puts "Let's mobilize a #{type}, sir!"
			ship = get_ship_inputs(type)
			until @board.valid_ship?(self, ship)
				puts "Sir, that isn't a valid location for that ship. It's probably hanging off the edge of the board or overlapping another ship, sir."
				ship = get_ship_inputs(type)
			end	
			ships << ship
			@board.place_ship(self)
		end
	end

	def get_ship_inputs(type)
		type = type
		location = get_location
		direction = get_direction
		Ship.new(type, location, direction)
	end


	def get_location
		puts "Where should we place the ship, sir!?"
		location = gets.chomp.scan(/\d/).map { |e| e.to_i }
		unless location.length == 2
			"Please enter two numbers 0 - 9 as your location."
			location = gets.chomp.scan(/\d/).map { |e| e.to_i }
		end
		location
	end

	def get_direction
		puts "What direction should we point it, sir...right, or down?!?!"
		direction = gets.chomp
		unless direction =~ /(right)|(down)/
			puts "Pick a valid direction, ya dick."
			direction = gets.chomp
		end
		direction
	end

		def is_alive?(ship)
		report(ship).any? { |x| x == :SHIP }
	end

	def report(ship)
		report = []
		start = ship.location
		if ship.direction == "right"
			report = (start[0]..(start[0] + ship.length - 1)).to_a.map do |x| 
				self.board.grid[start[1]][x]
			end
		else 
			report = (start[1]..(start[1] + ship.length - 1)).to_a.map do |y| 
				if self.board.grid[y] != nil
					self.board.grid[y][start[0]]
				end
			end
		end
		report
	end

end
