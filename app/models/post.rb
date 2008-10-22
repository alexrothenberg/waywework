class Post < ActiveRecord::Base
  named_scope :most_recent_first, :order=>'published desc'
  
  belongs_to :feed
end
