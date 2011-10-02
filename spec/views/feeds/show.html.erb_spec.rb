require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/show.html.erb" do
  include AtomFeedHelper
  
  before(:each) do
    assign(:feed, @feed = stub_model(Feed,
      :url => "value for url",
      :author => 'Alex Rothenberg',
      :name => "value for name",
      :feed_url => "value for feed_url"
    ))
  end

  it "should render attributes in <p>" do
    render
    rendered.should =~ /value\ for\ url/
    rendered.should =~ /value\ for\ name/
    rendered.should =~ /value\ for\ feed_url/
  end
end

