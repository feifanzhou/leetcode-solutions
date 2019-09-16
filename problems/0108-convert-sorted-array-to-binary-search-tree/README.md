In a binary search tree (BST), all the values to the left of a particular node are less than that node, and all values to the right of a particular node are greater than that node. Given a sorted array, we can create a BST by selecting a value from within the array and making that a node — this node will become a root node, and we'll give it a `left` and `right` subnode if available. All the values that come before it in the array will end up in the left subtree of that node, and all the values that come after it in the array will end up in the right subtree of that node. To build the left subtree, we can recursively run this algorithm over the subarray on the left of the value we originally selected, and we can recursively run this algorithm over the subarray on the right of the value we originally selected to build the right subtree.

Which value should we select at each step? Since we want to create a _balanced_ BST, we'll want the value in the middle of the array we're working with at each step, so that there are (roughly) the same number of nodes to its left and to its right. In the case of an even number of values, where there are two "middle" values, we'll pick the one on the right to be the parent node, and put the one on the left to be a child node. This ensures that parent nodes are less-than-or-equal-to (≤) left child nodes, which is a property of BSTs.

```ruby
@cat 1-recursive.rb
```

`nums.length / 2` gives us the middle-index we want. If an array's length is an odd number (e.g. 5), dividing by 2 uses integer division, such that the remaining integer is the index we want (e.g. `5 / 2 == 2`). If an array's length is an even number (e.g. 4), dividing by 2 directly gives us the index we want (e.g. `4 / 2 == 2`; the middle indexes are `1` and `2`, and we want the one on the right, which is `2`).