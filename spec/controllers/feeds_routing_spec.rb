require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeedsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "feeds", :action => "index").should == "/feeds"
    end
  
    it "should map #new" do
      route_for(:controller => "feeds", :action => "new").should == "/feeds/new"
    end
  
    it "should map #show" do
      route_for(:controller => "feeds", :action => "show", :id => 1).should == "/feeds/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "feeds", :action => "edit", :id => 1).should == "/feeds/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "feeds", :action => "update", :id => 1).should == "/feeds/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "feeds", :action => "destroy", :id => 1).should == "/feeds/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/feeds").should == {:controller => "feeds", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/feeds/new").should == {:controller => "feeds", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/feeds").should == {:controller => "feeds", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/feeds/1").should == {:controller => "feeds", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/feeds/1/edit").should == {:controller => "feeds", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/feeds/1").should == {:controller => "feeds", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/feeds/1").should == {:controller => "feeds", :action => "destroy", :id => "1"}
    end
  end
end
