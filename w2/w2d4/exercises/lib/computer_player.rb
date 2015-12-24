require "byebug"
class ComputerPlayer
	attr_accessor :name, :board, :mark

	def initialize(name, mark = nil)
		@name = name
		@mark = mark
	end

	def display(board)
		@board = board
	end

	def get_move
		potential_winner = locate_winning_move?(board.rows, board.columns, board.diagonals)
		if potential_winner != nil
			potential_winner
		else
			random_move
		end
	end

	def locate_winning_move?(rows, cols, diags)
		rows.each.with_index do |row, i| 
			if row.uniq.length == 2 && row.select { |e| e == self.mark }.length == 2 
				return winning_move(rows, i, "rows")
			end
		end
		cols.each.with_index do |col, i| 
			if col.uniq.length == 2 && col.select { |e| e == self.mark }.length == 2 
				return winning_move(cols, i, "cols")
			end
		end
		diags.each.with_index  do |diag, i| 
			if diag.uniq.length == 2 && diag.select { |e| e == self.mark }.length == 2 
				return winning_move(diags, i, "diags")
			end
		end
		nil
	end

	def winning_move(lines, which_line, type)
		case type
		when "rows"
			row_winner(lines, which_line)
		when "cols"
			cols_winner(lines, which_line)
		when "diags"
			diags_winner(lines, which_line)
		end
	end

	def row_winner(rows, y)
		y = y
		not_x = rows[y].find { |e| e != self.mark }
		x = rows[y].index(not_x)
		return [y, x]
	end

	def cols_winner(cols, x)
		x = x
		not_y = cols[x].find { |e| e != self.mark }
		y = cols[x].index(not_y)
		return [y, x]
	end

	def diags_winner(lines, which_line)
		if which_line == 0
			x = lines[which_line].index(lines[which_line].find { |e| e != self.mark })
			[x, x]
		else
			not_comp_mark = lines[which_line].find { |e| e != self.mark }
			x = lines[which_line].length - 1 - lines[which_line].index(not_comp_mark)
			y = lines[which_line].index(not_comp_mark) 
			[y, x]
		end
	end


	def random_move
		max_y = board.grid.length
		max_x = board.grid[0].length
		move = [Random.rand(max_x), Random.rand(max_y)]
	end
end