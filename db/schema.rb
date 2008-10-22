# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081022162832) do

  create_table "feeds", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.string   "feed_url"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "feed_url_id"
    t.text     "contents"
    t.string   "title"
    t.string   "url"
    t.date     "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
