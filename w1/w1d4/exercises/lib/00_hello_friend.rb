class Friend
	def greeting(name = nil)
		if name == nil
			"Hello!"
		else
			"Hello, #{name}!"
		end
	end
end

dog = Friend.new
print dog
puts dog.greeting("BARKLAR")