require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/edit.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:post] = @post = stub_model(Post,
      :new_record? => false,
      :contents => "value for contents"
    )
  end

  it "should render edit form" do
    render "/posts/edit.html.erb"
    
    response.should have_tag("form[action=#{post_path(@post)}][method=post]") do
      with_tag('textarea#post_contents[name=?]', "post[contents]")
    end
  end
end


