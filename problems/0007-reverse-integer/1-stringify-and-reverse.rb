INT32_MAX = 2 ** 31 - 1
INT32_MIN = -1 * 2 ** 31

def reverse(x)
  reversed_integer = x.abs.to_s.reverse.to_i
  solution = x < 0 ? -1 * reversed_integer : reversed_integer
  solution > INT32_MAX || solution < INT32_MIN ? 0 : solution
end

p reverse(123) # @CAT_IGNORE
p reverse(-123) # @CAT_IGNORE
p reverse(120) # @CAT_IGNORE
