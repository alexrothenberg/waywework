class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :feed_url_id
      t.text :contents
      t.string :title
      t.string :url
      t.date :published

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
