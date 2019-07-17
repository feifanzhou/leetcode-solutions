def three_sum(nums)
  zero_triplets = []
  (0...nums.length).each do |i|
    ((i + 1)...nums.length).each do |j|
      ((j + 1)...nums.length).each do |k|
        zero_triplets << [nums[i], nums[j], nums[k]] if nums[i] + nums[j] + nums[k] == 0
      end
    end
  end
  zero_triplets.map(&:sort).uniq
end

p three_sum([-1, 0, 1, 2, -1, -4]) # @CAT_IGNORE
