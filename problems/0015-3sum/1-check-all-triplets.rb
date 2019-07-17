def three_sum(nums)
  triplets = gen_triplets(nums)
  zero_triplets = triplets.select { |(x, y, z)| x + y + z == 0 }
  zero_triplets.map(&:sort).uniq
end

def gen_triplets(nums)
  triplets = []
  (0...nums.length).each do |i|
    ((i + 1)...nums.length).each do |j|
      ((j + 1)...nums.length).each do |k|
        triplets << [nums[i], nums[j], nums[k]]
      end
    end
  end
  triplets
end

p three_sum([-1, 0, 1, 2, -1, -4]) # @CAT_IGNORE
