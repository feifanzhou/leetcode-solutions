# Number of Islands

The basic idea behind this problem is to conduct a depth-first search — loop through the grid, one cell at a time, and when you come across a "land" cell, you check out the cells adjacent to it. For each adjacent cell that is also "land", you check out _its_ adjacent cells, and so on, until you've checked out all the adjacent cells that are land. That forms one island; then you move on and keep doing that until you get to the end of the grid. 

```ruby
@cat 1-dfs.rb
```

One note on syntax — in a method call, prefixing an array argument with `*` [spreads it out](https://www.honeybadger.io/blog/ruby-splat-array-manipulation-destructuring/) across multiple arguments in the called method. So if we have an array `next_location = [5, 6]` and a method `def foo(row, col)`, calling `foo(*next_location)` assigns `5` to `row` and `6` to `col` — it's the same as calling `foo(next_location[0], next_location[1])` but is a little shorter to read and write.

We start by checking if the `grid` is empty and returning `0` if it is. By doing so, we ensure that `grid` contains _something_, so we're less likely to crash if we're trying to determine the number of columns with something like `grid[0].length` and `grid` turns out to be an empty array (because in that case `grid[0]` would be `nil`. 

(Of course, you _could_ be more defensive by checking if `grid[0]` is `nil`, or even filtering out all `nil`s in `grid` with something like `grid.reject? { |row| row.nil? }`. In this case, it's safe to assume you'll get some kind of reasonable input).

Then, we use two nested loops to iterate through each row/column in `grid`. Since we're only interested in land, we use `next` to proceed to the next cell without doing anything else _unless_ the current cell is land. 

Once we've found land, we increment `number_of_islands` (because, after all, we've found a new island). Then we construct a _stack_, starting with the current cell, and as long as that stack isn't empty, we "explore" the next location in the stack. "Exploring" a location means:
1. Removing it from the stack (so the stack eventually empties out)
2. Checking that it's in-bounds, and that it's land (if a location is out of bounds, or if it's water, that means we've reached an edge of this island). 
3. Turning it into ocean (by setting the location's value to `'0'`) so we don't count it again on a later iteration
4. Add the locations that are adjacent to _that_ location to the stack (for the `while` loop to pick up and continue with).

In this case, adjacent cells are those that are one cell over to the left, top, right, or bottom. We compute the coordinates for the cell in each of those directions and make sure they're in-bounds. The `compact` method in Ruby returns a new array that has `nil` values stripped out. 

What's the runtime complexity of this solution? As an upper-bound, this problem is basically running a DFS on potentially each element of a grid with _n_ elements. Each element in the grid can be considered a vertex, and each vertex has four edges (to its adjacent cells). The runtime of a DFS is O(V+E), and we need to do that up to _n_ times — this is O(n*(n+4n)), which reduces to O(5n<sup>2</sup>), or O(n<sup>2</sup>).

Logically, that implies that in the worst case, we could be performing a DFS over each cell in the grid _for_ each cell in the grid. However, our solution sets "land" cells to "water" after we pass over them once, and skips searching over "water" cells, which means we won't search over any cell more than once. This allows us to say that, for this solution, we'll search over each cell at most once _for_ each cell. This can be expressed as O(n+n) or O(n). 

For storage space, our DFS is bounded by the size of our `grid` in one direction — for a grid of MxN cells, the maximum amount of storage space needed is O(max(M, N)). 