require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do

  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all posts as @posts" do
      Post.should_receive(:find).with(:all).and_return([mock_post])
      get :index
      assigns[:posts].should == [mock_post]
    end

    describe "with mime type of xml" do
  
      it "should render all posts as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Post.should_receive(:find).with(:all).and_return(posts = mock("Array of Posts"))
        posts.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

end
