atom_feed(:url => atom_feed_url) do |feed|
  feed.title("WayWeWork")
  feed.updated(@posts.first.published)

  for post in @posts
    feed.entry(post, :url=>post.url, :published=>post.published) do |entry|
      entry.title("#{post.feed.author}: #{post.title}")
      entry.content(post.contents, :type => 'html')
    end
  end
end
