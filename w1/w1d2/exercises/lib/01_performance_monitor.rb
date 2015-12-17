def measure(n=1)
	start = Time.now
	if n == 1
		yield
		return Time.now - start
	else
		n.times{yield}
		return (Time.now - start)/n
	end
end