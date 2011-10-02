require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/new.html.erb" do
  include AtomFeedHelper
  
  before(:each) do
    assign(:feed, stub_model(Feed,
      :new_record? => true,
      :author => "value for author",
      :feed_url => "value for feed_url"
    ))
  end

  it "should render new form" do
    render

    pending 'the form is causing problems in this spec'
    assert_select("form[action=?][method=post]", feeds_path) do
      with_tag("input#feed_author[name=?]", "feed[author]")
      with_tag("input#feed_feed_url[name=?]", "feed[feed_url]")
    end
  end
end


