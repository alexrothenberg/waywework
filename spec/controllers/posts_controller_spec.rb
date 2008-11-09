require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do

  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all posts as @posts" do
      Post.should_receive(:most_recent_first).and_return(post_proxy=mock('Post named scope proxy'))
      post_proxy.should_receive(:all).with(:limit=>30).and_return([mock_post])
      @controller.should_receive(:nav_info)
      get :index
      assigns[:posts].should == [mock_post]
    end

    describe "with mime type of atom" do
  
      it "should render all posts as atom" do
        request.env["HTTP_ACCEPT"] = "application/xml+atom"
        Post.should_receive(:most_recent_first).and_return(post_proxy=mock('Post named scope proxy'))
        post_proxy.should_receive(:all).with(:limit=>30).and_return([mock_post])
        @controller.should_receive(:nav_info)
        get :index
        assigns[:posts].should == [mock_post]
      end
    
    end

  end

end
