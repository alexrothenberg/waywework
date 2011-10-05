class PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.most_recent_first.all(:limit=>30)
    nav_info
    
    respond_to do |format|
      format.html
      format.atom
    end
  end

  # GET /posts/by_author
  def by_author
    @posts = Post.most_recent_first.find_all_by_feed_id(params[:id])
    nav_info
    render :action=>:index
  end

  # GET /posts
  def by_month
    @posts = Post.most_recent_first.by_date_published(Date.strptime("#{params[:year]}-#{params[:month]}", "%Y-%m"))
    nav_info
    render :action=>:index
  end

protected
  def nav_info
    @active_feeds = Feed.by_most_recent_post
    @activity_by_date = Post.activity_by_date
  end
end
