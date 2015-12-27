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

end