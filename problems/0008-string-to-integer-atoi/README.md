This problem combines some string manipulation with place-value math. Given a string of digits, we can turn it into a number in either direction. For example, suppose we have the string `'782'`, which can be split into the digits `'7'`, `'8'`, and `'2'`. 

Going from left-to-right, starting with `0`, we iteratively multiply the result-so-far by ten, then add the next digit. For example, we start with `0`, multiply that by 10 and add `7`; our result so far is `7`. Then we multiply that by 10 and add `8`; our result so far is `78`. Then we multiply that by 10 and add `2`; our final result is `782`.

Going from right-to-left, starting with `0`, we iteratively add the product of the next digit by its corresponding power-of-ten. For example, we start with `0`, and add `2` × 10<sup>0</sup>; our result so far is `2`. Then we add `8` × 10<sup>1</sup>; our result so far is `82`. Then we add `7` × 10<sup>2</sup>; our final result is `782`. 

The rest of this problem involves different ways to extract just the digits and leading `+`/`-` when there are other characters involved.

# Solution 1: Use to_i
This solution would probably be considered cheating, but of course you could just use the [`String#to_i`](https://www.rubydoc.info/stdlib/core/String:to_i) method included in Ruby. It handles whitespaces and leading and trailing non-numeric characters exactly the way we want it; we just have to account for a result that is larger or smaller than the range allowed in the problem.

```ruby
@cat 1-use-to_i.rb
```

# Solution 2: Iterate Through Characters, Then Combine
This solution implements the general solution outlined in the problem itself. It iterates through each character in the input string, ignoring any whitespace in the beginning of the string (before it has detected a number yet). Once it comes across a non-whitespace character, it records a leading `+` or `-` if it is one, then reads as many digits as it can following that. It stops processing the string once it stops reading digits — in this way, it ignores "additional characters after those that form the integral number". Then, the array of digits are combined left-to-right, and finally we adjust for negative numbers and the range allowed in the problem.

```ruby
@cat 2-iterate-through-characters-then-combine.rb
```

# Solution 3: Iterate Through Characters and Reduce
This solution is the same as the previous, except instead of accumulating digits in an array to be combined later, digits are combined into a resulting number as we go via the `reduce` method. 

The [`Enumerable#reduce`](https://ruby-doc.org/core-2.4.0/Enumerable.html#method-i-reduce) method "reduces" an array of values down into one value by executing some code on each value and storing each intermediate result in an "accumulator". This accumulated value is also provided to the code that each step executes, and this allows the result to be built up. For example, `reduce` can be used to calculate the sum of an array of numbers:

```ruby
[3, 8, 10, 18, -2].reduce(0) do |accumulated_value, next_value|
  accumulated_value + next_value
end
```

In this example, we `reduce` over the array, starting with `0` as an initial value (the first `accumulated_value`). In the first iteration of the block, `accumulated_value` is `0` and `next_value` is `3`. The block evaluates to `0 + 3`, and so `3` becomes the next `accumulated_value`. `3` is paired with `8` as the `next_value`; `3 + 8` evaluates to `11`, which becomes the next `accumulated_value` … and so on. At the end, this `reduce` expression evaluates to `37`. 

This solution for string-to-integer uses `reduce` to build up the resulting number digit-by-digit (going left-to-right) — this is specified by the `if` expression at the end of the `reduce` block: `if found_number && digit?(char)`, then evaluate to `results_so_far * 10 + char_to_number(char)`.  

In other places, we use `next` and `break`. In Ruby, `next` skips the rest of the code in a block and goes to the next iteration of the enumeration it's contained in. In other languages (like Javascript), you might provide an anonymous or arrow function to `reduce`, and within that function, you call `return` to return early. In Ruby, `return` always exits the **containing method**, so using `return` in this case would exit the entire `my_atoi` method, not just the `reduce` block. Similarly, `break` is used to skip the remaining iterations of the block. In both cases, you can provide a value (such as `next result_so_far` or `break result_so_far`) to serve as the "return" value — `next result_so_far` makes the current `result_so_far` become the `result_so_far` for the next iteration, while `break result_so_far` makes the entire `reduce`d value be the current `result_so_far`. 

```ruby
@cat 3-iterate-through-characters-and-reduce.rb
```

# Solution 4: Extract Digits and Reduce
This solution uses a regex to extract the first set of digits from the input string, then `reduce`s over them, going right-to-left, to compute the result. 

This solution might be more clever than practical, but it was fun to figure out 😆

First, it calls [`String#strip`](https://ruby-doc.org/core-2.4.0/String.html#method-i-strip) to remove whitespace at the beginning and end of the string.

Then, it uses a regex to match and capture digits: `/^([+-]?\d+)/`
* The `^` makes it start matching from the beginning of the string — this means it won't match digits starting in the middle of a string, which is the correct way to handle a case like "words and 987".
* The parenthesized bit after represents a regex capture group, meaning we want to "capture" or save the original characters that match whatever is inside the parentheses.
* What do we want to capture? It can start with a `+` or `-`, represented by the character group `[+-]`. There can only be zero or one of either; this is represented by the `?`.
* Then we have one or more digits, represented by `\d+`. 

[Rubular](https://rubular.com) is a great site for playing with regexes.

If there is a match, then everything we're interested in is in the first captured result. For example, `'4193 with words'.match(/^(-?\d+)/).captures.first` is `'4193'`. 

Then we take this result, and:
* `reverse` it to go right-to-left;
* iterate over `each_char`,
* making sure the iteration also happens `with_index` so we can determine place-value,
* and `reduce` starting from `0`. With this setup, the first argument to the  `reduce` block is still the accumulator; the second argument is the "next value". In this case, the "next value" is an array containing the actual next value as well as its index. Ruby allows this array to be destructured by using the parenthesized variables `(char, index)`. To illustrate this further with a simple example, if we have `(a, b) = [1, 2]`, that would assign `1` to `a` and `2` to `b`. 

```ruby
@cat 4-extract-digits-and-reduce.rb
```

There's no particular reason this solution needed to go right-to-left, other than to illustrate how it would work. Going left-to-right would work as well.