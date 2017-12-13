require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_writer'

class NightWriterTest < Minitest::Test

  def test_it_exists
    night_write = NightWriter.new

    assert_instance_of NightWriter, night_write
  end

  def test_read_file_converts_file_message_to_string
    night_write = NightWriter.new

    night_write.read_file("test/message_test1.txt")

    assert_equal "abc", night_write.message
  end

  def test_remove_line_breaks_replaces_line_breaks_with_a_space
    night_write = NightWriter.new

    night_write.read_file("test/message_test2.txt")
    night_write.remove_line_breaks

    assert_equal "I like to fly in the sky! My bees are the knees? !?',-. To another great cocktail", night_write.message
  end

  def test_char_count_returns_correct_number_of_characters
    night_write = NightWriter.new

    assert_equal 11, night_write.char_count("hello world")
  end

  def test_convert_to_praill_returns_braille_message_with_stacked_rows
    night_write = NightWriter.new

    night_write.read_file("test/message_test1.txt")

    assert_equal ["0.0.00\n..0...\n......"], night_write.convert_to_braille
  end

end
