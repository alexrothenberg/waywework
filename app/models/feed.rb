# == Schema Information
# Schema version: 20081022162832
#
# Table name: feeds
#
#  id         :integer(4)      not null, primary key
#  url        :string(255)
#  name       :string(255)
#  feed_url   :string(255)
#  author     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'atom'
require 'net/http'
require 'uri'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'


class Feed < ActiveRecord::Base
  has_many :posts, :dependent => :delete_all

  named_scope :by_author, :order => :author
  
  
  def get_feed
    uri = URI.parse(feed_url)
    uri.read
  end
  
  def get_posts_from_atom atom_xml
    feed = Atom::Feed.new(atom_xml)
    feed.entries.each { |entry|
      link = entry.links.detect {|l| l.rel == 'alternate'}
      create_post(:contents=>entry.content.value, :url=>link.href, :title=>entry.title, :published=>entry.published.to_s(:db), :updated=>entry.updated.to_s(:db))
    }
    return !feed.entries.blank?
  end  
  
  def get_posts_from_rss rss_xml
    rss = RSS::Parser.parse(rss_xml, false)
    rss.items.each { |entry|
      create_post(:contents=>entry.description, :url=>entry.link, :title=>entry.title, :published=>entry.date.to_formatted_s(:db), :updated=>entry.date.to_formatted_s(:db))
    }
    return !rss.items.blank?
  end

  def create_post params
    params.merge!(:feed_id=>id) 
    existing_post = Post.find_by_url(params[:url])
    if existing_post
      existing_post.update_attributes(params)
    else
      Post.create(params) 
    end
  end


  def get_latest
    puts "getting feed for #{name}"
    xml = get_feed
    got_atom_posts = get_posts_from_atom xml
    get_posts_from_rss xml unless got_atom_posts
  end
      
end
