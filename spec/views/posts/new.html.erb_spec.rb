require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/new.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:post] = stub_model(Post,
      :new_record? => true,
      :contents => "value for contents"
    )
  end

  it "should render new form" do
    render "/posts/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", posts_path) do
      with_tag("textarea#post_contents[name=?]", "post[contents]")
    end
  end
end


