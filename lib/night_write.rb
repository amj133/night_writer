require './lib/night_writer'
require 'pry'

input = ARGV[0]
output = ARGV[1]

night_write = NightWriter.new
night_write.read_file(input)
night_write.output_new_file(output)

puts "Created '#{output}' containing #{night_write.message.chars.count} characters"
