INT32_MAX = 2 ** 31 - 1
INT32_MIN = -1 * 2 ** 31

def my_atoi(str)
  int = str.to_i

  if int > INT32_MAX
    INT32_MAX
  elsif int < INT32_MIN
    INT32_MIN
  else
    int
  end
end

p my_atoi('42') # @CAT_IGNORE
p my_atoi('  -42') # @CAT_IGNORE
p my_atoi('4193 with words') # @CAT_IGNORE
p my_atoi('words and 987') # @CAT_IGNORE
p my_atoi('-91283472332') # @CAT_IGNORE
