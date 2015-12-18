class Temperature

	def initialize(options)
		if options[:f]
			@fahrenheit = options[:f]
		else
			@celsius = options[:c]
		end
	end

	def self.ctof(temp)
		(temp)/5.to_f*9.to_f + 32
	end

	def self.ftoc(temp)
		(temp - 32)/9.to_f*5.to_f
	end

	def in_fahrenheit
		if @fahrenheit == nil
			self.class.ctof(@celsius)
		else
			@fahrenheit
		end
	end

	def in_celsius
		if @celsius == nil
			self.class.ftoc(@fahrenheit)
		else
			@celsius
		end
	end

	def self.from_celsius(temp)
		Temperature.new(:c => temp)
	end

	def self.from_fahrenheit(temp)
		Temperature.new(:f => temp)
	end

end

class Celsius < Temperature
	def initialize(temp)
		@celsius = temp
	end
end

class Fahrenheit < Temperature
	def initialize(temp)
		@fahrenheit = temp
	end
end
