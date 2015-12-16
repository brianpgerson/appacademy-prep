def add(a, b)
	a + b
end

def subtract(a, b)
	a - b 
end

def sum(arr)
	total = 0
	arr.each { |el| 
		total += el
	}
	return total
end

def multiply(arr)
	product = 1
	arr.each {|el|
		product *= el
	}
	return product
end

def power(base, power)
	base ** power
end

def factorial(n)
	if n == 0
		return 1
	else 
		return n * factorial(n - 1)
	end
end
