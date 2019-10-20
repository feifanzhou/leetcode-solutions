def word_pattern(pattern, str)
  pattern_letters = pattern.split('')
  str_words = str.split(' ')
  return false unless pattern_letters.length == str_words.length
  pattern_hash = {}
  pattern_letters.each_with_index do |letter, index|
    word = str_words[index]
    return false if pattern_hash[letter] && pattern_hash[letter] != word
    pattern_hash[letter] = word
  end
  return false if pattern_hash.values.length != pattern_hash.values.uniq.length
  true
end

