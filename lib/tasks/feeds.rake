namespace :feeds do
  desc "Load the feeds"
  task :populate => :environment do
    feeds = Feed.all
    feeds.each do |feed|
      begin
        feed.get_latest
      rescue 
        puts "Error getting feed for #{feed.inspect} #{$!}"
      end
    end
  end
end