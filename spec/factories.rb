FactoryGirl.define do
  factory :feed do 
    url              { "http://#{Faker::Internet.domain_name}" }
    feed_url         { "#{url}/feed"                }
    name             { Faker::Lorem.words.join(' ') }
    author           { Faker::Name.name             }
    twitter_username { "@#{author.gsub(' ', '_')}"  }
  end
  factory :post do 
    feed
    contents           { Faker::Lorem.paragraphs.join(' ') }
    title              { Faker::Lorem.words.join(' ')      }
    url                { "#{feed.url}/#{title.gsub(' ', '/')}" }
    published          { rand(1).days.ago }
  end
end

