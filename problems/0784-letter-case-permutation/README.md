The tricky part about this problem is dealing with digits — we can't just go through each character in `s` and output an uppercase and lowercase version of that character because we would then end up with duplicates for every encountered digit.

# Solution 1: Brute Force
Of course, we could just generate an uppercase and lowercase combo for every character, and then remove the duplicates. To generate all the combos, we'll keep track of intermediate results while we loop through each character in `s`, and append the uppercase and lowercase version of that character to each existing intermediate result. 

For example, given `s = 'abc'`, our intermediate results would start empty `[]`. Upon reaching `a`, we'll add `'a'` and `'A'` to that array. Next, we'll reach `b`, and for each of the existing strings in the intermediate results, we output that intermediate string plus `'b'`, and then `'B'`. The code below uses a `map` followed by a `flatten` — after the `map` at this step, we have an array that looks like `[['ab', 'aB'], ['Ab', 'AB']]`, which gets `flatten`ed to `['ab', 'aB', 'Ab', 'AB']`. Similarly, upon reaching `c`, we will get an array of `[['abc', 'abC'], ['aBc', 'aBC'], ['Abc', 'AbC'], ['ABc', 'ABC']]`, which gets `flatten`ed to `['abc', 'abC', 'aBc', 'aBC', 'Abc', 'AbC', 'ABc', 'ABC']`. 

```ruby
@cat 1-brute-force.rb
```

# Solution 2: Don't Add the Digits
Starting with Solution 1, we can skip the deduplication step (and save some effort in the process) just by not adding duplicates when we get to a digit. Everything else works the same way.

```ruby
@cat 2-dont-add-the-digits.rb
```

# Solution 3: Bit Fiddling
This solution may run slower in Ruby, but is an interesting way to think about the problem.

Suppose `s` didn't have any digits. Then our output set would include a string with an uppercase and lowercase variant for each letter. We could use binary to represent this — let `0` represent "lowercase" and `1` represent "uppercase", and we'd have one binary digit for each character in `s`. For a two-letter long `s`, such as "ab", we would have `['ab', 'aB', 'Ab', 'AB]`, corresponding to `00`, `01`, `10`, and `11` in binary, or `0`, `1`, `2`, `3` in base-10 integers.

For three-letter strings, the base-10 integers would range from 0–7 (inclusive); for four-letters strings, the base-10 integers would range from 0–15 (inclusive). In general, the range goes up to `2ⁿ – 1`, where `n` is the length of `s`. 

Using this information, we can loop from 0 to the upper limit of this range, and for each number, generate the correspondingly-cased string. For example, if `s = 'abcd'` and we wanted to generate the string corresponding to `6`, start by looking at the binary representation of `6`: `0110`. This corresponds to `'aBCd'`. Similarly, at `13`, the binary representation is `1101`, corresponding to `'ABcD'`. 

Oh, and what about digits? One way we can deal with them is by noting the indexes in the original string where they exist, removing them, generating all the case combinations, and then re-inserting them.

Putting it all together:

```ruby
@cat 3-bit-fiddling.rb
```