class HumanPlayer
	attr_accessor :name, :mark

	def initialize(name, mark = nil)
		@name = name
		@mark = mark
	end

	def display(board)
		board.grid.each do |row|
			print "#{row}\n"
		end
	end

	def get_move
		puts "Where should we move?"
		input = gets.chomp.split(", ").map { |e| e.to_i }
	end
end
