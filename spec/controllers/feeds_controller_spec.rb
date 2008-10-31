require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeedsController do

  def mock_feed(stubs={})
    @mock_feed ||= mock_model(Feed, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all feeds as @feeds" do
      Feed.should_receive(:all).and_return([mock_feed])
      get :index
      assigns[:feeds].should == [mock_feed]
    end

    describe "with mime type of xml" do
  
      it "should render all feeds as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Feed.should_receive(:find).with(:all).and_return(feeds = mock("Array of Feeds"))
        feeds.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested feed as @feed" do
      Feed.should_receive(:find).with("37").and_return(mock_feed)
      get :show, :id => "37"
      assigns[:feed].should equal(mock_feed)
    end
    
    describe "with mime type of xml" do

      it "should render the requested feed as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Feed.should_receive(:find).with("37").and_return(mock_feed)
        mock_feed.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new feed as @feed" do
      Feed.should_receive(:new).and_return(mock_feed)
      get :new
      assigns[:feed].should equal(mock_feed)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested feed as @feed" do
      Feed.should_receive(:find).with("37").and_return(mock_feed)
      get :edit, :id => "37"
      assigns[:feed].should equal(mock_feed)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created feed as @feed" do
        Feed.should_receive(:new).with({'these' => 'params'}).and_return(mock_feed(:save => true))
        post :create, :feed => {:these => 'params'}
        assigns(:feed).should equal(mock_feed)
      end

      it "should redirect to the created feed" do
        Feed.stub!(:new).and_return(mock_feed(:save => true))
        post :create, :feed => {}
        response.should redirect_to(feed_url(mock_feed))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved feed as @feed" do
        Feed.stub!(:new).with({'these' => 'params'}).and_return(mock_feed(:save => false))
        post :create, :feed => {:these => 'params'}
        assigns(:feed).should equal(mock_feed)
      end

      it "should re-render the 'new' template" do
        Feed.stub!(:new).and_return(mock_feed(:save => false))
        post :create, :feed => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested feed" do
        Feed.should_receive(:find).with("37").and_return(mock_feed)
        mock_feed.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :feed => {:these => 'params'}
      end

      it "should expose the requested feed as @feed" do
        Feed.stub!(:find).and_return(mock_feed(:update_attributes => true))
        put :update, :id => "1"
        assigns(:feed).should equal(mock_feed)
      end

      it "should redirect to the feed" do
        Feed.stub!(:find).and_return(mock_feed(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(feed_url(mock_feed))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested feed" do
        Feed.should_receive(:find).with("37").and_return(mock_feed)
        mock_feed.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :feed => {:these => 'params'}
      end

      it "should expose the feed as @feed" do
        Feed.stub!(:find).and_return(mock_feed(:update_attributes => false))
        put :update, :id => "1"
        assigns(:feed).should equal(mock_feed)
      end

      it "should re-render the 'edit' template" do
        Feed.stub!(:find).and_return(mock_feed(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested feed" do
      Feed.should_receive(:find).with("37").and_return(mock_feed)
      mock_feed.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the feeds list" do
      Feed.stub!(:find).and_return(mock_feed(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(feeds_url)
    end

  end

end
