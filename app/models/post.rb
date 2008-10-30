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
  
  belongs_to :feed
  
  def Post.activity_by_date
    
    {2008 => 
      {:October => 10,
      :Sepbember => 9,
      :July => 5
      },
      2007 => 
          {:July => 10,
          :June => 9,
          :April => 5
            }
        }
  end
end
