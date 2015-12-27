require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Ship
	attr_accessor :type, :location, :direction, :length
	def initialize(type, location, direction)
		@type = type
		case type
		when "carrier"
			@length = 5
		when "battleship"
			@length = 4
		when "sub"
			@length = 3
		when "cruiser"
			@length = 2
		when "pt"
			@length = 1
		end
		@location = location
		@direction = direction
	end

	def report
		report = []
		start = @location
		if direction == "right"
			start = location[0]
			start.upto(start + @length - 1) do |x|
				report << board.grid[start[1]][x]
			end
		else 
			start = location[1]
			start.upto(start + @length - 1) do |y|
				report << board.grid[y][start[0]]
			end
		end
	end

	def alive?
		report.any { |x| x == :SHIP }
	end

end