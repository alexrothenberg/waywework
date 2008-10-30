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
  
end
