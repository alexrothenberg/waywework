atom_feed(:url => atom_feed_url) do |feed|
  feed.title("WayWeWork")
  feed.updated(@posts.first.published)

  for post in @posts
    feed.entry(post, :url=>post.url) do |entry|
      entry.title(post.title)
      entry.content(post.contents, :type => 'html')

      entry.author do |author|
        author.name(post.feed.author)
      end
    end
  end
end
