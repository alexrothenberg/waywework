require 'atom'
require 'net/http'
require 'uri'

class Feed < ActiveRecord::Base
  has_many :posts
  
  def get_feed
    uri = URI.parse(feed_url)
    uri.read
  end
  
  def get_posts
    posts = []
    xml = get_feed
    doc = Hpricot::XML(xml)
    (doc/:entry).each do |entry| 
      contents = (entry/:content).inner_html.strip!
      url = (entry/'link[@type="text/html"]').attr('href')
      title = (entry/:titlea).inner_html
      published_date = (entry/:published).inner_html.strip!
      
      posts << Post.new(:contents=>contents, :url=>url, :title=>title, :published=>published_date)
    end
    posts
  end
  
  
  def get_posts
    feed = Atom::Feed.new(get_feed)

    posts = []
    feed.entries.each { |entry|
      posts << Post.new(:contents=>entry.content.value.strip!, :url=>entry.links[0].href, :title=>entry.title, :published=>entry.published.to_s(:db))
    }
    posts
  end  
end
