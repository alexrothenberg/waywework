class PostsController < ApplicationController
  @@styles = [:red, :orange, :green, :blue]

  # GET /posts
  def index
    @posts = arrange Post.most_recent_first.all(:limit=>30)
    nav_info
    
    respond_to do |format|
      format.html
      format.atom
    end
  end

  # GET /posts/by_author
  def by_author
    @posts = arrange Post.most_recent_first.limit(50).find_all_by_feed_id(params[:id])
    nav_info
    render :action=>:index
  end

  # GET /posts
  def by_month
    @posts = arrange Post.most_recent_first.limit(50).by_date_published(Date.strptime("#{params[:year]}-#{params[:month]}", "%Y-%m"))
    nav_info
    render :action=>:index
  end

  def by_category
    @posts = arrange Post.most_recent_first.limit(50).find_all_by_category(params[:category])
    nav_info
    render :action=>:index
  end

protected
  def nav_info
    @active_feeds = Feed.by_most_recent_post
    @activity_by_date = Post.activity_by_date
  end

  def arrange(posts)
    rows = []
    row = []
    post_index = 0
    posts.each do |post|
      row = [] if (post_index % 4 == 0)
      rows << row if (post_index % 4 == 0)
      post.styleClass = @@styles[post_index % 4] if rows.length % 2 == 1
      post.styleClass = @@styles[3 - (post_index % 4)] if rows.length % 2 == 0
      row << post
      post_index += 1
    end

    rows
  end
end
