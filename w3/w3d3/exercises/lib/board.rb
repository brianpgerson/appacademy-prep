require "byebug"
require_relative "ship"
require_relative "human_player"
require_relative "computer_player"

class Board
	attr_accessor :grid

	def self.default_grid
		Array.new(10) { Array.new(10) { "[ ]" }}
	end

	def initialize(grid = Board.default_grid)
		@grid = grid 
	end


	def count_hits
		count = 0
		self.grid.each do |row|
			row.each do |space|
				count += 1 if space == :HIT!
			end
		end
		count
	end

	def own_board
		print top_row
		self.grid.each.with_index do |row, i|
			print "#{i}: #{row}\n"
		end
	end

	def other_board
		print top_row
		safe_view(@other_player).each.with_index do |row, i|
			print "#{i}: #{row}\n"
		end
	end

	def top_row
		top_row = []
		0.upto(self.grid[0].length - 1) do |i|
			top_row << " #{i} "
		end
		"X: #{top_row}\n"
	end



	def safe_view(player)
		self.grid.map do |row|
			row.map do |pos|
				if pos == :HIT!
					pos = :HIT!
				elsif pos == :MISS
					pos = :MISS
				else
					pos = "[ ]"
				end
			end
		end
	end


	def [](*pos)
		pos = pos[0]
		@grid[pos[1]][pos[0]]
	end


	def random_pos
		y = Random.rand(self.grid.length)
		x = Random.rand(self.grid[0].length)
		pos = [x,y].join("")
	end

	def valid_ship?(player, ship)
		direction = ship.direction
		length = ship.length
		start = ship.location
		if direction == "right"
			check = (start[0]..(start[0] + length - 1)).to_a.map do |x| 
				player.board.grid[start[1]][x]
			end
		else 
			check = (start[1]..(start[1] + length - 1)).to_a.map do |y| 
				if player.board.grid[y] != nil
					player.board.grid[y][start[0]]
				else
					return false
				end
			end
		end
		!check.any? { |e| e == nil || e == :SHIP }
	end


	def place_ship(player)
		ship = player.ships.last
		direction = ship.direction
		length = ship.length
		start = ship.location
		if direction == "right"
			start[0].upto(start[0] + length - 1) do |x|
				player.board.grid[start[1]][x] = :SHIP
			end
		else 
			start[1].upto(start[1] + length - 1) do |y|
				player.board.grid[y][start[0]] = :SHIP
			end
		end
	end

end
