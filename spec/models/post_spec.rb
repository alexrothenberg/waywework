# == Schema Information
# Schema version: 20081022162832
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  feed_id    :integer(4)
#  contents   :text
#  title      :string(255)
#  url        :string(255)
#  published  :date
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @valid_attributes = {
      :feed_id => "1",
      :contents => "value for contents"
    }
  end

  it "should create a new instance given valid attributes" do
    Post.create!(@valid_attributes)
  end

  describe 'tweeting after creating' do
    let(:feed_with_twitter_account   ) { FactoryGirl.build :feed, :twitter_username => 'alexrothenberg' }
    describe 'in Production' do
      before { Rails.env.stub(:production?).and_return(true) }
      describe 'for feed without a twitter account' do
        let(:feed_without_twitter_account) { FactoryGirl.create :feed, :twitter_username => nil               }
        it 'should not tweet' do
          Twitter.should_receive(:update).
                  with('This is an interesting blog post http://some.blog.com/2011/about_stuff via @WayWeWorkIT')
          FactoryGirl.create(:post, :title => 'This is an interesting blog post', :url => 'http://some.blog.com/2011/about_stuff', :feed => feed_without_twitter_account)
        end
      end
      describe 'for feed with a twitter account' do
        before { Twitter.should_receive(:follow).with('alexrothenberg') }
        it 'should tweet when' do
          Twitter.should_receive(:update).
                  with('This is an interesting blog post http://some.blog.com/2011/about_stuff via @alexrothenberg')

          FactoryGirl.create(:post, :title => 'This is an interesting blog post',
                                    :url => 'http://some.blog.com/2011/about_stuff',
                                    :feed => feed_with_twitter_account)
        end
        it 'should tweet with truncated title when title is too long' do
          Twitter.should_receive(:update).
                  with('This is an interesting blog post with a really long title that goes on and on for way too long -... http://some.blog.com/2011/about_stuff via @alexrothenberg')

          FactoryGirl.create(:post, :title => 'This is an interesting blog post with a really long title that goes on and on for way too long - in fact so long it needs to be truncated',
                                    :url => 'http://some.blog.com/2011/about_stuff',
                                    :feed => feed_with_twitter_account)
        end
      end
    end
    describe 'in Development does not tweet' do
      before { Rails.env.should_not be_production }
      it 'should not tweet' do
        Twitter.should_not_receive(:update)
        FactoryGirl.create(:post, :feed => feed_with_twitter_account)
      end
    end
  end

end
