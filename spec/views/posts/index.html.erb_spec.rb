require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/index.html.erb" do
  before(:each) do
    stub_feed = stub_model(Feed,
      :author=>'feed_author',
      :name=>'feed name',
      :url => 'feed url'
      )
    assign(:posts, [
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
    ])
    assign(:active_feeds, [
      stub_model(Feed,  :id=>1, :author=>'Alex'),
      stub_model(Feed,  :id=>2, :author=>'Yash')
    ])
    assign(:activity_by_date,
      {2007 => {1 => 5, 2=>10},
       2008 => {7 => 8, 9=>3}
      })


  end

  it "should render list of posts" do
    render
    rendered.should =~ /1 day ago.*/
    rendered.should =~ /about 1 month ago.*/
    rendered.should =~ /July/
    rendered.should =~ /September/
    rendered.should =~ /January/
    rendered.should =~ /February/
    rendered.should =~ /value for contents/
  end
end

