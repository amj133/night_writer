require 'pry'
require './lib/braille_dictionary'

class EngToBraille
  include BrailleDictionary

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def message_chars
    char_array = @message.chars
  end

  def braille_lookup
    braille_array = []
    message_chars.each do |char|
      if char == char.upcase && SPECIAL_CHARS.include?(char) == false
        braille_array << CHARACTER_MAP["CAP"]
        braille_array << CHARACTER_MAP[char.downcase]
      else
        braille_array << CHARACTER_MAP[char]
      end
    end
    braille_array
  end

  def braille_top
    braille_lookup.map do |braille|
      braille[0..1]
    end.join
  end

  def braille_middle
    braille_lookup.map do |braille|
      braille[2..3]
    end.join
  end

  def braille_bottom
    braille_lookup.map do |braille|
      braille[4..5]
    end.join
  end

  def find_slicer_numb
    (braille_top.chars.count / 80.0).ceil
  end

  def row_slicer(braille_row)
    count = 0
    sliced_rows = []
    until count == find_slicer_numb
      sliced_rows << braille_row.slice!(0..79)
      count += 1
    end
    sliced_rows
  end

  def stacked_braille_rows
    stacked_rows = []
    count = 0
    until count == find_slicer_numb
      stacked_rows << row_slicer(braille_top)[count] + "\n" +
        row_slicer(braille_middle)[count] + "\n" +
        row_slicer(braille_bottom)[count]
      count += 1
    end
    stacked_rows
  end

end

# converter = EngToBraille.new(" !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
# puts converter.stacked_braille_rows
