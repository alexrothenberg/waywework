# == Schema Information
# Schema version: 20081022162832
#
# Table name: feeds
#
#  id         :integer(4)      not null, primary key
#  url        :string(255)
#  name       :string(255)
#  feed_url   :string(255)
#  author     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Feed do
  before(:each) do
    @valid_attributes = {
      :author => "value for author",
      :url => "value for url",
      :name => "value for name",
      :feed_url => "value for feed_url"
    }
  end

  it "should create a new instance given valid attributes" do
    feed = Feed.new(@valid_attributes)
    feed.save
  end

  it "should create a new instance given valid attributes and load posts" do
    feed = Feed.new(:author => "value for author", :feed_url => "value for feed_url")
    feed.should_receive(:get_latest)
    feed.save
  end

  it 'should download a feed' do
    feed = Feed.create!(@valid_attributes)
    URI.should_receive(:parse).with(feed.feed_url).and_return(feed_uri=mock('feed uri'))
    feed_uri.should_receive(:read).and_return(expected_xml=mock('expected xml'))
    feed.get_feed.should == expected_xml
  end

  it 'should parse an atom feed' do
    feed = Feed.create!(@valid_attributes)
    xml=IO.read(File.join(Rails.root, 'spec', 'atom.xml'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the first post',  :title=>'Title for my first post',  :category=>nil,   :published=>Time.zone.parse('2008-10-21 02:51:00').to_s(:db), :updated=>Time.zone.parse('2008-10-21 03:15:37').to_s(:db), :url=>'http://my.blog.com/first_post.html'     )).and_return(post1=mock('post1'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the second post', :title=>'The title of my second post', :category=>nil, :published=>Time.zone.parse('2008-09-28 03:01:00').to_s(:db), :updated=>Time.zone.parse('2008-10-16 16:59:00').to_s(:db), :url=>'http://my.blog.com/the_second_post.html')).and_return(post2=mock('post2'))
    feed.stub!(:puts)
    feed.get_posts_from_atom(xml)
  end

  it 'should parse an atom feed from blogger' do
    feed = Feed.create!(@valid_attributes)
    xml=IO.read(File.join(Rails.root, 'spec', 'atom2.xml'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'<span style="font-size:85%;"> Recently, I joined a new project.</span>', :category=>nil, :title=>'Title for my first post', :published=>Time.zone.parse('2008-10-19 21:20:00').to_s(:db), :updated=>Time.zone.parse("2008-10-21 07:59:25").to_s(:db), :url=>'http://gouravtiwari.blogspot.com/2008/10/if-you-smell-something-stinking-flog-it.html')).and_return(post1=mock('post1'))
    feed.stub!(:puts)
    feed.get_posts_from_atom(xml)
  end

  it 'should parse a rss feed' do
    feed = Feed.create!(@valid_attributes)
    xml=IO.read(File.join(Rails.root, 'spec', 'rss.xml'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the first post',  :title=>'Title for my first post',     :url=>'http://my.blog.com/first_post.html'     )).and_return(post1=mock('post1'))
    feed.should_receive(:create_post).with(hash_including(:contents=>'the second post', :title=>'The title of my second post', :url=>'http://my.blog.com/the_second_post.html')).and_return(post2=mock('post2'))
    feed.get_posts_from_rss(xml)
  end

  it 'should get the atom feed and save posts' do
    feed = Feed.create!(@valid_attributes)
    feed.should_receive(:get_feed).and_return(xml='an atom feed')
    feed.should_receive(:get_posts_from_atom).with(xml).and_return(true)
    feed.stub!(:puts)
    feed.get_latest
  end

  it 'should get the rss feed and save posts' do
    feed = Feed.create!(@valid_attributes)
    feed.should_receive(:get_feed).and_return(xml='an rss feed')
    feed.should_receive(:get_posts_from_atom).with(xml).and_return(false)
    feed.should_receive(:get_posts_from_rss).with(xml)
    feed.stub!(:puts)
    feed.get_latest
  end

  it 'should get name and url from atom feed xml if blank' do
    feed = Feed.new(:author => "value for author", :feed_url => "value for feed_url")
    entries = stub('Entries', :each=>true, :blank? => false)
    RSS::Parser.should_receive(:parse).and_return(atom=stub('Atom', :items=>entries, :title=>mock('', :content => :feed_title), :links=>[link=mock('Link', :type=>'text/html', :href=>:feed_url)]))
    feed.should_receive(:update_attributes).with(:name=>:feed_title, :url=>:feed_url)
    feed.stub!(:puts)
    feed.get_posts_from_atom(xml=mock('XML Feed'))
    feed.should_receive(:get_latest)
    feed.save
  end

  it 'should get name and url from rss feed xml if blank' do
    feed = Feed.new(:author => "value for author", :feed_url => "value for feed_url")
    items = stub('Items', :each=>true, :blank? => false)
    RSS::Parser.should_receive(:parse).and_return(rss=stub('Rss', :items=>items, :channel=>stub('Channel', :title=>:feed_title, :link=>:feed_url)))
    feed.should_receive(:update_attributes).with(:name=>:feed_title, :url=>:feed_url)
    feed.get_posts_from_rss(xml=mock('XML Feed'))
    feed.should_receive(:get_latest)
    feed.save
  end

  describe '#to_param' do
    subject { Feed.new(:author => "Alex Rothenberg") }
    its(:to_param) { should =~ /(\d*)-Alex_Rothenberg/ }
  end

  describe '.by_most_recent_post' do
    let(:alex) { FactoryGirl.create :feed }
    let(:pat)  { FactoryGirl.create :feed }
    let(:amit) { FactoryGirl.create :feed }
    before do
      FactoryGirl.create(:post, :feed => alex, :published => 1.year.ago)
      FactoryGirl.create(:post, :feed => alex, :published => 1.month.ago)
      FactoryGirl.create(:post, :feed => pat,  :published => 2.days.ago)
      FactoryGirl.create(:post, :feed => pat,  :published => 1.day.ago)
      FactoryGirl.create(:post, :feed => amit, :published => 2.months.ago)
    end
    subject { Feed.by_most_recent_post }
    it { should == [pat, alex, amit] }
  end

  describe 'following on twitter' do
    let(:feed_with_twitter_account   ) { FactoryGirl.build :feed, :twitter_username => 'alexrothenberg' }
    describe 'in Production' do
      before { Rails.env.stub(:production?).and_return(true) }
      describe 'for feed without a twitter account' do
        let(:feed_without_twitter_account) { FactoryGirl.create :feed, :twitter_username => nil               }
        subject { FactoryGirl.create :feed, :twitter_username => nil }
        it 'should not follow' do
          Twitter.should_not_receive(:follow)
          subject
        end
        its(:twitter_username             ) { should == nil }
        its(:twitter_username_with_at_sign) { should == nil }
      end
      describe 'for feed with a twitter account' do
        let(:feed) { FactoryGirl.create :feed, :twitter_username => 'alexrothenberg' }
        before do
          Twitter.should_receive(:follow).with('alexrothenberg')
        end
        subject { feed }
        its(:twitter_username             ) { should == 'alexrothenberg' }
        its(:twitter_username_with_at_sign) { should == '@alexrothenberg' }
        describe 'updating with an @ prefix' do
          before do
            Twitter.should_receive(:follow).with('alex_rothenberg2')
            feed.update_attributes(:twitter_username => '@alex_rothenberg2')
          end
          subject { feed }
          its(:twitter_username             ) { should == 'alex_rothenberg2' }
          its(:twitter_username_with_at_sign) { should == '@alex_rothenberg2' }
        end
      end
    end
    describe 'in Development does not tweet' do
      before { Rails.env.should_not be_production }
      it 'should not follow' do
        Twitter.should_not_receive(:follow)
        FactoryGirl.build :feed, :twitter_username => 'alexrothenberg'
      end
    end
  end

end
