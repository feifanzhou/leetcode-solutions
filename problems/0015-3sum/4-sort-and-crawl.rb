def three_sum(nums)
  return [] if nums.size < 3
  return [[0, 0, 0]] if nums.uniq == [0]

  zero_triplets = []
  nums.sort!
  (1...(nums.size - 1)).each do |middle_index|
    left_index = middle_index - 1
    right_index = middle_index + 1

    while left_index >= 0 && right_index < nums.size
      if (sum = nums[left_index] + nums[middle_index] + nums[right_index]) == 0
        zero_triplets << [nums[left_index], nums[middle_index], nums[right_index]]
        left_index -= 1
      elsif sum > 0
        left_index -= 1
      else
        right_index += 1
      end
    end
  end

  zero_triplets.uniq
end

p three_sum([-1, 0, 1, 2, -1, -4]) # @CAT_IGNORE
