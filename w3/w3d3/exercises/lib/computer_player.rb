require_relative "board"
require "byebug"
class ComputerPlayer
	attr_accessor :input, :name, :board, :turns_left, :ships

	def initialize(name, board)
		@name = name
		@board = board
		@turns_left = 20
		@ships = []
	end

	def get_play
		puts "Where should we focus our attack, sir!?"
		puts "Computer is tthiiiinnnkkinggggg...."
		puts "Computer plays: #{smart_play}"
		smart_play
	end

	def smart_play
		previous_plays = []
		next_play = board.random_pos
		until !previous_plays.include?(next_play)
			next_play = board.random_pos
		end
		previous_plays << next_play
		next_play.scan(/\d/).map { |e| e.to_i }
	end

	def count
		@ships.length
	end

	def create_ship
		ship_choices = %w[carrier battleship sub cruiser pt]
		ship_choices.each do |type|
			ship = get_ship_inputs(type)
			until @board.valid_ship?(self, ship)
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
		location = board.random_pos.split("").map { |e| e.to_i }
	end

	def get_direction
		directions = ["right", "down"]
		directions[Random.rand(2)]
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
