require 'minitest/autorun'
require '../src/Bookmark'

class TestBookmark < Minitest::Test
  @empty_bookmark
  @url_bookmark
  
  def setup
    @empty_bookmark = Bookmark.new
    @url_bookmark = Bookmark.new('bookmark.com')
  end

  def test_new_bookmark_is_empty
    assert_equal '', @empty_bookmark.url
  end

  def test_new_bookmark_with_content
    assert_equal true, @url_bookmark.url.size > 0
  end
end
