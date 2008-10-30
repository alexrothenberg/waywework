class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.most_recent_first
    @active_feeds = Feed.by_author
    @activity_by_date = Post.activity_by_date

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

end
