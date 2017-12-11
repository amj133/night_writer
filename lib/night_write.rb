require './lib/night_writer'
require 'pry'

input = ARGV[0]
output = ARGV[1]

english = NightWriter.new
english.convert_to_braille(input)
english.output_new_file(output)
