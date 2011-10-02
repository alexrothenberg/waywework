require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "route recognition" do
  it "should generate params for #root" do
    get("/").should route_to("posts#index")
  end

  it "should generate params for #atom" do
    get("/atom").should route_to("posts#index", :format=>:atom)
  end

  it "should generate params for #by_month" do
    get("/month/2008/10").should route_to("posts#by_month", :year=>'2008', :month=>'10')
  end

  it "should generate params for #by_author" do
    get("/author/8").should route_to("posts#by_author", :id=>'8')
  end

end
