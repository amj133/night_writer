require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_reader'

class NightReaderTest < Minitest::Test

  def test_it_exists
    night_read = NightReader.new

    assert_instance_of NightReader, night_read
  end

  def test_read_file_returns_array_with_lines_as_elements
    night_read = NightReader.new

    assert_equal ["..............0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...0...0...00..\n",
                  "..00..0...000...0....0.00.00000.00..0....0.00.00000.00..0.00...0.0......0.......\n",
                  "..0.0...00.000....................0.0.0.0.0.0.0.0.0.0.0000.0000000.0...0...0...0\n",
                  "00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0..0...0....0..\n",
                  ".0...0..0...00..00..0...00......0........0...0..0...00..00..0...00......0...00..\n",
                  "...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00..000.000.0.0.0\n",
                  "00..00..0.\n",
                  ".....0...0\n",
                  "00.000.000\n"], night_read.read_file('test/message_test3.txt')
  end

  def test_remove_line_breaks_will_remove_line_breaks
    night_read = NightReader.new

    night_read.read_file('test/message_test3.txt')

    assert_equal ["..............0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...0...0...00..",
                  "..00..0...000...0....0.00.00000.00..0....0.00.00000.00..0.00...0.0......0.......",
                  "..0.0...00.000....................0.0.0.0.0.0.0.0.0.0.0000.0000000.0...0...0...0",
                  "00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0..0...0....0..",
                  ".0...0..0...00..00..0...00......0........0...0..0...00..00..0...00......0...00..",
                  "...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00..000.000.0.0.0",
                  "00..00..0.",
                  ".....0...0",
                  "00.000.000"], night_read.remove_line_breaks
  end

  def test_convert_to_eng_returns_english_message
    night_read = NightReader.new

    night_read.read_file('test/message_test3.txt')

    assert_equal " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", night_read.convert_to_eng
  end

end
