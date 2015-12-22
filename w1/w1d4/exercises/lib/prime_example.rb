require 'byebug'

def prime?(num)

  (2...num).each do |idx|
    if num % idx == 0
      return false
    end
  end
  true
end

def primes(num_primes)
	debugger

  ps = []
  num = 2
  while ps.count < num_primes
    ps << num if prime?(num)
    num += 1
  end
  ps.join(", ")
end