INT32_MAX = 2 ** 31 - 1
INT32_MIN = -1 * 2 ** 31

def my_atoi(str)
  digits = []
  found_number = false
  is_negative = false
  str.each_char do |char|
    next if whitespace?(char) && !found_number

    if !found_number
      found_number = true
      if char == '-'
        is_negative = true
        next
      elsif char == '+'
        is_negative = false
        next
      end
    end

    if found_number && digit?(char)
      digits << char
    else
      break
    end
  end

  return 0 if digits.empty?

  result = 0
  digits.each do |char|
    result = result * 10 + char_to_number(char)
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
