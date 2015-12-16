class Dungeon
	attr_accessor :player

	def initialize(player_name)
		@player = Player.new(player_name)
		@rooms = []
	end

	def add_room(reference, name, description, connections)
		@rooms << Room.new(reference, name, description, connections)
	end

	def start(location)
		@player.location = location
		show_current_description
	end

	def show_current_description
		puts find_room(@player.location).full_description
	end

	def find_room(reference)
		@rooms.detect {|room| room.reference == reference}
	end

	def find_room_in_direction(direction)
		find_room(@player.location).connections[direction]
	end

	def go(direction)
		which_way = find_room_in_direction(direction)
		if which_way != nil
			@player.location = which_way
			puts "You go #{direction.to_s}" 
			show_current_description
		else 
			puts "You can't go that way!"
		end
	end

	class Player
		attr_accessor :name, :location

		def initialize(name)
			@name = name
		end
	end

	class Room
		attr_accessor :reference, :name, :description, :connections

		def initialize(reference, name, description, connections)
			@reference = reference
			@name = name
			@description = description
			@connections = connections
		end

		def full_description
			"#{@name}\n\nYou are in #{description}"
		end
	end

end

#create the main dungeon object
my_dungeon = Dungeon.new("Brian the Barker")

#add rooms
my_dungeon.add_room(:largecave, "Large Cave", "a large, cavernous cave, full of wonders and spoooooky objects.", {:west => :smallcave})

my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave, with a skeleton against the wall.", {:east => :largecave})

#start the game

my_dungeon.start(:largecave)
player_input = ""
puts "\nUse 'stop' to stop the game\n\n"
while true
	puts "What direction should #{my_dungeon.player.name} go?"
	player_input = gets.chomp
	if player_input =~ /west|east|north|south/
		my_dungeon.go(player_input.to_sym)
	elsif player_input == "stop"
		break
	else
		puts "Choose a cardinal direction, ya big doofus!" 
	end
end











