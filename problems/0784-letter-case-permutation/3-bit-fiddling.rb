def binary_bit_set?(number, pos)
  (number >> pos) & 1 == 1
end

def all_permutations(input, total)
  (0...total).map do |i|
    input.each_char.each_with_index.map do |char, pos|
      binary_bit_set?(i, pos) ? char.upcase : char.downcase
    end.join('')
  end
end

def letter_case_permutation(input)
  # Remove digits for now
  only_letters = input.gsub(/\d/, '')
  permutations = all_permutations(only_letters, 2 ** only_letters.length)
  # Figure out where the digits were in `input`
  digit_positions = (0...input.length).select { |i| input[i] =~ /\d/ }
  # Reinsert digits into each permutation
  permutations.map do |combo|
    digit_positions.each { |pos| combo.insert(pos, input[pos]) }
    combo
  end
end

p letter_case_permutation('a1b2') # @CAT_IGNORE
p letter_case_permutation('1234a') # @CAT_IGNORE
