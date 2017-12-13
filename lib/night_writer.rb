require 'pry'
require './lib/eng_to_braille'

class NightWriter
  attr_reader :message

  def read_file(filename)
    @message = File.read("./" + filename).chop
  end

  def remove_line_breaks
    @message = @message.gsub("\n", " ")
  end

  def convert_to_braille
    braille_message = EngToBraille.new(remove_line_breaks)
    braille_message.stacked_braille_rows
  end

  def output_new_file(filename)
    output = File.new("./" + filename, "w+")
    File.open(output, "w+") do |file|
      file.puts convert_to_braille
    end
  end

end
