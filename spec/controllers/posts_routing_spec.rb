require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do
  describe "route generation" do
    it "should map #atom" do
      route_for(:controller => "posts", :action => "index", :format=>'atom').should == "/atom"
    end
  
    it "should map #posts_by_author" do
      route_for(:controller => "posts", :action => "by_author", :id=>1).should == "/author/1"
    end
  
    it "should map #posts_by_month" do
      route_for(:controller => "posts", :action => "by_month", :year=>2008, :month=>'10').should == "/month/2008/10"
    end
  end

  describe "route recognition" do
    it "should generate params for #root" do
      params_from(:get, "/").should == {:controller => "posts", :action => "index"}
    end
  
    it "should generate params for #atom" do
      params_from(:get, "/atom").should == {:controller => "posts", :action => "index", :format=>"atom"}
    end
  
    it "should generate params for #by_month" do
      params_from(:get, "/month/2008/10").should == {:controller => "posts", :action => "by_month", :year=>'2008', :month=>'10'}
    end
  
    it "should generate params for #by_author" do
      params_from(:get, "/author/8").should == {:controller => "posts", :action => "by_author", :id=>'8'}
    end
  
  end
end
