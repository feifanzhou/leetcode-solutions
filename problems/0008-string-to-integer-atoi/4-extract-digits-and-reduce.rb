INT32_MAX = 2 ** 31 - 1
INT32_MIN = -1 * 2 ** 31

def my_atoi(str)
  str_without_leading_trailing_spaces = str.strip
  if (match = str_without_leading_trailing_spaces.match(/^([+-]?\d+)/))
    number_string = match.captures.first
    int = number_string.reverse.each_char.with_index.reduce(0) do |result, (char, index)|
      case char
      when '-'
        result * -1
      when '+'
        result
      when /\d/
        result + char_to_number(char) * 10 ** index
      else
        return 0
      end
    end

    if int > INT32_MAX
      INT32_MAX
    elsif int < INT32_MIN
      INT32_MIN
    else
      int
    end
  else
    return 0
  end
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
