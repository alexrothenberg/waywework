# WayWeWork

## Introduction
WayWeWork is a RSS and Atom feed aggregator. It has an ability to collect blogs from different sources and show them at one place. It also has an ability to poll the sources and update the database as new blogs get published.

Formats supported are Atom and RSS.

## Main Features

* Register/ manage sources of feeds.
* Collect posts from registered sources.
* Get new posts from registered sources.
* Tweet about the new posts received.
* Categorize feeds and provide filters for easy look up.
* Show a list of contributors in chronological order of their latest blog posts.
* Infinite scrolling on the website to pull more blog posts when requested by a user.

## Technology Stack

The application uses the following:

* Ruby 2.0
* Rails 4.0
* Sqlite 3

## Installation

### Pre requisites
Before you install the application, please ensure you have the following:

1. RVM
2. Ruby 2.0


### Installing the app

To install the app, run the following

    git clone <THIS REPOSITORY>
    cd waywework
    rvm use 2.0.0
    rake db:migrate
    rake feeds:initialize
    rails server

The application can then be accessed at [http://localhost:3000](http://localhost:3000)

