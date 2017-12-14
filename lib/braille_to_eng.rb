require 'pry'
require './lib/braille_dictionary'

class BrailleToEng
  include BrailleDictionary

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def create_nested
    nested_message = []
    index = 0
    until @message[index] == nil
      nested_message << [@message[index], @message[index + 1],
                         @message[index + 2]]
      index += 3
    end
    nested_message
  end

  def unstack_braille_chars
    braille_strings = []
    create_nested.each do |braille|
      until braille[0][0] == nil
        braille_strings << braille[0].slice!(0..1) +
                           braille[1].slice!(0..1) +
                           braille[2].slice!(0..1)
      end
    end
    braille_strings
  end

  def english_lookup
    @eng_lookup = unstack_braille_chars.map do |character|
      CHARACTER_MAP.invert[character]
    end
  end

  def add_upcase(eng_lookup)
    eng_lookup.each_with_index do |braille, index|
      if braille == "CAP"
        @eng_lookup[index + 1] = @eng_lookup[index + 1].upcase
        @eng_lookup[index] = nil
      end
    end
    @eng_lookup = @eng_lookup.compact
  end

end
