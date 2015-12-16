stopwords = %w{the a by on for of are with just but and to the my I has some in}

lines = File.readlines(ARGV[0])
line_count = lines.length
text = lines.join("")

#count the characters
characters = text.split("").length
nospacechars = text.split(" ").join("").length

#count words, sentences, and paragraps
numwords = text.split(" ").length
sentences = text.split(/\.|\?|!/).length
paragraphs = text.split("\n\n").length

#find interesting words vs all dumb words
allwords = text.scan(/\w+/)
keywords = allwords.select {|word| !stopwords.include?(word)}
interestingness = (keywords.length.to_f / numwords.to_f * 100).to_i

#summarize the text by cherry-picking the best sentences
sorted_sentences = text.gsub(/\s+/, " ").strip.split(/\.|\?|!/).sort_by{|sentence| sentence.length}
one_third = sorted_sentences.length/3
ideal_sentences = sorted_sentences.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select{|sentence| sentence =~ /is|are/}
formatted_summary = ideal_sentences.join(". ").gsub(/^\'|(\'\s+)/, "")

avgwords = numwords.to_f/sentences.to_f
avgsentences = sentences.to_f/paragraphs.to_f

puts "Line count = #{line_count}"
puts "Characters = #{characters}"
puts "No Space Characters = #{nospacechars}"
puts "Words = #{numwords}"
puts "Sentences = #{sentences}"
puts "Paragraphs = #{paragraphs}"
puts "Average Words per Sentence = #{avgwords}"
puts "Average Sentences per Para = #{avgsentences}"
puts "Interestingness = #{interestingness}"
puts "SUMMARY: \n\n#{formatted_summary}"
puts "--- End of analysis ---"