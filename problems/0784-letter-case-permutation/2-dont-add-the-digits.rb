def letter_case_permutation(s)
  results = ['']
  s.each_char do |char|
    results = results.map do |r|
      if char =~ /\d/
        r + char
      else
        [r + char.downcase, r + char.upcase]
      end
    end.flatten
  end
  results
end

p letter_case_permutation('1234a') # @CAT_IGNORE
