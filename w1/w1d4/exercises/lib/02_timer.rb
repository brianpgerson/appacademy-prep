class Timer
	attr_accessor :seconds

	def seconds
		@seconds = 0
	end

	def time_string
		secs = @seconds % 60
		mins = @seconds / 60
		if mins > 60
			hours = mins / 60
			mins = mins % 60
		else
			hours = "00"
		end
		[padded(hours), padded(mins), padded(secs)].join(":")
	end

	def padded(n)
		n = n.to_s
		if n.length == 1
			padded_string = "0#{n}"
		else
			padded_string = n 
		end
		padded_string
	end
end