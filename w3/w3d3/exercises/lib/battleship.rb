require_relative "board"
require_relative "human_player"
require_relative "computer_player"
require_relative "ship"

require "byebug"

class BattleshipGame
	attr_reader :player_one, :player_two

	def initialize(player_one, player_two)
		@player_one = player_one
		@player_two = player_two
		@current_player = player_one
		@other_player = player_two
	end

	def attack(pos)
		if @other_player.board.grid[pos[1]][pos[0]] == :SHIP
			@other_player.board.grid[pos[1]][pos[0]] = :HIT!
		else
			@other_player.board.grid[pos[1]][pos[0]] = :MISS
		end

	end

	def switch_players!
		@current_player = @current_player == player_one ? player_two : player_one
		@other_player = @other_player == player_two ? player_one : player_two
	end

	def count_ships
		@other_player.count
	end

	def count_hits
		@other_player.board.count_hits
	end

	def play_turn
		display_status
		self.attack(@current_player.get_play)
		ship_destroyed?
		@current_player.turns_left -= 1
		switch_players!
	end

	def display_status
		puts "Your own board:"
		@current_player.board.own_board
		puts "Your map on your opponent's board:"
		@other_player.board.other_board
		puts "#{count_ships} ships remaining."
		puts "#{count_hits} successful attacks"
		puts "Remaining missile count: #{@current_player.turns_left}"
	end

	def setup_board
		@player_one.create_ship
		@player_two.create_ship

	end

	def play
		setup_board
		until @current_player.turns_left == 0
			if !won?
				play_turn
			else
				return "Wow, you win!"
			end
		end
		puts "You LOSE!"
	end

	def ship_destroyed?
		@other_player.ships.each do |ship|
			if !@other_player.is_alive?(ship)
				remove_ship(@other_player.ships.index(ship))
				puts "A #{ship.type} was destroyed!"
			end
		end
	end

	def remove_ship(index)
		@other_player.ships.delete_at(index)
	end


	def won?
		true if count_ships == 0
	end

end


player_one = HumanPlayer.new("Barklar", Board.new)
player_two = ComputerPlayer.new("Compy", Board.new)
game = BattleshipGame.new(player_one, player_two)
game.play