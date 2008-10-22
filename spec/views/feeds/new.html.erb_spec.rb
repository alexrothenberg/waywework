require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/new.html.erb" do
  include FeedsHelper
  
  before(:each) do
    assigns[:feed] = stub_model(Feed,
      :new_record? => true,
      :url => "value for url",
      :name => "value for name",
      :feed_url => "value for feed_url"
    )
  end

  it "should render new form" do
    render "/feeds/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", feeds_path) do
      with_tag("input#feed_url[name=?]", "feed[url]")
      with_tag("input#feed_name[name=?]", "feed[name]")
      with_tag("input#feed_feed_url[name=?]", "feed[feed_url]")
    end
  end
end


