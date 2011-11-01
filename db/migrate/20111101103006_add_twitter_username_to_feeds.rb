class AddTwitterUsernameToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :twitter_username, :string
  end
end
