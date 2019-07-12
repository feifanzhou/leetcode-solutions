INT32_MAX = 2 ** 31 - 1
INT32_MIN = -1 * 2 ** 31

def reverse(x)
  x_copy = x.abs
  digits = []
  loop do
    digits << x_copy % 10
    x_copy /= 10
    break if x_copy == 0
  end

  solution = 0
  digits.each_with_index do |digit, index|
    place_value = 10 ** (digits.length - 1 - index)
    solution += digit * place_value
  end

  solution = x < 0 ? -1 * solution : solution
  solution > INT32_MAX || solution < INT32_MIN ? 0 : solution
end

p reverse(123) # @CAT_IGNORE
p reverse(-123) # @CAT_IGNORE
p reverse(120) # @CAT_IGNORE
