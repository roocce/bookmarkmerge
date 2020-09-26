require 'optparse'
require 'ostruct'
require 'pp'

module Bookmarkmerge

  Version = '0.0.1'

  class ScriptOptions
    
    attr_accessor :input

    def initialize
      self.input = ""
    end

    def define_options(parser)
      parser.banner = "Usage: bookmarkmerge.rb [options]"
      parser.separator ""
      parser.separator "bookmarkmerge takes an input folder with the bookmarks to be processed."

      # Specific Options
      parser.separator ""
      parse_input(parser)
      
      # Common Options
      parser.separator ""
      parser.separator "Common options:"

      parser.on_tail("-h", "--help", "Prints this help") do
        puts parser
        exit
      end

      parser.on_tail("--version", "Show version") do
        puts Version
        exit
      end
    end
    
    def parse_input(parser)
      parser.on("-i", "--input-folder=INPUT", String, "Directory with the bookmark files") do |input|
        self.input = input
      end
    end

  end # ScriptOptions

  def self.parse(argv)
    @options = ScriptOptions.new

    @args = OptionParser.new do |parser|
        @options.define_options(parser)
        parser.parse!(argv)
    end # opt_parser
    
    if @options.input.empty?
      warn('No input folder was provided')
      print @args.help()
    elsif !test('d', @options.input) || !test('r', @options.input)
      warn('Folder doesn\'t exist or is not readable')
      print @args.help()
    else
      inputFolder = Dir.new(@options.input)
      if Dir.empty?(inputFolder) || inputFolder.children.length < 2
        warn('Insufficient input files')
        print @args.help()
      else

        noFileReadable = inputFolder.children.all? { |filename| !File.readable?(inputFolder.path+"/"+filename) }
        if noFileReadable
          warn('No input file is readable')
        else
          someFilesReadable = inputFolder.children.any? { |filename| !File.readable?(inputFolder.path+"/"+filename) }
          if someFilesReadable 
            warn('Not every input file is readable')
          end
        end

      end
    end

    @options

  end # self.parse

  def main(argv)
    options = self.parse(argv)
    #pp options
  end

  module_function :main
end # end module

END{
  if File.basename(__FILE__) == File.basename($0)
    Bookmarkmerge.main(ARGV)
  end
}
