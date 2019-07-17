It's not particularly hard to come up with _something_ that works for this problem. The challenge is figuring out a solution that runs in a reasonable amount of time. The test cases on Leetcode in particular get really long, and you can hit the time limit on submissions.

# Solution 1: Check All Triplets
The most intuitive way to solve this problem is to generate all possible unique triplets and select the ones that sum to zero. Generating all triplets takes a bit of thought. We'll need to loop over pretty much all the numbers for each number in the triplet, so that'll be three nested loops. However, since each number in a generated triplet has to uniquely exist in the original set of `nums`, we need to stagger the indexes that we start with. 

We'll have the outermost loop start at index `0`, the middle loop start at index `1`, and the innermost loop start at index `2`. The innermost loop will run through to the end of `nums`; then the middle loop will increment and the innermost loop will start at an index that's one beyond the middle index and again run through to the end of `nums`. This repeats until the middle loop has reached the penultimate number in `nums` and the innermost loop has reached the last number in `nums`. Then the outermost loop increments, and it all gets repeated.

```ruby
@cat 1-check-all-triplets.rb
```

In the example above, we generate all possible triplets, then select the ones that sum to zero. At the end, we make sure to only return unique triplets. For this problem, `[-1, 0, 1]` and `[0, -1, 1]` are considered duplicates, but they would not be `==` by default, and so wouldn't be deduplicated by `uniq`. By `sort`ing each resulting triplet, both become `[-1, 0, 1]`, and so would be deduplicated.

We can slightly re-write this solution to avoid generating a triplet in the first place if it doesn't sum to zero, which saves a bit of computational work.

```ruby
@cat 1-check-all-triplets-inline.rb
```

However, in either case, the three nested loops, each over almost all of `nums`, makes this an O(n<sup>3</sup>) solution, which is too slow for Leetcode and will timeout.

# Solution 2: Check All Triplets (Using Built-in Methods)
This solution is the same as the previous one, but it's a one-liner that entirely uses Ruby's built-in methods. Most people would consider this cheating (and it's also O(n<sup>3</sup>), which probably makes it too slow), but I'm including it to show what Ruby is capable of out of the box 😄

(I didn't come up with this one — [original source here](https://leetcode.com/problems/3sum/discuss/206395/Ruby-one-liner).)

```ruby
@cat 2-using-built-in-methods.rb
```

# Solution 3: Check Pairs and Opposite
How can we do better than O(n<sup>3</sup>)? Can we solve this using just two loops and an O(n<sup>2</sup>) algorithm? To figure this out, you'll need to "realize" some properties. One such property looks like this:

If three numbers add up to zero, then that means one of those numbers is the positive/negative opposite of the sum of the other two. In other words, if _x_ + _y_ + _z_ = 0, then we can say _z_ = –(_x_ + _y_). 

With this realization, we can write an algorithm that generates unique pairs of `nums`, sums them up, and checks if the opposite of the sum also exists in the rest of `nums`. 

```ruby
@cat 3-check-pairs-and-opposite.rb
```

The runtime for this comes with some asterisks. We have our two nested loops, so this solution is "at least" O(n<sup>2</sup>). In this particular implementation, the work inside the inner loop is also linear — `array_after_deleting_indices` needs to basically go through all the numbers in `nums`, so it's also linear, and Ruby's default `Array#include?` method performs a linear search (you can see this by going to the [documentation for `Array#include?`](https://ruby-doc.org/core-2.5.0/Array.html#method-i-include-3F) and clicking to show the underlying implementation). So technically this is O(n<sup>3</sup>) (and it is indeed still too slow for Leetcode). However, in the context of an interview, you can make an argument that you could transform `nums` into a hash-based set, where finding and deleting values takes constant time, and so this solution _could_ run in O(n<sup>2</sup>) time. I think most interviewers would accept that. But there is a solution that is properly O(n<sup>2</sup>), no asterisks required.

# Solution 4: Sort and Crawl
What can we do if we sort `nums` first? This might also require a "realization" to come to you, although writing out an example might make it apparent. Suppose you picked three consecutive numbers somewhere in the middle of the sorted array. If they sum up to zero, great! You've found one of the triplets you'll want to return. If they sum to a number greater than zero, then you can look to the left to get a smaller sum — specifically, you can do this by just looking at the number to the left of the leftmost one you're currently looking at. If the original sum is less than zero, you can similarly look at the number to the right of the rightmost one you're currently looking at. In either case, recompute the sum, and repeat.

For example, suppose we had the sorted numbers `[-2, 0, 1, 1, 2]`. If we start by looking at the middle three numbers — `0`, `1`, and `1`, we have a sum that's greater than zero. Then, if we look at the number to the left of the `0`, we'll have `-2`, `1`, and `1`. Now this sums to zero, and we have a working triplet. Similarly, if we started by looking at `-2`, `0`, and `1`, that sums to less than zero. We can look to the number to the right of the `1`, and, as a second step, we can then look to the number to the left of `0`, until we're looking at `-2`, `1`, and `1`. 

We can turn this into an algorithm by methodically going through each number in `nums`. We can look at the number to its left and right, calculate the sum, and move either left or right depending on the sum, until we either get to a sum of zero, or reach the left or right edge of `nums` without finding a sum of zero. 

```ruby
@cat 4-sort-and-crawl.rb
```

**Runtime:** Sorting `nums` can be done in O(nlog(n)) time. Then, for each iteration of the `middle_index` loop, `left_index` might go to `0` and `right_index` might go to `nums.length - 1`, which would be a single, linear run through `nums`. Thus, the entire loop is O(n<sup>2</sup>). This algorithm therefore runs in O(nlog(n)) + O(n<sup>2</sup>), and the latter term dominates, so the "official" runtime answer is O(n<sup>2</sup>).

This solution does run within time limits on Leetcode. The two early `return`s at the beginning are needed to pass a particular test case containing a very large number of only `0`s — without them, that particular test case would time out.