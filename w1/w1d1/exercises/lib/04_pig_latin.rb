def translate(string)
	words = string.split(" ")
	latin = []
	words.each { |word|  
		regex = /^[aeiou]|^(qu)|^(squ)|^[qwrtypsdfghjklzxcvbnm]+/
		start = regex.match(word)
		if (start[0] =~ /[aieou]/) == 0
			latin.push("#{word}ay")
		else
			latin.push("#{word.slice(start[0].length, word.length)}#{start[0]}ay")
		end
	}
	return latin.join(" ")
end

