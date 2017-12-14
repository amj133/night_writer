require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/braille_to_eng'

class BrailleToEngTest < Minitest::Test

  def test_it_exists
    translate = BrailleToEng.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_instance_of BrailleToEng, translate
  end

  def test_translate_contains_contains_message
    translate = BrailleToEng.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."], translate.message
  end

  def test_create_nested_array_returns_nested_array
    translate = BrailleToEng.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal [["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."]], translate.create_nested

    translate2 = BrailleToEng.new([1, 2, 3, 4, 5, 6, 7, 8, 9])

    assert_equal [[1, 2, 3], [4, 5, 6], [7, 8, 9]], translate2.create_nested
  end

  def test_unstack_braille_chars_will_return_array_containing_strings_of_braille_characters_as_elements
    translate = BrailleToEng.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], translate.unstack_braille_chars

    translate2 = BrailleToEng.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0...", "0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0..", "0.00..",
      "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], translate2.unstack_braille_chars
  end

  def test_english_lookup_returns_array_of_english_characters
    translate = BrailleToEng.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd'], translate.english_lookup

    translate2 = BrailleToEng.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0...", "0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e', 'l',
      'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd'], translate2.english_lookup
  end

  def test_add_upcase_capitalizes_correct_characters
    translate = BrailleToEng.new(["..0.0.0.0.0....00.0.0.00", "..00.00.0..0..00.0000..0", ".0....0.0.0....00.0.0..."])

    assert_equal ['H', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd'], translate.add_upcase

    translate2 = BrailleToEng.new(["..0.0.0.0.0......00.0.0.00", "..00.00.0..0....00.0000..0", ".0....0.0.0....0.00.0.0..."])

    assert_equal ['H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd'], translate2.add_upcase
  end

end
