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

require 'rss'
require 'open-uri'

class Feed < ActiveRecord::Base
  has_many :posts, :dependent => :delete_all
  scope :by_most_recent_post, includes(:posts).merge(Post.most_recent_first)
  scope :by_author, order(:author)


  after_create { |feed| feed.get_latest unless feed.name && feed.url}
  after_save :follow_on_twitter
  
  def follow_on_twitter
    if Rails.env.production?
      Twitter.follow(twitter_username) if twitter_username_changed? && !twitter_username.empty?
    end
  end
  
  def twitter_username= twitter_username
    twitter_username = twitter_username.sub('@', '') if twitter_username
    super(twitter_username)
  end
  def twitter_username_with_at_sign
    "@#{twitter_username}" unless twitter_username.blank?
  end

  def to_param
    "#{id}-#{author.gsub(' ', '_')}"
  end

  def get_feed
    uri = URI.parse(feed_url)
    uri.read
  end

  def get_posts_from_atom atom_xml
    feed = RSS::Parser.parse(atom_xml, false)
    atom = true
    feed.items.each do |entry|
      atom = entry.respond_to?(:published)
      if atom && entry.published
        link = entry.links.detect {|l| l.rel == 'alternate'}
        link = entry.links.first unless link
        link = link.href if link
        published = entry.published ? entry.published.content.to_formatted_s(:db) : nil
        updated = entry.updated ? entry.updated.content.to_formatted_s(:db) : nil

        content = entry.summary || entry.content
        content = content.content if (content.type == 'html' || entry.summary) && content.respond_to?(:content)
        create_post(:contents=>content, :url=>link, :title=>entry.title.content, :category=>category,:published=>published.to_s, :updated=>updated.to_s)
      end
    end unless false
    return false if feed.items.blank?
    return false if !atom
    link = feed.links.detect{|link| link.type=='text/html'}
    link = link.href if link
    update_attributes(:name=>feed.title.content, :url=> link) unless name && url
    return true
  end

  def get_posts_from_rss rss_xml
    rss = RSS::Parser.parse(rss_xml, false)
    rss.items.each { |entry|
      create_post(:contents=>entry.description, :url=>entry.link, :title=>entry.title, :category=>category, :published=>entry.date.to_formatted_s(:db), :updated=>entry.date.to_formatted_s(:db))
    }
    return false if rss.items.blank?
    update_attributes(:name=>rss.channel.title, :url=>rss.channel.link) unless name && url
    return true
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
    puts "getting feed for #{author}-#{name}"
    xml = get_feed
    got_atom_posts = get_posts_from_atom xml
    get_posts_from_rss xml unless got_atom_posts
  end

  def self.update_all
    Feed.all.each do |feed|
      begin
        feed.get_latest
      rescue 
        puts "Error updating feed for #{feed.inspect} #{$!}"
      end
    end
  end

end
