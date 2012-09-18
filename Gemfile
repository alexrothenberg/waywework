source 'http://rubygems.org'
ruby '1.8.7'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

gem 'json'
gem 'twitter'
gem 'atom'
gem 'jquery-rails'
gem "haml-rails"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end


# Heroku config
group :production do
  # gem 'therubyracer'
  gem 'pg'
  gem 'thin'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :development do
  # To use debugger
  gem 'ruby-debug'
end

group :development, :test do
  gem "rspec-rails"
end

group :test do
  gem "factory_girl_rails"
  gem 'faker'
  gem 'webmock'
end
