require 'pry'
require './lib/braille_dictionary'

class TranslateToEnglish
  include BrailleDictionary

  attr_reader :message

  def message
    @message
  end

  def initialize(message)
    @message = message
  end

  def create_nested
    nested_message = []
    index = 0
    until @message[index] == nil
      nested_message << [@message[index], @message[index + 1], @message[index + 2]]
      index += 3
    end
    nested_message
  end

# use destructive slice!!!!
  def braille_chars
    braille_strings = []
    create_nested.each do |braille|
      beg_limit = 0
      end_limit = 1
      until braille[0][beg_limit] == nil
        braille_strings << braille[0][beg_limit..end_limit] +
          braille[1][beg_limit..end_limit] + braille[2][beg_limit..end_limit]
        beg_limit += 2
        end_limit += 2
      end
    end
    braille_strings
  end

  def english_lookup
    @eng_lookup = braille_chars.map do |character|
      CHARACTER_MAP.invert[character]
    end
  end

  def add_upcase
    english_lookup.each_with_index do |braille, index|
      if braille == "CAP"
        @eng_lookup[index + 1] = @eng_lookup[index + 1].upcase
        @eng_lookup[index] = nil
      end
    end
    @eng_lookup = @eng_lookup.compact
    binding.pry
  end

  def print_eng
    english_lookup.join
  end

end

a = TranslateToEnglish.new(["..0.0.0.0.0....00.0.0.00", "..00.00.0..0..00.0000..0", ".0....0.0.0....00.0.0..."])
p a.add_upcase
