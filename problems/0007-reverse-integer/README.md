Ruby's integers aren't limited to 32-bits, so we don't have to worry about overflows. However, if the problem insists that `0` must be returned if the number _would_ overflow, we can then check if the reversed number would be greater than the largest 32-bit integer value, and return `0` if that's the case. Most interviewers would probably be ok if you didn't bothered with this bit, since it's not the interesting part of the problem.

# Solution 1: Stringify and Reverse
Most people would consider this cheating, but you could just turn the integer into a string, reverse that string, and turn it back into an integer. The only tricky part is when given a negative — we want to stringify and reverse the absolute value of the number (the positive part of it), and tack on the negative sign if the original number is negative.

```ruby
@cat 1-stringify-and-reverse.rb
```

# Solution 2: Reverse a Digit Array
The modulo operator (`%`) returns the [remainder that would result from a division](https://stackoverflow.com/a/17525046/472768). We can use a repeated combination of `%` and `/` to extract all the digits from a number, one-by-one. If we `%` and `/` by `10` each time, we extract digits from right-to-left. We can append these digits to an array, such that the resulting array is in the order we want our solution to be. 

Once we have this array, we can use place-value math to recombine them into the final number. For example, if we have the digits `[1, 2, 3, 4]` in an array, and want to combine them into the number `1234`, we'd multiple the `1` by 10<sup>3</sup>, the `2` by 10<sup>2</sup>, the `3` by 10<sup>1</sup>, and the `4` by 10<sup>0</sup>, and add all that together. If `n` is the number of digits, each digit at index `I` gets multiplied by 10<sup>n - 1 - I</sup>. 

```ruby
@cat 2-reverse-a-digit-array.rb
```

# Solution 3: Digit By Digit
If we can't (or don't want to) allocate an additional array, we can do something similar, but we need to first determine what `n` would be by running through a `/` loop first. Then, rather than looping through an array of digits, we use `%` to extract a digit, and place-value multiplication to put it into the right place in the solution, within each iteration of the main loop.

```ruby
@cat 3-digit-by-digit.rb
```

**Runtime:** This solution is `O(log(x))` because both loops run as many iterations as there are digits in `x`, and the work within both loops runs in constant time.

**Memory:** This solution uses a constant amount of memory.