def echo(string)
	"#{string}"
end

def shout(string)
	string.upcase!
	"#{string}"
end

def repeat(string, num=2)
	arr = []
	num.times do 
		arr.push("#{string}")
	end
	return arr.join(" ")
end

def start_of_word(str, n)
	sliced = str.slice(0, n)
	"#{sliced}"
end

def first_word(str)
	first = str.split(" ")[0]
	"#{first}"
end

def titleize(string)
	words = string.split(" ")
	words.each { |e| 
		if (e =~ /(over)|(the)|(and)/) != 0
			e.capitalize!
		end
	}
	words[0].capitalize!
	return words.join(" ")
end