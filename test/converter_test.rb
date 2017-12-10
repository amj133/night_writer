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

  def test_braille_lookup_does_not_capitalize_special_characters
    converter = Converter.new("it! ran?")

    converter.message_chars

    assert_equal [".00...", ".0000.", "..000.", "......", "0.000.", "0.....", "00.00.", "..0.00"],
      converter.braille_lookup
  end

  def test_braille_top_returns_top_row_of_message
    converter = Converter.new("it ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal ".0.0..0.0.00", converter.braille_top
  end

  def test_braille_top_returns_top_row_of_message_with_caps
    converter = Converter.new("It Ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal "...0.0....0.0.00", converter.braille_top
  end

  def test_braille_middle_row_of_message
    converter = Converter.new("it ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal "0.00..00...0", converter.braille_middle
  end

  def test_braille_middle_row_returns_middle_row_of_message_with_caps
    converter = Converter.new("It Ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal "..0.00....00...0", converter.braille_middle
  end

  def test_braille_bottom_returns_bottom_row_of_message
    converter = Converter.new("it ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal "..0...0...0.", converter.braille_bottom
  end

  def test_braille_bottom_returns_bottom_row_of_message_with_caps
    converter = Converter.new("It Ran")

    converter.message_chars
    converter.braille_lookup

    assert_equal ".0..0....00...0.", converter.braille_bottom
  end

  def test_top_slice_returns_array_where_each_elements_character_count_less_than_80
    converter = Converter.new("I like to run in the countryside with my pants off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")

    converter.message_chars
    converter.braille_lookup
    converter.braille_top

    assert converter.top_slice[0].chars.count == 80
  end

  def test_middle_slice_returns_array_where_each_elements_character_count_less_than_80
    converter = Converter.new("I like to run in the countryside with my pants off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")

    converter.message_chars
    converter.braille_lookup
    converter.braille_middle

    assert converter.middle_slice[0].chars.count == 80
  end

  def test_bottom_slice_returns_array_where_each_elements_character_count_equals_80
    converter = Converter.new("I like to run in the countryside with my pants off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")

    converter.message_chars
    converter.braille_lookup
    converter.braille_bottom

    assert converter.bottom_slice[0].chars.count == 80
    assert converter.bottom_slice[1].chars.count == 80
  end

  def test_combine_to_braille_stacked_equals_correct_number_of_characters
    skip
    converter = Converter.new("I like to run in the countryside with my pants off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")

    converter.message_chars
    converter.braille_lookup
    converter.braille_top
    converter.braille_middle
    converter.braille_bottom
    converter.top_slice
    converter.middle_slice
    converter.bottom_slice


    assert_equal converter.braille_count, converter.combine_to_braille_stacked[0].chars.count
  end

end
