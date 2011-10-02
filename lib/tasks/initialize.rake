desc "Load the feeds"
task :load_data => :environment do
  Feed.destroy_all
  Feed.create!(:author=>'Pat Shaughnessy',        :feed_url=>'http://feeds2.feedburner.com/patshaughnessy',              :url=>'http://patshaughnessy.net', :name=>'Pat Shaughnessy - Home')
  Feed.create!(:author=>'Gourav Tiwari',          :feed_url=>'http://gouravtiwari.blogspot.com/feeds/posts/default', :url=>'http://gouravtiwari.blogspot.com/', :name=>'easy_software = Agile.find(ruby_on_rails)')
  # Feed.create!(:author=>'Matt Deiters',           :feed_url=>'http://www.theagiledeveloper.com/xml/rss20/feed.xml',  :url=>'http://www.theagiledeveloper.com/', :name=>'The Agile Developer')
  Feed.create!(:author=>'Bhargav Gandhi',         :feed_url=>'http://bhargavgandhi.blogspot.com/feeds/posts/default', :url=>'http://bhargavgandhi.blogspot.com/', :name=>'AGILE SOFTWARE DEVELOPMENT')
  Feed.create!(:author=>'Prasoon Sharma',         :feed_url=>'http://prasoon.blogspot.com/feeds/posts/default',      :url=>'http://prasoon.blogspot.com/', :name=>'Enterprise Software Does not Have to Suck')
  Feed.create!(:author=>'Ryan Kinderman',         :feed_url=>'http://kinderman.net/articles.atom',                   :url=>'http://kinderman.net/', :name=>'kinderman.net : ')
  # Feed.create!(:author=>'Matt Bauer',             :feed_url=>'http://feeds.feedburner.com/mmmultiworks',             :url=>'http://blog.mmmultiworks.com/', :name=>'Mosquito Mole Multiworks - Home')
  Feed.create!(:author=>'Alex Rothenberg',        :feed_url=>'http://www.alexrothenberg.com/atom.xml',               :url=>'http://alexrothenberg.blogspot.com/', :name=>'Common Sense Software')
  Feed.create!(:author=>'Queenie Takes Manhattan', :feed_url=>'http://queenietakesmanhattan.blogspot.com/feeds/posts/default?alt=rss', :url=>'http://queenietakesmanhattan.blogspot.com/', :name=>'Queenie Takes Manhattan')
  Feed.create!(:author=>'Rohan Kini',             :feed_url=>'http://blog.bumsonthesaddle.com/feed/atom.xml',        :url=>'http://blog.bumsonthesaddle.com/', :name=>'blog@BumsOnTheSaddle.com - Home')
  Feed.create!(:author=>'Karthik',                :feed_url=>'http://karthiksr.blogspot.com/feeds/posts/default',    :url=>'http://karthiksr.blogspot.com/', :name=>'Chain of Thoughts')
  Feed.create!(:author=>'Karthik Ramachandra ',   :feed_url=>'http://s-r-k.blogspot.com/feeds/posts/default',        :url=>'http://s-r-k.blogspot.com/', :name=>'Concrete Abstractions')
  Feed.create!(:author=>'Rohan Kini',             :feed_url=>'http://rohan-kini.livejournal.com/data/atom',          :url=>'http://rohan-kini.livejournal.com/', :name=>'Confuscionomo')
end


