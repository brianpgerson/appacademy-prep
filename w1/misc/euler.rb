require "byebug"
def multiples_of_three_five(n)
	answer = 0
	counter = 0
	while counter < n
		answer += counter if counter % 3 == 0 || counter % 5 == 0
		counter += 1
	end
	puts answer
end

def fibonacci_sequence(a, b)
	if b > 4000000
		return 0
	elsif b % 2 != 0
		return fibonacci_sequence(b, a + b)
	else 
		return b + fibonacci_sequence(b, a + b)
	end
end


def is_not_prime?(n)
	(2...n).to_a.any? { |num| n % num == 0 }
end

def make_sieve_hash(n)
	a = {}
	2.upto(n) do |i|
		a[i] = true
	end
	a
end

def prime_sieve(n)
	hash = make_sieve_hash(n)
	2.upto(Math.sqrt(n)) do |i|
		if hash[i] == true
			(i*i..n).step(i) { |el| hash[el] = false }
		end
	end
	a = hash.select do |key, value|
		value == true
	end
	a.keys.reverse	
end


def largest_prime_factor(n)
	primes = prime_sieve(Math.sqrt(n).to_i)
	primes.each do |prime|
		if n % prime == 0
			return prime
		end
	end
end

def product_of_trip_digits?(n)
	a = (100..999).to_a.reverse
	a.any? do |fac|
		n % fac == 0 && a.include?(n / fac)
	end
end


def largest_palindrome_product(n)
	palindromes = (0..n).to_a.select { |num| num.to_s == num.to_s.reverse }.sort.reverse
	palindromes.each do |pal|
		if product_of_trip_digits?(pal)
			return pal
		end
	end
end

puts largest_palindrome_product(998001)

