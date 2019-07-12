Two strings are anagrams of each other if they contain the same letters, possibly in a different order. For example, `anagram` and `nagaram` are anagrams of each other because they both contain three `a`s and one each of `n`, `g`, `r`, and `m`. `rat` and `car` are not anagrams because `rat` has a `t`, while `car` does not.

# Solution 1: Hash With Counts
By definition, we can determine whether two strings are anagrams by making a hash of their character counts, and seeing whether those hashes are equivalent in keys and values. The character-count hash for `anagram` would look like `{ 'a' => 3, 'n' => 1, 'g' => 1, 'r' => 1, 'm' => 1 }`. 

One simple optimization we can make is to return `false` if the two strings are not the same length — by definition, they could never be anagrams of each other.

```ruby
@cat 1-hash-with-counts.rb
```

**Runtime:** If we assume all operations on `Hash`es run in constant time, then this algorithm runs in `O(s + t)` (where `s` and `t` are the lengths of the respective strings), since `character_count_hash` loops through each character in `s`, and then `t`, and performs constant work in each case. This remains true if `Hash` equality is implemented as a loop through all the keys in each hash.
**Memory:** This solution requires storing an additional hash for each string. In the worst case, no characters are repeated, which means each hash contains as many key-value pairs as there are letters. Assuming each key-value pair takes up a constant amount of storage (a letter for the key and an integer for the value), the storage requirement would also be `O(s + t)`. 

## Follow up
Since Ruby strings are Unicode-safe, no additional work is required to adapt this solution to Unicode characters.