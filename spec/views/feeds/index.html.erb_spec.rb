require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/index.html.erb" do
  include FeedsHelper
  
  before(:each) do
    assigns[:feeds] = [
      stub_model(Feed,
        :url => "value for url",
        :name => "value for name",
        :feed_url => "value for feed_url"
      ),
      stub_model(Feed,
        :url => "value for url",
        :name => "value for name",
        :feed_url => "value for feed_url"
      )
    ]
  end

  it "should render list of feeds" do
    render "/feeds/index.html.erb"
    response.should have_tag("tr>td", "value for url", 2)
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for feed_url", 2)
  end
end

