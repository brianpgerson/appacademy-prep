class Dictionary
	attr_accessor :entries

	def initialize()
		@entries = {}
	end

	def add(entry)
		if entry.class == Hash
			key = entry.keys[0]
			val = entry.values[0]
		else
			key = entry
			val = nil
		end
		@entries[key] = val
	end

	def keywords
		@entries.keys.sort!
	end

	def include?(word)
		keywords.any? do |el|
			el == word
		end
	end

	def find(word)
		@entries.select do |k, v|
			k.match(word)
		end
	end

	def printable
		all_entries_sorted = []
		keywords.each do |key|
			all_entries_sorted << "[#{key}] \"#{@entries[key]}\""
		end
		all_entries_sorted.join("\n")
	end


end

#@d = Dictionary.new
#@d.add("fish" => "aquatic animal")
#@d.add("fiend" => "wicked person")
#@d.add("apple")
#@d.printable
#puts @d.find("fi")










