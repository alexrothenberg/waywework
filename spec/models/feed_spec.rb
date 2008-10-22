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
    xml=IO.read(File.join(RAILS_ROOT, 'spec', 'atom.xml'))
    Post.expects(:new).with(has_entries( :contents=>'the first post', :title=>'Title for my first post', :published=>'2008-10-21 02:51:00', :url=>'http://my.blog.com/first_post.html')).returns(post1=mock)
    Post.expects(:new).with(has_entries( :contents=>'the second post', :title=>'The title of my second post', :published=>'2008-09-28 03:01:00', :url=>'http://my.blog.com/the_second_post.html')).returns(post2=mock)
    posts = feed.get_posts_from_atom(xml)
    posts.should == [post1, post2]
  end
  
  it 'should parse a rss feed' do
    feed = Feed.create!(@valid_attributes)
    xml=IO.read(File.join(RAILS_ROOT, 'spec', 'rss.xml'))
    Post.expects(:new).with(has_entries( :contents=>'the first post', :title=>'Title for my first post', :published=>'2008-09-15 19:15:00', :url=>'http://my.blog.com/first_post.html')).returns(post1=mock)
    Post.expects(:new).with(has_entries( :contents=>'the second post', :title=>'The title of my second post', :published=>'2008-02-13 11:24:00', :url=>'http://my.blog.com/the_second_post.html')).returns(post2=mock)
    posts = feed.get_posts_from_rss(xml)
    posts.should == [post1, post2]
  end
  
  it 'should get the atom feed and save posts' do
    feed = Feed.create!(@valid_attributes)
    feed.expects(:get_feed).returns(xml='an atom feed')
    feed.expects(:get_posts_from_atom).with(xml).returns([post1=mock, post2=mock])
    post1.expects(:save)
    post2.expects(:save)
    feed.get_latest
  end
  
  it 'should get the atom feed and save posts' do
    feed = Feed.create!(@valid_attributes)
    feed.expects(:get_feed).returns(xml='an rss feed')
    feed.expects(:get_posts_from_rss).with(xml).returns([post1=mock, post2=mock])
    post1.expects(:save)
    post2.expects(:save)
    feed.get_latest
  end
  
end
