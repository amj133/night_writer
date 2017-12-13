require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/translate_to_english'

class TranslateToEnglishTest < Minitest::Test

  def test_it_exists
    translate = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_instance_of TranslateToEnglish, translate
  end

  def test_translate_contains_contains_message
    translate = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."], translate.message
  end

  def test_create_nested_array_returns_nested_array
    translate = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal [["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."]], translate.create_nested

    translate2 = TranslateToEnglish.new([1, 2, 3, 4, 5, 6, 7, 8, 9])

    assert_equal [[1, 2, 3], [4, 5, 6], [7, 8, 9]], translate2.create_nested
  end

#add multi-line test
  def test_braille_chars_will_return_array_containing_strings_of_braille_characters_as_elements
    translate = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], translate.braille_chars

    translate2 = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0...", "0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0..", "0.00..",
      "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."], translate2.braille_chars
  end

  def test_english_lookup_returns_array_of_english_characters
    translate = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ['CAP', 'h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd'], translate.english_lookup

    translate2 = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0...", "0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e', 'l',
      'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd'], translate2.english_lookup
  end

  def test_pring_eng_will_return_message_in_english
    translate = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal "hello world", translate.print_eng

    translate2 = TranslateToEnglish.new(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0...", "0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])

    assert_equal "hello worldhello world", translate2.print_eng
  end


end
