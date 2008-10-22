namespace :feeds do
  desc "Load the feeds"
  task :populate => :environment do
    feeds = Feed.all
    feeds.each do |feed|
      feed.get_latest
    end
  end
end