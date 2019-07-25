DIRECTIONS = [
  [-1, 0], # up
  [0, 1], # right
  [1, 0], # down
  [0, -1] # left
]

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

board = [             # @CAT_IGNORE
  ['A','B','C','E'],  # @CAT_IGNORE
  ['S','F','C','S'],  # @CAT_IGNORE
  ['A','D','E','E']   # @CAT_IGNORE
]                     # @CAT_IGNORE
p exist(board, 'ABCCED') == true # @CAT_IGNORE
p exist(board, 'SEE') == true # @CAT_IGNORE
p exist(board, 'ABCB') == false # @CAT_IGNORE
p exist(board, 'ABFDB') == false # @CAT_IGNORE
p exist(board, 'ABFDA') == true # @CAT_IGNORE
p exist([['A']], 'A') == true # @CAT_IGNORE
p exist([["a","b"],["c","d"]], 'acdb') == true # @CAT_IGNORE
p exist([["a","a"]], 'aaa') == false # @CAT_IGNORE
