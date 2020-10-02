class BookmarkFolder < Dir
end

class ScriptOptions
  
  attr_accessor :input_folder

  def define_options(parser)
    parser.banner = "Usage: bookmarkmerge.rb [options]"
    parser.separator ""
    parser.separator "bookmarkmerge takes an input folder with the bookmarks to be processed."

    # Specific Options
    parser.separator ""
    parse_input_folder(parser)
    
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

  
  def parse_input_folder(parser)
    parser.accept(BookmarkFolder) do |input|

      begin
        if input.empty?
          raise 'No input folder was provided'
        end

        inputFolder = BookmarkFolder.new(input)

        case
        when Dir.empty?(inputFolder) || inputFolder.children.length < 2
          raise 'Insufficient input files'
          print parser.help()
        when inputFolder.children.all? { |filename| !File.readable?(inputFolder.path+"/"+filename) }
          warn('No input file is readable')
        when inputFolder.children.any? { |filename| !File.readable?(inputFolder.path+"/"+filename) }
          warn('Not every input file is readable')
        else
          return inputFolder
        end
      rescue Errno::ENOENT, Errno::EACCES => err
        warn 'Folder doesn\'t exist or is not readable'
        print parser.help()
      rescue => err
        warn err.message
        print parser.help()
      end

    end

    parser.on("-i", "--input-folder=INPUT", BookmarkFolder, "Directory with the bookmark files") do |folder|
      self.input_folder = folder
    end
  end


end # ScriptOptions
