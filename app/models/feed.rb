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
    feed.entries.each { |entry|
      link = entry.links.detect {|l| l.rel == 'alternate'}
      create_post(:contents=>entry.content.value, :url=>link.href, :title=>entry.title, :published=>entry.published.to_s(:db))
    }
  end  
  
  def get_posts_from_rss rss_xml
    rss = RSS::Parser.parse(rss_xml, false)
    rss.items.each { |entry|
      create_post(:contents=>entry.description.strip!, :url=>entry.link, :title=>entry.title, :published=>entry.date.to_formatted_s(:db))
    }
  end

  def create_post params
    params.merge!(:feed_id=>id) #, :contents=>htmlize(params[:contents]))
    Post.create(params) unless Post.find_by_url(params[:url])
  end

  # htmlize the html codes back.
  def htmlize(string, link=nil)
    return unless string
    string.gsub!('&lt;', '<')
    string.gsub!('&gt;', '>')
    string.gsub!('&amp;', '&')
    string.gsub!('&#39;', "'")
    string.gsub!('&quot;', '"')
    string.gsub!('<![CDATA[', '')
    string.gsub!(']]>', '')
    
    # for image srcs like <img src="/assets/2008/4/23/rails3.jpg_1208810865" />"
    # adding host so that they become valid
    # "<img src="http://www.google.com/assets/2008/4/23/rails3.jpg_1208810865" />"
    if link
      host = URI.parse(link).host
      if host != "feeds.feedburner.com"
        string.gsub!("src=\"/", "src=\"http://"+host+"/")
      end
    end
    return string
  end


  def get_latest
    puts "getting feed for #{name}"
    xml = get_feed
    if xml =~ /<rss/
      get_posts_from_rss xml
    else
      get_posts_from_atom xml
    end
  end
      
end
