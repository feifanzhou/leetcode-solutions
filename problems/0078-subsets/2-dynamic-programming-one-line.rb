def subsets(nums)
  nums.reduce([[]]) do |subsets, num|
    subsets.concat(subsets.map { |existing_set| existing_set + [num] })
  end
end
