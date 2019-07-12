def letter_case_permutation(s)
  results = ['']
  s.each_char do |char|
    results = results.map do |r|
      [r + char.downcase, r + char.upcase]
    end.flatten
  end
  results.uniq
end

p letter_case_permutation('abc') # @CAT_IGNORE
