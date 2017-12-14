require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/eng_to_braille'

class EngToBrailleTest < Minitest::Test

  def test_it_exists
    converter = EngToBraille.new("hello world")

    assert_instance_of EngToBraille, converter
  end

  def test_converter_stores_message_as_attribute
    converter = EngToBraille.new("hello world")

    assert_equal "hello world", converter.message
  end

  def test_message_chars_returns_message_character_array
    converter = EngToBraille.new("hello world")

    assert_equal ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd'],
      converter.message_chars
  end

  def test_braille_lookup_returns_array_of_braille_strings
    converter = EngToBraille.new("it ran")

    assert_equal [".00...", ".0000.", "......", "0.000.", "0.....", "00.00."],
      converter.braille_lookup

    converter2 = EngToBraille.new("It! Ran?")

    assert_equal [".....0", ".00...", ".0000.", "..000.", "......", ".....0", "0.000.", "0.....", "00.00.", "..0.00"],
      converter2.braille_lookup

    converter3 = EngToBraille.new(" !',-.?")

    assert_equal ["......", "..000.", "....0.", "..0...", "....00", "..00.0", "..0.00"],
      converter3.braille_lookup
  end

  def test_braille_top_returns_top_row_of_message
    converter = EngToBraille.new("it ran")

    assert_equal ".0.0..0.0.00", converter.braille_top
  end

  def test_braille_top_returns_top_row_of_message_with_caps_and_special_chars
    converter = EngToBraille.new("It Ran!',")

    assert_equal "...0.0....0.0.00......", converter.braille_top
  end

  def test_braille_middle_row_of_message
    converter = EngToBraille.new("it ran")

    assert_equal "0.00..00...0", converter.braille_middle
  end

  def test_braille_middle_row_returns_middle_row_of_message_with_caps_and_special_chars
    converter = EngToBraille.new("It Ran-.?")

    assert_equal "..0.00....00...0..000.", converter.braille_middle
  end

  def test_braille_bottom_returns_bottom_row_of_message
    converter = EngToBraille.new("it ran")

    assert_equal "..0...0...0.", converter.braille_bottom
  end

  def test_braille_bottom_returns_bottom_row_of_message_with_caps_and_special_chars
    converter = EngToBraille.new("It Ran!?-")

    assert_equal ".0..0....00...0.0.0000", converter.braille_bottom
  end

  def test_row_slicer_parses_braille_top_into_80_char_string_elements_in_an_array
    converter = EngToBraille.new("I like to run in the countryside with my shirt off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")

    top_row = converter.braille_top
    top_row_count = top_row.chars.count
    top_sliced = converter.row_slicer(top_row)

    assert top_sliced[0].chars.count == 80
    assert top_sliced[1].chars.count == 80
    assert top_sliced[2].chars.count == 80
    assert top_sliced[3].chars.count == 80
    assert top_sliced[4].chars.count == 80
    assert top_sliced[5].chars.count == 80
    assert top_sliced[6].chars.count == (top_row_count - 80 * 6)
  end

  def test_row_slicer_parses_braille_middle_into_80_char_string_elements_in_an_array
    converter = EngToBraille.new("I like to run in the countryside with my shirt off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")

    middle_row = converter.braille_middle
    middle_row_count = middle_row.chars.count
    middle_sliced = converter.row_slicer(middle_row)

    assert middle_sliced[0].chars.count == 80
    assert middle_sliced[1].chars.count == 80
    assert middle_sliced[2].chars.count == 80
    assert middle_sliced[3].chars.count == 80
    assert middle_sliced[4].chars.count == 80
    assert middle_sliced[5].chars.count == 80
    assert middle_sliced[6].chars.count == (middle_row_count - 80 * 6)
  end
#
  def test_row_slicer_parses_braille_bottom_into_80_char_string_elements_in_an_array
    converter = EngToBraille.new("I like to run in the countryside with my shirt off and tied around my neck especially during the hot august summers.  There is something about the sun on my buttocks that makes me feel special, like a mountain lion or an orangutang on the hunt for food.")

    bottom_row = converter.braille_bottom
    bottom_row_count = bottom_row.chars.count
    bottom_sliced = converter.row_slicer(bottom_row)

    assert bottom_sliced[0].chars.count == 80
    assert bottom_sliced[1].chars.count == 80
    assert bottom_sliced[2].chars.count == 80
    assert bottom_sliced[3].chars.count == 80
    assert bottom_sliced[4].chars.count == 80
    assert bottom_sliced[5].chars.count == 80
    assert bottom_sliced[6].chars.count == (bottom_row_count - 80 * 6)
  end

  def test_stacked_braille_rows_returns_array_with_each_element_containing_three_braille_lines
    converter = EngToBraille.new("hello world")

    assert_equal ["0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0..."], converter.stacked_braille_rows
  end

end
