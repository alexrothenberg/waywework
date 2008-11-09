require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/index.html.erb" do
  include PostsHelper
  
  before(:each) do
    stub_feed = stub_model(Feed,
      :author=>'feed_author',
      :name=>'feed name', 
      :url => 'feed url'
      )
    assigns[:posts] = [
      stub_model(Post,
        :contents => "value for contents",
        :published => Time.now - 1.day,
        :feed => stub_feed
      ),
      stub_model(Post,
        :contents => "value for contents",
        :published => Time.now - 1.month,
        :feed => stub_feed
      )
    ]
    assigns[:active_feeds] = [
      stub_model(Feed,  :id=>1, :author=>9),
      stub_model(Feed,  :id=>2, :author=>10)
    ]
    assigns[:activity_by_date] = 
      {2007 => {1 => 5, 2=>10},
       2008 => {7 => 8, 9=>3}
      }
    
      
  end

  it "should render list of posts" do
    render "/posts/index.html.erb"
    response.should have_text /1 day ago.*/
    response.should have_text /about 1 month ago.*/
    response.should have_text /July/
    response.should have_text /September/
    response.should have_text /January/
    response.should have_text /February/
    response.should have_tag('p[class="content"]', "value for contents", 2)
  end
end

