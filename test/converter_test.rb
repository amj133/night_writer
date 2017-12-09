require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/converter'

class ConverterTest < Minitest::Test

  def test_it_exists
    converter = Converter.new("hello world")

    assert_instance_of Converter, converter
  end

  def test_converter_stores_message_as_attribute
    converter = Converter.new("hello world")

    assert_equal "hello world", converter.message
  end

  def test_message_chars_returns_message_character_array
    converter = Converter.new("hello world")

    assert_equal ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd'],
      converter.message_chars
  end

  def test_braille_lookup_returns_braille_array
    converter = Converter.new("it ran")

    converter.message_chars

    assert_equal [".00...", ".0000.", "......", "0.000.", "0.....", "00.00."],
      converter.braille_lookup
  end

  def test_braille_top_returns_first_two_chars
    converter = Converter.new("it ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal [".0", ".0", "..", "0.", "0.", "00"], converter.braille_top
  end

  def test_braille_mddle_returns_third_and_fourth_chars
    converter = Converter.new("it ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal ["0.", "00", "..", "00", "..", ".0"], converter.braille_middle
  end

  def test_braille_bottom_returns_fifth_and_sixth_chars
    converter = Converter.new("it ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal ["..", "0.", "..", "0.", "..", "0."], converter.braille_bottom
  end

  def test_print_will_return_braille_chars
    converter = Converter.new("it ran")

    converter.message_chars
    converter.braille_lookup
    converter.braille_top
    converter.braille_middle
    converter.braille_bottom

    assert_equal ".0.0..0.0.00\n0.00..00...0\n..0...0...0.", converter.print_braille
    puts converter.print_braille
  end

end
