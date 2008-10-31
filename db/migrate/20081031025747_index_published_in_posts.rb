class IndexPublishedInPosts < ActiveRecord::Migration
  def self.up
    add_index :posts, [:published, :feed_id]
  end

  def self.down
    remove_index :posts, [:published, :feed_id]
  end
end
