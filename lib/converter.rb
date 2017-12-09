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
    @char_array.each do |char|
      if char == char.upcase && char != " "
        @braille_array << CHARACTER_MAP["CAP"]
        @braille_array << CHARACTER_MAP[char.downcase]
      else
        @braille_array << CHARACTER_MAP[char]
      end
    end
    @braille_array
    # if a capital letter, we want to strings (CAP) ".....0" + braille letter string
  end


  # if @message.chars.count > 80
  #   @chars_with_breaks = @char_array.map.with_index do |char, index|
  #     if index % 80 == 0
  #       insert()
  #
  #   end

  def braille_top
    @braille_top = @braille_array.map do |braille|
      braille[0..1]
    end
  end

  def braille_middle
    @braille_middle = @braille_array.map do |braille|
      braille[2..3]
    end
  end

  def braille_bottom
    @braille_bottom = @braille_array.map do |braille|
      braille[4..5]
    end
  end

  # maybe put print methods in another class
  def print_braille
    @braille_top.join + "\n" +
    @braille_middle.join + "\n" +
    @braille_bottom.join
  end
end

converter = Converter.new("It Ran!")
converter.message_chars
converter.braille_lookup
converter.braille_top
converter.braille_middle
converter.braille_bottom

puts converter.print_braille
