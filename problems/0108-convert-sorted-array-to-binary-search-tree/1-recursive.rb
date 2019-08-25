class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = nil
    @right = nil
  end
end

def sorted_array_to_bst(nums)
  return nil if nums.empty?
  mid_index = nums.length / 2
  node = TreeNode.new(nums[mid_index])
  node.left = sorted_array_to_bst(nums[0...mid_index])
  node.right = sorted_array_to_bst(nums[mid_index + 1..-1])
  node
end
