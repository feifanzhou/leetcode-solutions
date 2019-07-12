def character_count_hash(string)
  character_counts = Hash.new(0)
  string.each_char { |c| character_counts[c] += 1 }
  character_counts
end

def is_anagram(s, t)
  return false unless s.length == t.length
  character_count_hash(s) == character_count_hash(t)
end

p is_anagram('anagram', 'nagaram') # @CAT_IGNORE
p is_anagram('rat', 'car') # @CAT_IGNORE
