We can use a depth-first search (DFS) to find a particular word in the given grid. You can think about the grid as a graph, where each character in the grid is a node in the graph, and adjacent characters are connected via edges.

# Solution 1: DFS (Recursive)
We're given a board as an array of arrays; each element in the board is a string with a single character. Starting from each point in the board, we will conduct a recursive BFS, and return `true` for the whole `exist` method if any of those BFSs returns `true`. 

The basic outline of the solution looks like this:

```ruby
def exist(board, word)
  (0...board.length).each do |i|
    (0...board[i].length).each do |j|
      starting_point = Point.new(board, i, j)
      return true if dfs(starting_point, word)
    end
  end
  false
end

def dfs(point, word, previous_path = Path.new)
  path_so_far = previous_path.push(point)
  return true if path_so_far.value == word
  DIRECTIONS.any? do |direction|
    next unless point.can_go?(direction)
    new_point = point.go(direction)
    next if path_so_far.include?(new_point)
    dfs(new_point, word, path_so_far)
  end
end
```

As in most recursive cases, we create a helper method (`dfs`) to actually handle the recursion, and call it from our main `exist` method to begin the recursive search. Within `dfs`, we keep track of the current path we've searched over to make sure we don't re-visit a letter cell that we've already used. `dfs` returns `true` if it accumulates a path whose `value` matches the word we're looking for. At each step along the way (if the path's `value` hasn't matched yet), it recursively tries going in each possible direction (up, down, left, right), trying a DFS with that next point if it's a valid point. 

At any intermediate step _s_, called from parent _p_, if any direction returns `true` for its DFS, then _that_ iteration is also `true`. Let's look at an example: Suppose you're at some intermediate recursive step. Going through each direction, you're checking if the `right` direction returns `true`. `new_point` would be the point to the right of your current `point`. If `dfs(new_point, word, path_so_far`) returns `true`, then [`DIRECTIONS.any?`](https://ruby-doc.org/core/Enumerable.html#method-i-any-3F) will also return true, and the step _s_ will return `true` to _p_. That proceeds up the call stack until the `dfs` call in `exist` evaluates to `true`. 

To support this solution, we'll create a `Point` class, which keeps track of the total `board` and its own `row`/`col` position on that board. That way, `Point` can implement methods like `#can_go?` based on if it's at the edge of the board, and `#value`, which returns the board value at that `Point`'s position. It also implements the `#==` method, which is used to check if a path [`include?`](https://ruby-doc.org/core-2.6.3/Enumerable.html#method-i-include-3F)s a given point — the `#include?` method uses `#==` between two objects to compare them. 

```ruby
class Point
  def initialize(board, row, col)
    @board = board
    @row = row
    @col = col
  end

  attr_reader :board, :row, :col

  def can_go?(direction)
    (delta_row, delta_col) = direction
    new_row = row + delta_row
    new_col = col + delta_col
    new_row >= 0 && new_row < board.length && new_col >= 0 && new_col < board.first.length
  end

  def go(direction)
    (delta_row, delta_col) = direction
    new_row = row + delta_row
    new_col = col + delta_col
    self.class.new(board, new_row, new_col)
  end

  def value
    if row.negative? || col.negative?
      nil
    else
      board.dig(row, col)
    end
  end

  def ==(other)
    other.board == self.board && other.row == self.row && other.col == self.col
  end
end
```

We'll also have a simple `Path` class, which mostly wraps an Array and provides a few other convenience functions. 

```ruby
class Path
  def initialize(path = [])
    @steps_in_path = path
  end

  attr_reader :steps_in_path

  def include?(point)
    steps_in_path.include?(point)
  end

  def value
    steps_in_path.map(&:value).join('')
  end

  def push(next_point)
    Path.new(steps_in_path + [next_point])
  end
end
```

Note that the `Path#push` method takes care to avoid changing a previous instance. For example:

```ruby
new_point = …
path1 = Path.new(…)
path2 = path1.push(new_point)
```

We need to make sure that `path1`'s `value` doesn't change. This is because with a DFS, if we end up at a dead-end, we want to go back up the call stack and try a different direction, using the unmodified state of the `path` that existed at that point. This is a little tricky to get right, because depending on the methods we call on the underlying array, we might end up modifying the same underlying instance, and so when we go back up the stack, a previous `path` might have been modified with some later points that we don't want anymore. For example:

```ruby
x = [5]
y = x << 6
# At this point, x has been modified and now contains [5, 6] 

x = [5]
y = x.push(6)
# `push` is the same as `<<`, so the same thing is true

x = [5]
y = x.concat([6])
# At this point, x has also been modified and now contains [5, 6]

x = [5]
y = x + [6]
# At this point, x has *not* been modified and still contains [5].
# y now contains [5, 6].
# This is what we want.
```

Putting it all together, this is our solution:

```ruby
@cat 1-dfs-recursive.rb
```

However, this solution ends up being a little too slow for Leetcode; it will probably time out. Part of the reason is because we have to recompute `path_so_far.value` at each recursive call, which leads to a lot of wasted effort because paths can get pretty long and many paths will start off with the same points.

# Solution 2: DFS (Recursive) with Burndown
We can eliminate this duplicated work by changing our algorithm slightly. Rather than keeping track of an entire path and recomputing its `value` at each `dfs` step, we can use the DFS itself to keep track of whether the path is on the right track. 

Suppose we're looking for the string `'abc'`, with a call like `dfs(first_point, 'abc', [])`. In a perfect case, we would start off at a point whose value is `'a'`. Then we'd proceed to a point whose value is `'b'`. Finally, we'd go to a point whose value is `'c'`, and return `true`.

During the first `dfs` call, we can check if `first_point.value` matches the first character of our word. In this perfect example, `first_point.value`  is `'a'`, and the first character of `'abc'` is also `'a'`, so this is true. Then we can look at the "rest" of the DFS — in other words, after taking care of the first character, we can do a DFS on the rest of the string: `dfs(next_point, 'bc', [first_point])`! Next, we again do a DFS on the rest of _that_ string: `dfs(last_point, 'c', [first_point, next_point])`. This recursion finishes when `word` is down to one character, and that character matches the point's `value`: `return true if point.value == word`. The `word` passed to each iteration of `dfs` "burns down" at each step, and we don't need to compute a `path`'s `value` at each step. We don't really a dedicated `Path` class anymore, since it's no longer much more useful than a normal Array.

Everything else about this solution is the same:

```ruby
@cat 2-dfs-recursive-with-burndown.rb
```

**Runtime:** A DFS is linear in the number of nodes and edges. For a matrix with dimensions _m_ × _n_, there are _mn_ nodes. Each node has 4 edges to its adjacent cells, except for the ones around the outside of the matrix, which have 2 each. As _m_ and _n_ get larger, the number of cells on the outside become relatively smaller. For example, in a 3 × 3 matrix, there are 8 outside cells and 1 internal cell. In a 300 × 300 matrix, there are 1196 outside cells and 88,804 internal cells. Therefore, the number of edges approaches 4 × _m_ × _n_, and since we drop constant factors in Big-O analysis, this also becomes _mn_. Therefore, the runtime is O(_mn_ + _mn_) = O(2_mn_) = O(_mn_).

**Memory:** We only need additional memory to store the path. Since we are preventing duplicate cells in a path, the longest possible path is one that reaches every cell exactly once, and in a matrix with dimensions _m_ × _n_, there are _mn_ cells. Therefore, the memory constraint is also O(_mn_). 