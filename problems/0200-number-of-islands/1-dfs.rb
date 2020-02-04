def num_islands(grid)
  return 0 if grid.empty?
  number_of_islands = 0
  grid.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      next unless land?(grid, row_index, col_index)
      # Found land; increment count and explore adjacent cells
      number_of_islands += 1
      indices_to_explore = [[row_index, col_index]]
      while !indices_to_explore.empty? do
        next_location = indices_to_explore.pop
        next unless in_bounds?(grid, *next_location) && land?(grid, *next_location)
        # next_location points to land; now make it into ocean
        # so we don't double-count it
        grid[next_location.first][next_location.last] = '0'
        indices_to_explore.concat(neighboring_indices(grid, *next_location))
      end
    end
  end
  return number_of_islands
end

def land?(grid, row_index, col_index)
  grid[row_index][col_index] == '1'
end

def in_bounds?(grid, row_index, col_index)
  row_index >= 0 && col_index >= 0 && row_index < grid.length && col_index < grid.first.length
end

NEIGHBORS_DELTA = [[-1, 0], [0, -1], [1, 0], [0, 1]]

def neighboring_indices(grid, row_index, col_index)
  NEIGHBORS_DELTA.map do |(delta_row, delta_col)|
    next_row = row_index + delta_row
    next_col = col_index + delta_col
    if in_bounds?(grid, next_row, next_col)
      [next_row, next_col]
    else
      nil
    end
  end.compact
end