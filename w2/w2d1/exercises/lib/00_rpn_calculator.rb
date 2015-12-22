require "byebug"

class RPNCalculator
	attr_accessor = :calculator
	
	def initialize
		@calculator = []
	end

	def value
		n = @calculator.length
		@calculator[n - 1]
	end

	def check
		if @calculator.length <= 1
			raise "calculator is empty"
		else
			true
		end
	end

	def push(val)
		if val.class == Fixnum
			@calculator.push(val)
		else
			raise "Not a valid input!"
		end
	end

	def pop
		if @calculator.length > 1
			@calculator.pop
		end
	end

	def plus
		if check
			@calculator << @calculator.pop + @calculator.pop
		end
	end

	def minus
		if check
			@calculator << (-1 * @calculator.pop) + @calculator.pop
		end
	end


	def times
		if check
			@calculator << @calculator.pop * @calculator.pop
		end
	end

	def divide
		if check
			n1 = @calculator.pop.to_f
			n2 = @calculator.pop.to_f
			@calculator << (n2 / n1).to_f
		end
	end

	def tokens(string)
		arr = string.split(" ")
		syms = arr.map do |n|
			if n =~ /[\+\*\/\-]/ 
				n.to_sym
			else
				n.to_i
			end
		end
		syms
	end


end

