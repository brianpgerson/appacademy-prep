def fizz_buzz(string)
	input = string.split(" ").map { |e| e.to_i }
	output = []
	1.upto(input[2]) do |i|
		if i % input[0] == 0 && i % input[1] == 0 
			output << "FB"
		elsif i % input[0] == 0 
			output << "F"
		elsif i % input[1] == 0
			output << "B"
		else
			output << i.to_s
		end
	end	
	puts output.join(" ").strip
end

#File.open(ARGV[0]).each_line do |series|
#   fizz_buzz(series)
#end

def is_prime?(n)
	check = true
	2.upto(n-1) { |i| check = false if n % i == 0 }
	check
end



def palindrome_prime
	biggest_prime = 2
	2.upto(1000) do |n|
		biggest_prime = n if is_prime?(n) && n.to_s == n.to_s.reverse!
	end
	print biggest_prime
end

palindrome_prime
