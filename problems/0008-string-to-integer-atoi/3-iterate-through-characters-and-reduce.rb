INT32_MAX = 2 ** 31 - 1
INT32_MIN = -1 * 2 ** 31

def my_atoi(str)
  found_number = false
  is_negative = false
  result = str.each_char.reduce(0) do |result_so_far, char|
    next result_so_far if whitespace?(char) && !found_number

    if !found_number
      found_number = true
      if char == '-'
        is_negative = true
        next result_so_far
      elsif char == '+'
        is_negative = false
        next result_so_far
      end
    end

    if found_number && digit?(char)
      result_so_far * 10 + char_to_number(char)
    else
      break result_so_far
    end
  end

  int = is_negative ? -1 * result : result

  if int > INT32_MAX
    INT32_MAX
  elsif int < INT32_MIN
    INT32_MIN
  else
    int
  end
end

def whitespace?(char)
  char =~ /\s/
end

def digit?(char)
  char =~ /\d/
end

def char_to_number(char)
  case char
  when '0' then 0
  when '1' then 1
  when '2' then 2
  when '3' then 3
  when '4' then 4
  when '5' then 5
  when '6' then 6
  when '7' then 7
  when '8' then 8
  when '9' then 9
  end
end

p my_atoi('42') # @CAT_IGNORE
p my_atoi('  -42') # @CAT_IGNORE
p my_atoi('4193 with words') # @CAT_IGNORE
p my_atoi('words and 987') # @CAT_IGNORE
p my_atoi('-91283472332') # @CAT_IGNORE
