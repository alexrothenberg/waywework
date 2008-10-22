require 'hpricot'

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
    xml = get_feed
    atom = Hpricot::XML(xml)
    (atom/:entry).each do |item|
      link_raw = item.%('feedburner:origLink') || (item/'link[@type="text/html"][@rel="alternate"]').attr('href')
      
      if link_raw.is_a? String
        link = link_raw
      else
        if !link_raw.blank?
          link = (link_raw).inner_html
        else
          link = (item/:link).attr('href')
        end 
      end
      
      if (Feed.find_by_link(link)).blank?
        atom_feed = Feed.new
        atom_feed.feed_url = self
        atom_feed.site_link = site_link
        atom_feed.site_title = site_title
        atom_feed.title = (item/:title).inner_html
        atom_feed.link = link
        atom_feed.author = (item/:author/:name).inner_html
        atom_feed.content = (item/:content).inner_html
        atom_feed.published = (item/:published).inner_html

        if atom_feed.content.blank?
          atom_feed.content =  (item/:summary).inner_html
        end

        if atom_feed.published.blank?
          atom_feed.published =  (item/:updated).inner_html
        end

        if atom_feed.published.blank?
          # taking it 20 days back..
          atom_feed.published =  (Time.now - (20*60*60*24) - time_offset.hours).to_s(:db)
          time_offset += 1
        end
        
        atom_feed.title = htmlize(atom_feed.title)
        atom_feed.content = htmlize(atom_feed.content, link)
        atom_feed.save!
      end
    end  end  
end
