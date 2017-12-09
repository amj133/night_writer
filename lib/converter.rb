require 'pry'

class Converter
  attr_reader :message

  CHARACTER_MAP ={
                 "a"=> "0.....",
                 "b"=>"0.0...",
                 "c"=>"00....",
                 "d"=>"00.0..",
                 "e"=>"0..0..",
                 "f"=>"000...",
                 "g"=>"0000..",
                 "h"=>"0.00..",
                 "i"=>".00...",
                 "j"=>".000..",
                 "k"=>"0...0.",
                 "l"=>"0.0.0.",
                 "m"=>"00..0.",
                 "n"=>"00.00.",
                 "o"=>"0..00.",
                 "p"=>"000.0.",
                 "q"=> "00000.",
                 "r"=>"0.000.",
                 "s"=>".00.0.",
                 "t"=>".0000.",
                 "u"=>"0...00",
                 "v"=>"0.0.00",
                 "w"=>".000.0",
                 "x"=>"00..00",
                 "y"=>"00.000",
                 "z"=>"0..000",
                 " "=>"......",
                 "CAP"=>".....0",
                 "!"=>"..000.",
                 "'"=>"....0.",
                 ","=>"..0...",
                 "-"=>"....00",
                 "."=>"..00.0",
                 "?"=>"..0.00",
                }

  def initialize(message)
    @message = message
  end

  def message_chars
    @char_array = @message.chars
  end

  def braille_lookup
    @braille_array = []
    special_chars = ["!", "'", ",", "-", ".", "?", " "]
    @char_array.each do |char|
      if char == char.upcase && special_chars.include?(char) == false         # && char != " "
        @braille_array << CHARACTER_MAP["CAP"]
        @braille_array << CHARACTER_MAP[char.downcase]
      else
        @braille_array << CHARACTER_MAP[char]
      end
    end
    @braille_array
  end

  def braille_top
    @braille_top = @braille_array.map do |braille|
      braille[0..1]
    end
    @braille_count = @braille_top.count
    @braille_top = @braille_top.join
  end

  def braille_middle
    @braille_middle = @braille_array.map do |braille|
      braille[2..3]
    end
    @braille_middle = @braille_middle.join
  end

  def braille_bottom
    @braille_bottom = @braille_array.map do |braille|
      braille[4..5]
    end
    @braille_bottom = @braille_bottom.join
  end

  def braille_count
    @braille_count
  end

  def top_slice
    @top_slice_array = []
    range_count = 1
    factor = 79
    loop_limit = (@braille_top.chars.count / 79.0).ceil
    loop_count = 0
    until loop_count == loop_limit
      end_limit = factor * range_count
      if range_count == 1
        beg_limit = 0
      else
        beg_limit = (factor * (range_count -1)) + 1
      end
      @top_slice_array << @braille_top.slice(beg_limit..end_limit)
      loop_count += 1
      range_count += 1
    end
    @top_slice_array
  end

  def middle_slice
    @middle_slice_array = []
    range_count = 1
    factor = 79
    loop_limit = (@braille_middle.chars.count / 79.0).ceil
    loop_count = 0
    until loop_count == loop_limit
      end_limit = factor * range_count
      if range_count == 1
        beg_limit = 0
      else
        beg_limit = (factor * (range_count -1)) + 1
      end
      @middle_slice_array << @braille_middle.slice(beg_limit..end_limit)
      loop_count += 1
      range_count += 1
    end
    @middle_slice_array
  end

  def bottom_slice
    @bottom_slice_array = []
    range_count = 1
    factor = 79
    loop_limit = (@braille_bottom.chars.count / 79.0).ceil
    loop_count = 0
    until loop_count == loop_limit
      end_limit = factor * range_count
      if range_count == 1
        beg_limit = 0
      else
        # beg_limit = end_limit + 1
        beg_limit = (factor * (range_count -1)) + 1
      end
      @bottom_slice_array << @braille_bottom.slice(beg_limit..end_limit)
      loop_count += 1
      range_count += 1
    end
    @bottom_slice_array
  end

  def combine_to_braille_stacked
    @braille_stacked = []
    loop_limit = (@braille_bottom.chars.count / 79.0).ceil
    loop_count = 0
    index_count = 0
    until loop_count == loop_limit
      @braille_stacked << @top_slice_array[index_count] + "\n" +
      @middle_slice_array[index_count] + "\n" +
      @bottom_slice_array[index_count] + "\n"
      index_count += 1
      loop_count += 1
      binding.pry
    end
  end

end

# converter = Converter.new("It Ran!")
# converter.message_chars
# converter.braille_lookup
# converter.braille_top
# converter.braille_middle
# converter.braille_bottom
#
# puts converter.print_braille
