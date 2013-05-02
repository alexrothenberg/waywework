== README

This is a Ruby on Rails based feed aggregator. 

Formats supported are Atom and RSS

This is a Ruby 2.0 and Rails 4.0 app.

To install the app, run the following

    git clone git@github.com:alexrothenberg/waywework.git
    cd waywework
    rvm use 2.0.0
    rake db:migrate
    rake feeds:initialize
    rails server

The app can be accessed at http://localhost:3000

