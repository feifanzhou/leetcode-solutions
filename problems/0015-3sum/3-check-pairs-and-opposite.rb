def three_sum(nums)
  zero_triplets = []
  (0...nums.length).each do |i|
    ((i + 1)...nums.length).each do |j|
      pair_sum = nums[i] + nums[j]
      nums_without_current_pair = array_after_deleting_indices(nums, [i, j])
      pair_sum_opposite = -1 * pair_sum
      zero_triplets << [nums[i], nums[j], pair_sum_opposite] if nums_without_current_pair.include?(pair_sum_opposite)
    end
  end
  zero_triplets.map(&:sort).uniq
end

def array_after_deleting_indices(original_array, indices)
  array_copy = original_array.dup
  indices.sort.reverse_each { |i| array_copy.delete_at(i) }
  array_copy
end

p three_sum([-1, 0, 1, 2, -1, -4]) # @CAT_IGNORE
