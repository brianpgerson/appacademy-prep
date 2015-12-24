require "byebug"

class Board
	attr_accessor :grid

	def self.blank_grid
		Array.new(3) { Array.new(3) }
	end

	def initialize(grid = Board.blank_grid)
		@grid = grid
	end

	def [](row, col)
		grid[row][col]
	end

	def []=(row, col, value)
		grid[row][col] = value
	end

	def empty?(pos)
		self[*pos].nil?
	end

	def place_mark(pos, mark)
		self[*pos] = mark
	end

	def rows(grid = @grid)
		rows = grid.map { |el| el }
	end

	def diagonals
		left_diag = @grid.map.with_index { |row, i| row[i] }
		right_diag = @grid.map.with_index { |row, i| row[row.length - 1 - i] }
		[left_diag, right_diag]
	end

	def columns
		transposed = transpose(self.grid)
	end

	def transpose(array)
		transposed_array = []
		0.upto(array.length - 1) do |i|
			new_row = []
			0.upto(array[i].length - 1) do |j|
				new_row << array[j][i]
			end
			transposed_array << new_row
		end
		transposed_array
	end

	def winner
		rows.each { |row| return row[0] if row.uniq.length == 1  && row[0] != nil}
		diagonals.each { |diag| return diag[0] if diag.uniq.length == 1 && diag[0] != nil}
		columns.each { |column| return column[0] if column.uniq.length == 1 && column[0] != nil}
		nil
	end

	def tied
		@grid.each do |row|
			return false if row.any? { |el| el == nil }
		end
		return true
	end

	def over?
		if winner != nil || tied == true
			return true
		end
		false
	end


end













