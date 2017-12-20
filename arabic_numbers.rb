class ArabicNumbers
  def hundreds
    ['one-hundred ', 'two-hundred ', 'three-hundred ',
     'four-hundred ', 'five-hundred ', 'six-hundred ',
     'seven-hundred ', 'eight-hundred ', 'nine-hundred ']
  end

  def tens
    %w[ten twenty thirty fourty fifty sixty seventy eighty
       ninety]
  end

  def youngs
    ['eleven ', 'twelve ', 'thirteen ', 'fourteen ', 'fiveteen ',
     'sixteen ', 'seventeen', 'eighteen ', 'nineteen ']
  end

  def singles
    ['one ', 'two ', 'three ', 'four ', 'five ', 'six ', 'seven ', 'eight ', 'nine ']
  end

  def convert_millions(left)
    write = left / 1_000_000
    'one million' if write.positive?
  end

  def convert_thousands(num_string, left)
    write = left / 1000
    left -= write * 1000
    if write.positive?
      num_string += convert_hundred write
      num_string += 'thousand '
    end
    num_string += convert_hundred left if left.positive?
    num_string
  end

  def iteration_hundred(write)
    hundreds.each_with_index do |val, index|
      return val if write == index + 1
    end
  end

  def convert_hundred(number)
    num_string = ''
    left = number
    write = left / 100
    left -= write * 100
    num_string += iteration_hundred write if write.positive?
    convert_decimals num_string, left
  end

  def iteration_decimals(write, left)
    tens.each_with_index do |val, index|
      if write == 1 && left.positive?
        youngs.each_with_index do |young_val, young_index|
          return young_val if left == young_index + 1
        end
      elsif write == index + 1
        return val
      end
    end
  end

  def convert_decimals(num_string, left)
    write = left / 10
    left -= write * 10
    num_string += iteration_decimals(write, left) if write.positive?
    return num_string if left.zero? || write == 1
    num_string += '-' if write.positive?
    convert_units num_string, left
  end

  def convert_units(num_string, left)
    write = left
    if write.positive?
      singles.each_with_index do |val, index|
        if write == index + 1
          num_string += val
          break
        end
      end
    end
    num_string
  end

  def english_number(number)
    num_string = ''
    return convert_millions number if number == 1_000_000
    return convert_thousands num_string, number if number >= 1000
    return convert_hundred number if number >= 100
    return convert_decimals num_string, number if number >= 10
    convert_units num_string, number
  end
end
arabic_number = ArabicNumbers.new
puts 'Type number'
puts arabic_number.english_number(gets.chomp.to_i)
