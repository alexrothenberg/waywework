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
  named_scope :most_recent_first, :order=>'published desc'
  named_scope :by_date_published, lambda {|date| {:conditions=>["date_format(published, '%Y-%c')=?", date]}}
  
  belongs_to :feed
  
  def Post.activity_by_date
    activity = Post.count(:published, :group=>"date_format(published, '%Y-%c')")
    activity_by_date = {}
    activity.each do |row|
      year,month = row[0].split '-'
      activity_for_this_year = activity_by_date[year.to_i] ||= {}
      activity_for_this_year[month.to_i] = row[1]
    end
    activity_by_date
  end
end
