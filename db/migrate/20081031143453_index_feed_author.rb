class IndexFeedAuthor < ActiveRecord::Migration
  def self.up
    add_index :feeds, :author
  end

  def self.down
    remove_index :feeds, :author
  end
end
