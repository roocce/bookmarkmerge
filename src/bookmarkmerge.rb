require 'optparse'
require 'ostruct'
require 'pp'
require_relative 'ScriptOptions'

module Bookmarkmerge

  Version = '0.0.1'

  def self.parse(argv)
    @options = ScriptOptions.new

    @args = OptionParser.new do |parser|
        @options.define_options(parser)
        parser.parse!(argv)
    end # opt_parser

    warn $stderr.is_a?('IO')

#    if @options.input_folder.nil? && $stderr.string.empty?
#      warn @options.input_folder.class
#      #warn "No input folder was provided"
#      print @args.help
#    end

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
