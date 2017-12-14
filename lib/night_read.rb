require './lib/night_reader'
require 'pry'

input = ARGV[0]
output = ARGV[1]

night_read = NightReader.new
night_read.read_file(input)
night_read.output_new_file(output)

puts "Created '#{output}' containing #{night_read.convert_to_eng.chars.count} characters"
