desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts "Updating all feeds"
  Feed.update_all
  puts "done."
end