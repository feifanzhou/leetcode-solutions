INT32_MAX = 2 ** 31 - 1
INT32_MIN = -1 * 2 ** 31

def reverse(x)
  x_copy = x.abs
  n = 1
  loop do
    x_copy /= 10
    break if x_copy == 0
    n += 1
  end

  solution = 0
  x_copy = x.abs
  (1..n).each do |i|
    place_value = 10 ** (n - i)
    next_digit = x_copy % 10
    solution += next_digit * place_value
    x_copy /= 10
  end

  solution = x < 0 ? -1 * solution : solution
  solution > INT32_MAX || solution < INT32_MIN ? 0 : solution
end

p reverse(123) # @CAT_IGNORE
p reverse(-123) # @CAT_IGNORE
p reverse(120) # @CAT_IGNORE
