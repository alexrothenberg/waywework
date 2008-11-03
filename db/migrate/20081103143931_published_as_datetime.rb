class PublishedAsDatetime < ActiveRecord::Migration
  def self.up
    change_column(:posts, :published, :datetime)
    add_column(:posts, :updated, :datetime)
  end

  def self.down
    change_column(:posts, :published, :date)
    remove_column(:posts, :updated)
  end
end
