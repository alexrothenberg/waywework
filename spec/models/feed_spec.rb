require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feed do
  before(:each) do
    @valid_attributes = {
      :url => "value for url",
      :name => "value for name",
      :feed_url => "value for feed_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Feed.create!(@valid_attributes)
  end
  
  it 'should download a feed' do
    feed = Feed.create!(@valid_attributes)
    URI.expects(:parse).with(feed.feed_url).returns(feed_uri=mock)
    feed_uri.expects(:read).returns(expected_xml=mock)
    feed.get_feed.should == expected_xml
  end
  
  it 'should parse an atom feed' do
    feed = Feed.create!(@valid_attributes)
    feed.expects(:get_feed).returns(xml=IO.read(File.join(RAILS_ROOT, 'spec', 'atom.xml')))
    Post.expects(:new).with(:contents=>'the first post', :title=>'Title for my first post', :published=>'2008-09-28T03:01:00Z').returns(post1=mock)
    Post.expects(:new).with(:contents=>'the second post', :title=>'The title of my second post', :published=>'2008-09-29T03:01:00Z').returns(post2=mock)
    feed.get_posts.should == [post1, post2]
  end
  
end
