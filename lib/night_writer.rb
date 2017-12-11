require 'pry'
require './lib/converter.rb'

class NightWriter

  # def initialize
  # end

  def read_file(filename)
    @message = File.read("./lib/" + filename).chop
  end

  def convert_to_braille(filename)
    read_file(filename)
    converter = Converter.new(@message)
    converter.message_chars
    converter.braille_lookup
    converter.braille_top
    converter.braille_middle
    converter.braille_bottom
    converter.top_slice
    converter.middle_slice
    converter.bottom_slice
    converter.combine_to_braille_stacked
    @braille_print = converter.print_stack
  end

  def output_new_file(filename)
    output = File.new("./lib/" + filename, "w+")
    File.open(output, "w+") do |file|
      file.puts @braille_print
    end
  end

end

# joe = NightWriter.new
# joe.convert_to_braille("message.txt")
# joe.output_new_file


#---------------------------------------
# puts File.read("./lib/message.txt")
#---------------------------------------

#---------------------------------------
# old_file = File.open("message.txt", "w+")
# message = puts old_file.read
# # old_file = File.read("message.txt", "w+")
# old_file.close
#---------------------------------------


# new_file = File.new("braille.txt", "w+")
