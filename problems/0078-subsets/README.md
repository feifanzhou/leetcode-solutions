This is a problem where I think the brute-force solution is actually harder to implement than the better solution.

# Solution 1: Brute Force
One brute force solution is to implement a solution that somewhat literally follows the problem. One way to think about "all possible subsets" is by coming up with all the sets of length 1 first, then all the sets of length 2, and so up until all sets of length _n_ (where _n_ is the length of `nums`). It's conceptually simple, but the code to implement this is actually quite messy, so we won't bother with it here. There's also some obvious unnecessary work — for example, every set of length 3 contains sets of length 2; in other words, every set of length _x_ contains some sets of length _x – 1_, and we should be able to reuse the effort to generate the _x – 1_ sets in some way.

# Solution 2: Dynamic Programming
The key insight for this solution is that every element in `nums` can either be in a particular subset, or not be in that subset, ranging from a case where every element in `nums` is not in a subset (leading to the empty subset `[]`), to a case where every element in `nums` is in a subset (leading to a subset that contains everything in `nums`), and everything in between. That is one of the [properties of a power set](https://en.wikipedia.org/wiki/Power_set#Properties). You may happen to know/remember this fact. One other way of coming across this insight is by noticing that in the example with three elements in `nums`, there are eight subsets. You can try generating subsets manually for two or four `nums`, and see that there are 2<sup><em>n</em></sup> subsets for `nums` of length _n_. 2<sup><em>n</em></sup> is represented in binary as a number _n_ digits long, each `0` or `1`, and every value between 0 and _n_, translated to binary, is a description of a particular subset. For example, in the case where `nums` is `[1, 2, 3]`:

| **Number** | **Binary** | **Subset** |
|:------------:|------------|------------|
| 0          | 000        | `[]`         |
| 1          | 001        | `[3]`        |
| 2          | 010        | `[2]`        |
| 3          | 011        | `[2, 3]`     |
| 4          | 100        | `[1]`        |
| 5          | 101        | `[1, 3]`     |
| 6          | 110        | `[1, 2]`     |
| 7          | 111        | `[1, 2, 3]`  |

In fact, we could implement the solution like this — loop from `0` to `nums.length`, turn that number into binary, and extract the corresponding numbers from `nums`. 

That's a little messy though. Another way to implement the same idea is to keep track of subsets as we generate them, iterate through `nums`, and for each number in `nums`, duplicate all the existing subsets and append the new number to each subset copy. What we're basically doing is saying that each of the duplicated-and-appended subsets contains the current number, and each subset that it originally came from doesn't contain the current number. Finally, of course, we have to add the duplicated-and-appended subsets back to the list of all subsets.

```ruby
@cat 2-dynamic-programming.rb
```

This solution can be written more compactly in one line (more or less) using Ruby's [`reduce`](https://ruby-doc.org/core-2.4.0/Enumerable.html#method-i-reduce) method (see my solution to [Problem 8](/problems/string-to-integer-atoi) for an explanation of how it works):

```ruby
@cat 2-dynamic-programming-one-line.rb
```

This one-liner seems to run a little bit faster on Leetcode, but is a little more difficult to understand at first glance.

**Runtime:** It's not particularly clear just by looking at the code. First, we'll make a simplifying assumption that the `concat` method runs in constant time — this depends on implementation details, but you could make the case that you could use a linked list for `subsets`, in which case this could be true. Similarly, we'll also assume that `existing_set + [num]` (adding `num` to `existing_set`) takes constant time, for the same reason.

Within each of `n` loop iterations, we are thus performing constant-time operations 2<sup><em>n – 1</em></sup> times (within the `map`). Therefore, the runtime is the sum of 2<sup>0</sup> + 2<sup>1</sup> + … + 2<sup><em>n – 1</em></sup>, which (<em>waves hand mysteriously</em>) evaluates to 2<sup><em>n</em></sup> – 1. This translates to O(2<sup><em>n</em></sup>). 