require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class WhereToGo::App::PostsHelperTest < Test::Unit::TestCase
  context "SampleBlog::App::PostsHelper" do
    setup do
      @helpers = Class.new
      @helpers.extend WhereToGo::App::PostsHelper
    end

    should "return nil" do
      assert_equal nil, @helpers.feed_tag(:rss, :title => "RSS", :href => "http://example.com/rss")
    end
  end
end
