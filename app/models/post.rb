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

class Post < ActiveRecord::Base
  scope :most_recent_first, order('posts.published desc')
  scope :by_date_published, lambda {|date| where(["published <= ? and published >= ?", date.end_of_month, date.beginning_of_month]) }
  
  belongs_to :feed

  after_create :tweet
  delegate :twitter_username, :twitter_username_with_at_sign, :to => :feed
  
  def Post.activity_by_date
    activity = Post.count(:published, :group=>"published") #date_format(published, '%Y-%c')")
    activity_by_date = {}
    activity.each do |row|
      # raise row[0].year.inspect
      year,month = row[0].year, row[0].month #row[0].split '-'
      activity_for_this_year = activity_by_date[year.to_i] ||= {}
      activity_for_this_year[month.to_i] = row[1]
    end
    activity_by_date
  end
  
  def tweet
    if Rails.env.production? && twitter_username
      short_url_length = 20 # should query as this may change.  See https://dev.twitter.com/docs/tco-link-wrapper/faq#Will_t.co-wrapped_links_always_be_the_same_length
      non_title_part_of_tweet = " #{'x'*short_url_length} via #{twitter_username_with_at_sign}"
      max_title_length = 140 - non_title_part_of_tweet.length
    
      Twitter.update("#{title.truncate(max_title_length)} #{url} via #{twitter_username_with_at_sign}")
    end
  end
end
