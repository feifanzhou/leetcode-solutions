def subsets(nums)
  subsets = [[]]
  nums.each do |num|
    subsets.concat(subsets.map { |existing_set| existing_set + [num] })
  end
  subsets
end

p subsets([1, 2, 3]) # @CAT_IGNORE
