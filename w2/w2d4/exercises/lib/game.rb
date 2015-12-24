require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
	attr_accessor :board, :player_one, :player_two, :current_player

	def initialize(player_one, player_two)
		@player_one, @player_two = player_one, player_two
		@board = Board.new
		@player_one.mark = :X
		@player_two.mark = :O
		@current_player = player_one
	end

	def board
		@board
	end

	def play_turn
		board.place_mark(@current_player.get_move, @current_player.mark)
		switch_players!
		current_player.display(board)
	end

	def switch_players!
		@current_player = current_player == player_one ? player_two : player_one
	end

	def play
		until board.over?
			play_turn
		end
		if board.winner != nil
			current_player.display(board)
			puts "#{game_winner} wins!"
		else
			puts "Cat's game, losers"
		end
	end

	def game_winner
		return player_one.name if board.winner == player_one.mark
		return player_two.name if board.winner == player_two.mark
	end
end


if $PROGRAM_NAME == __FILE__
  jane = HumanPlayer.new('jane')
  garry = ComputerPlayer.new('garry')
  g = Game.new(jane, garry)
  g.play
end
