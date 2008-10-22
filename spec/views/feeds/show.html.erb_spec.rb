require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/show.html.erb" do
  include FeedsHelper
  
  before(:each) do
    assigns[:feed] = @feed = stub_model(Feed,
      :url => "value for url",
      :name => "value for name",
      :feed_url => "value for feed_url"
    )
  end

  it "should render attributes in <p>" do
    render "/feeds/show.html.erb"
    response.should have_text(/value\ for\ url/)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ feed_url/)
  end
end

