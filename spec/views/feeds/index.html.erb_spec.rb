require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/index.html.erb" do
  include AtomFeedHelper
  
  before(:each) do
    assign(:feeds, [
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
    ])
  end

  it "should render list of feeds" do
    render
    rendered.should =~ /value for url/
    rendered.should =~ /value for name/
    rendered.should =~ /value for feed_url/
  end
end

