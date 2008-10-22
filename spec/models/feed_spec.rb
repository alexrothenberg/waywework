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
    URI.should_receive(:parse).with(feed.feed_url).and_return(feed_uri=mock('feed uri'))
    feed_uri.should_receive(:read).and_return(expected_xml=mock('expected xml'))
    feed.get_feed.should == expected_xml
  end
  
  it 'should parse an atom feed' do
    feed = Feed.create!(@valid_attributes)
    xml=IO.read(File.join(RAILS_ROOT, 'spec', 'atom.xml'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the first post', :title=>'Title for my first post', :published=>'2008-10-21 02:51:00', :url=>'http://my.blog.com/first_post.html')).and_return(post1=mock('post1'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the second post', :title=>'The title of my second post', :published=>'2008-09-28 03:01:00', :url=>'http://my.blog.com/the_second_post.html')).and_return(post2=mock('post2'))
    feed.get_posts_from_atom(xml)
  end
  
  it 'should parse an atom feed from blogger' do
    feed = Feed.create!(@valid_attributes)
    xml=IO.read(File.join(RAILS_ROOT, 'spec', 'atom2.xml'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'<span style=\"font-size:85%;\"> Recently, I joined a new project.</span>', :title=>'Title for my first post', :published=>'2008-10-19 15:50:00', :url=>'http://gouravtiwari.blogspot.com/2008/10/if-you-smell-something-stinking-flog-it.html')).and_return(post1=mock('post1'))
    feed.get_posts_from_atom(xml)
  end
  
  it 'should parse a rss feed' do
    feed = Feed.create!(@valid_attributes)
    xml=IO.read(File.join(RAILS_ROOT, 'spec', 'rss.xml'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the first post', :title=>'Title for my first post', :published=>'2008-09-15 19:15:00', :url=>'http://my.blog.com/first_post.html')).and_return(post1=mock('post1'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the second post', :title=>'The title of my second post', :published=>'2008-02-13 11:24:00', :url=>'http://my.blog.com/the_second_post.html')).and_return(post2=mock('post2'))
    feed.get_posts_from_rss(xml)
  end
  
  it 'should get the atom feed and save posts' do
    feed = Feed.create!(@valid_attributes)
    feed.should_receive(:get_feed).and_return(xml='an atom feed')
    feed.should_receive(:get_posts_from_atom).with(xml)
    feed.get_latest
  end
  
  it 'should get the atom feed and save posts' do
    feed = Feed.create!(@valid_attributes)
    feed.should_receive(:get_feed).and_return(xml='an <rss feed')
    feed.should_receive(:get_posts_from_rss).with(xml)
    feed.get_latest
  end
  
end
