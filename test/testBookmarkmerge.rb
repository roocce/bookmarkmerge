require('minitest/autorun')
require_relative('../src/bookmarkmerge.rb')

TestPath = File.expand_path('..',__FILE__)
HelpMessage = <<-HEREDOC
Usage: bookmarkmerge.rb [options]

bookmarkmerge takes an input folder with the bookmarks to be processed.

    -i, --input-folder=INPUT         Directory with the bookmark files

Common options:
    -h, --help                       Prints this help
        --version                    Show version
HEREDOC

class TestInputParameter < Minitest::Test
  def setup
    @warning = "No input folder was provided\n"
  end

  def test_empty_input_parameter
    assert_output(::HelpMessage,@warning) do
      Bookmarkmerge.main([])
    end
  end
end

class TestInputFolderExists < Minitest::Test
  def setup
    @warning = "Folder doesn't exist or is not readable\n"
  end
  
  def test_folder_does_not_exist
   assert_output(::HelpMessage,@warning) do
      Bookmarkmerge.main(['--input-folder=phantom'])
   end
  end
end

class TestInvalidFolder < Minitest::Test
  def setup
    @warning = "Folder doesn't exist or is not readable\n"
    @inputFolderName = "pholder"
    Dir.mkdir(::TestPath+"/#{@inputFolderName}")
    @inputFolder = Dir.new(::TestPath+"/#{@inputFolderName}")
    File.chmod(000, @inputFolder.path)
  end

  def test_folder_not_readable
    assert_output(::HelpMessage,@warning) do
      Bookmarkmerge.main(['-i', @inputFolder.path])
   end
  end

  def teardown
    Dir.rmdir(@inputFolder.path)
  end
end

class TestSingleFile < Minitest::Test
  def setup
    @warning = "Insufficient input files\n"
    @inputFolderName = "onefile"
    Dir.mkdir(::TestPath+"/#{@inputFolderName}")
    @inputFolder = Dir.new(::TestPath+"/#{@inputFolderName}")
    @inputFile = File.new(@inputFolder.path+"/bookmarks.html", File::CREAT)
  end

  def test_single_input_file
    assert_output(::HelpMessage,@warning) do
      Bookmarkmerge.main(['-i', @inputFolder.path])
    end
  end

  def teardown
    File.delete(@inputFile.path)
    Dir.rmdir(@inputFolder.path)
  end
end

class TestInputFilesReadability < Minitest::Test
  def setup
    @warning = " input file is readable\n"
    @inputFolderName = "tenfiles"
    Dir.mkdir(::TestPath+"/#{@inputFolderName}")
    @inputFolder = Dir.new(::TestPath+"/#{@inputFolderName}")
    @inputFiles = (1..10).map { |i| 
      File.new(@inputFolder.path+"/bookmarks#{i}.html", File::RDONLY|File::CREAT, 0000)
    }
  end

  def test_no_files_readable
    assert_output(nil,"No"<<@warning) do
      Bookmarkmerge.main(['-i', @inputFolder.path])
    end
  end

 def test_some_files_readable
   @inputFiles.each_index do |index|
      if index % 2 == 0
        @inputFiles[index].chmod(0400)
      end
    end
    assert_output(nil,"Not every"<<@warning) do
      Bookmarkmerge.main(['-i', @inputFolder.path])
    end
  end

  def test_all_files_readable
    @inputFiles.each do |file|
      file.chmod(0400)
    end
    #assert_output("","") do
      Bookmarkmerge.main(['-i', @inputFolder.path])
    #end
  end

  def teardown
    @inputFiles.each do |file|
      File.delete(file.path)
    end
    Dir.rmdir(@inputFolder.path)
  end
end
