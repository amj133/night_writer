require 'pry'
require './lib/braille_dictionary'

class Converter
  include BrailleDictionary
  attr_reader :message

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

#
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

# every . or 0 is considered a braille character in this count
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
      end_limit = (factor * range_count) + (range_count - 1) # + 1
      if range_count == 1
        beg_limit = 0
        end_limit = 79
      else
        beg_limit = (factor * (range_count -1)) + (range_count -1) # + 1
      end
      @top_slice_array << @braille_top.slice(beg_limit..end_limit)
      loop_count += 1
      range_count += 1
    end
    @top_slice_array
  end

# method for loop limit
  def middle_slice
    @middle_slice_array = []
    range_count = 1
    factor = 79
    loop_limit = (@braille_middle.chars.count / 79.0).ceil
    loop_count = 0
    until loop_count == loop_limit
      end_limit = (factor * range_count) + (range_count - 1) # + 1
      if range_count == 1
        beg_limit = 0
        end_limit = 79
      else
        beg_limit = (factor * (range_count -1)) + (range_count - 1)
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
      end_limit = (factor * range_count) + (range_count - 1) # + 1
      if range_count == 1
        beg_limit = 0
        end_limit = 79
      else
        beg_limit = (factor * (range_count -1)) + (range_count - 1) # + 1
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
                          @bottom_slice_array[index_count] # + "\n"
      index_count += 1
      loop_count += 1
    end
    @braille_stacked
  end

  def print_stack
    @braille_stacked.each do |lines|
      puts lines
    end
  end

end

# converter = Converter.new("I like to run in the countryside with my pants off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")
# converter.message_chars
# converter.braille_lookup
# converter.braille_top
# converter.braille_middle
# converter.braille_bottom
# converter.top_slice
# converter.middle_slice
# converter.bottom_slice
# converter.combine_to_braille_stacked
# converter.print_stack
