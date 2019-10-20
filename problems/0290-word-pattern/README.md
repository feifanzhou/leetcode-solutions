I've seen this problem in a couple of interviews. In this problem, different letters in the pattern must correspond to different words (for example, `abba` doesn't match `dog dog dog dog` because `a` and `b` can't both refer to `dog`). One variant of this problem is to allow that. In this problem, the pattern must fully match `str`; another variant is for the match to happen anywhere within `str`. That variant is a bit harder, and it becomes even harder if `str` doesn't contain spaces separating words. 

Fortunately, we have an easy version of this problem here.

"Bijection" in the problem statement is a [fancy way of saying](https://en.wikipedia.org/wiki/Bijection) there's a one-to-one mapping between elements in two sets. In the case of this problem, that means there's a one-to-one mapping between the letters in `pattern` and words in `str`:
* There are no unpaired letters or words.
* The same letter can't refer to different words, and
* The same word can't be represented by different letters

# Solution 1: Hashify
We split `pattern` on an empty string to get an array of its letters (`'abc'.split('')` returns `['a', 'b', 'c']`), and we split `str` on a single space to get an array of its words. Then, using the pattern to guide us, we go through the letters in the pattern and its corresponding word and check if they match. Along the way, we `return false` if any of the bijection conditions no longer appear to be true.

```ruby
@cat 1-hashify.rb
```
Inside the loop, we set `pattern_hash[letter] = word` — that is, we're building a hash of letters → words.

We `return false` unless the number of letters match the number of words, because if they don't match, that means there will be unpaired letters or words. 

We `return false` if `pattern_hash[letter]` exists and isn't the same as the current word, because this would mean that the same letter is referring to different words. 

We `return false` if the number of words in `pattern_hash` (represented by `pattern_hash.values`) is different from the *unique* number of words. This would only happen if the same word is appearing for more than one letter. 