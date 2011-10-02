require 'spec_helper'

describe "routing" do
  it "should generate params for #index" do
    get("/feeds").should route_to('feeds#index')
  end

  it "should generate params for #new" do
    get("/feeds/new").should route_to("feeds#new")
  end

  it "should generate params for #create" do
    post("/feeds").should route_to("feeds#create")
  end

  it "should generate params for #show" do
    get("/feeds/1").should route_to("feeds#show", :id => "1")
  end

  it "should generate params for #edit" do
    get("/feeds/1/edit").should route_to("feeds#edit", :id => "1")
  end

  it "should generate params for #update" do
    put("/feeds/1").should route_to("feeds#update", :id => "1")
  end

  it "should generate params for #destroy" do
    delete("/feeds/1").should route_to("feeds#destroy", :id => "1")
  end
end
