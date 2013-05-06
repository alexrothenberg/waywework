class PostsController < ApplicationController
  @@styles = [:red, :orange, :green, :lime, :purple, :yellow, :black, :blue]

  # GET /posts
  def index
    page = get_offset params
    @posts = arrange Post.most_recent_first.offset(page).limit(40).load
    nav_info
    
    respond_to do |format|
      format.html
      format.atom
    end if !params[:page]
    render action: "page", layout: false if params[:page]
  end

  # GET /posts/by_author
  def by_author
    page = get_offset params
    @posts = arrange Post.most_recent_first.offset(page).limit(40).find_all_by_feed_id(params[:id])
    nav_info
    render :action=>:index if !params[:page]
    render action: "page", layout: false if params[:page]
  end

  # GET /posts
  def by_month
    page = get_offset params
    @posts = arrange Post.most_recent_first.offset(page).limit(40).by_date_published(Date.strptime("#{params[:year]}-#{params[:month]}", "%Y-%m"))
    nav_info
    render :action=>:index if !params[:page]
    render action: "page", layout: false if params[:page]
  end

  def by_category
    page = get_offset(params, 60)
    @posts = arrange Post.most_recent_first.offset(page).limit(60).find_all_by_category(params[:category])
    nav_info
    render :action=>:index if !params[:page]
    render action: "page", layout: false if params[:page]
  end

protected
  def nav_info
    @active_feeds = Feed.by_most_recent_post
    @activity_by_date = Post.activity_by_date
  end

  def get_offset(params, entries_per_page = 40)
    page = params[:page]
    page ||= 1
    (page.to_i-1)*entries_per_page
  end

  def arrange(posts)
    rows = []
    row = []
    post_index = 0
    posts.each do |post|
      row = [] if (post_index % 4 == 0)
      rows << row if (post_index % 4 == 0)
      post.styleClass = @@styles[post_index % 4] if rows.length % 2 == 1
      post.styleClass = @@styles[4 + (post_index % 4)] if rows.length % 2 == 0
      row << post
      post_index += 1
    end

    rows
  end
end
