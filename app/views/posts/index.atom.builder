atom_feed(:url => atom_feed_url, :schema_date => 2005) do |feed|
  feed.title("WayWeWork")
  feed.updated(@posts.first.published)

  for post in @posts
    feed.entry(post, :url=>post.url, :published=>post.published, :updated=>post.updated) do |entry|
      entry.title("#{post.feed.author}: #{post.title}")
      entry.content(post.contents, :type => 'html')
      entry.author(post.feed.author)
    end
  end
end
