namespace :feeds do
  desc "Load the initial feeds"
  task :initialize => :environment do
    Feed.destroy_all

    # Feed.create!(:author=>'Matt Bauer',             :feed_url=>'http://feeds.feedburner.com/mmmultiworks',             :url=>'http://blog.mmmultiworks.com/',         :name=>'Mosquito Mole Multiworks - Home')
    # Feed.create!(:author=>'Matt Deiters',           :feed_url=>'http://www.theagiledeveloper.com/xml/rss20/feed.xml',  :url=>'http://www.theagiledeveloper.com/',         :name=>'The Agile Developer')
    Feed.create!(:author=>'Abhishek Dharga',        :feed_url=>'http://abhishekdharga.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Aishwarya Singhal',      :feed_url=>'http://aishwaryasinghal.wordpress.com/feed/', :category => :technology)
    Feed.create!(:author=>'Alex Rothenberg',        :feed_url=>'http://feeds2.feedburner.com/alexrothenberg', :category => :technology)
    Feed.create!(:author=>'Amit Kumar',             :feed_url=>'http://rubyizednrailified.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Bhargav Gandhi',         :feed_url=>'http://bhargavgandhi.blogspot.com/feeds/posts/default',         :url=>'http://bhargavgandhi.blogspot.com/',         :name=>'AGILE SOFTWARE DEVELOPMENT', :category => :technology)
    Feed.create!(:author=>'Binoy Shah',             :feed_url=>'http://shahbinoy.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Doel Sengupta',          :feed_url=>'http://doelsengupta.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Gourav Tiwari',          :feed_url=>'http://gouravtiwari.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'James Torio',            :feed_url=>'http://jamestorio.com/blog/feed/', :category => :technology)
    #Feed.create!(:author=>'Jen Ji',                 :feed_url=>'http://web.me.com/garden.of.eden/Replace_Wish_with_Can/Blog/rss.xml', :category => :technology)
    Feed.create!(:author=>'Karthik Ramachandra ',   :feed_url=>'http://s-r-k.blogspot.com/feeds/posts/default',        :url=>'http://s-r-k.blogspot.com/',         :name=>'Concrete Abstractions', :category => :technology)
    Feed.create!(:author=>'Karthik',                :feed_url=>'http://karthiksr.blogspot.com/feeds/posts/default',    :url=>'http://karthiksr.blogspot.com/',         :name=>'Chain of Thoughts', :category => :technology)
    Feed.create!(:author=>'Lalatendu Das',          :feed_url=>'http://techno-realism.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Lalita Chandel',         :feed_url=>'http://lalitachandel.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Manohar Amrutkar',       :feed_url=>'http://mrails.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Michael Idinopulos',     :feed_url=>'http://michaeli.typepad.com/my_weblog/atom.xml', :category => :technology)
    Feed.create!(:author=>'Nilesh Naik',            :feed_url=>'http://nileshravinaik.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Niranjan Sarade',        :feed_url=>'http://niranjansarade.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Nirmal Merchant',        :feed_url=>'http://nmerchant.tumblr.com/rss', :category => :technology)
    Feed.create!(:author=>'Pat Shaughnessy',        :feed_url=>'http://feeds2.feedburner.com/patshaughnessy', :category => :technology)
    Feed.create!(:author=>'Prasoon Sharma',         :feed_url=>'http://prasoon.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Queenie Takes Manhattan',:feed_url=>'http://queenietakesmanhattan.blogspot.com/feeds/posts/default?alt=rss', :category => :trivia)
    Feed.create!(:author=>'Riju Kansal',            :feed_url=>'http://aaoblogkare.blogspot.com/feeds/posts/default', :category => :technology)
    #Feed.create!(:author=>'Rocky Jaiswal',          :feed_url=>'http://rockyj.in/?feed=rss2', :category => :technology)
    Feed.create!(:author=>'Rohan Daxini',           :feed_url=>'http://rohandaxini.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Rohan Kini',             :feed_url=>'http://blog.bumsonthesaddle.com/feed/', :category => :trivia)
    Feed.create!(:author=>'Rohan Kini',             :feed_url=>'http://rohan-kini.livejournal.com/data/atom', :category => :technology)
    Feed.create!(:author=>'Ryan Kinderman',         :feed_url=>'http://kinderman.net/articles.atom',                   :url=>'http://kinderman.net/',         :name=>'kinderman.net : ', :category => :technology)
    Feed.create!(:author=>'Suman Thareja',          :feed_url=>'http://sumanthareja.wordpress.com/feed/', :category => :technology)
    Feed.create!(:author=>'Surbhi Bhati',           :feed_url=>'http://cleandeskjammedrawers.blogspot.com/feeds/posts/default', :category => :technology)
    Feed.create!(:author=>'Yashashree Barve',       :feed_url=>'http://yashasree.blogspot.com/feeds/posts/default', :category => :technology)
  end

  desc "Populate the feeds"
  task :populate => :environment do
    Feed.update_all
  end
end