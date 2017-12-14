require 'pry'
require './lib/braille_to_eng'

class NightReader
  attr_reader :message

  def read_file(filename)
    @message = File.readlines("./" + filename)
  end

  def remove_line_breaks
    @message.map do |lines|
      lines.delete("\n")
    end
  end

  def convert_to_eng
    eng_message = BrailleToEng.new(remove_line_breaks)
    eng_message.add_upcase.join
  end

  def output_new_file(filename)
    output = File.new("./" + filename, "w+")
    File.open(output, "w+") do |file|
      file.puts convert_to_eng
    end
  end

end
