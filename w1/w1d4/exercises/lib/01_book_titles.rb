class Book
	attr_accessor :title

	def title
		@title = format_title
	end

	def format_title
		formatted = []
		bad_words = %w{the a an and in of}

		arr = @title.split(" ")

		formatted << arr[0].capitalize!
		1.upto(arr.length - 1) do |i|
			arr[i] = arr[i].to_s
			if bad_words.include?(arr[i])
				formatted << arr[i]
			else
				formatted << arr[i].capitalize
			end
		end
		formatted.join(" ")
	end

end
