def three_sum(nums)
  nums.combination(3).select { |triplet| triplet.sum.zero? }.map(&:sort).uniq
end

p three_sum([-1, 0, 1, 2, -1, -4]) # @CAT_IGNORE
