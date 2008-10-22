require 'atom'
require 'net/http'
require 'uri'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class Feed < ActiveRecord::Base
  has_many :posts
  
  def get_feed
    uri = URI.parse(feed_url)
    uri.read
  end
  
  
  def get_posts_from_atom atom_xml
    feed = Atom::Feed.new(atom_xml)

    posts = []
    feed.entries.each { |entry|
      posts << Post.new(:contents=>entry.content.value.strip!, :url=>entry.links[0].href, :title=>entry.title, :published=>entry.published.to_s(:db))
    }
    posts
  end  
  
  def get_posts_from_rss rss_xml
    rss = RSS::Parser.parse(rss_xml, false)

    posts = []
    rss.items.each { |entry|
      d = entry.date
      posts << Post.new(:contents=>entry.description.strip!, :url=>entry.link, :title=>entry.title, :published=>entry.date.to_formatted_s(:db))
    }
    posts
  end


  def get_latest
    xml = get_feed
    if xml =~ /rss/
      posts = get_posts_from_rss xml
    else
      posts = get_posts_from_atom xml
    end
    posts.each {|post| post.save }
  end
      
end
