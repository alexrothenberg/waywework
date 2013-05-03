# Load the rails application.
require File.expand_path('../application', __FILE__)

# Initialize the rails application.
WayWeWork::Application.initialize!
Mime::Type.register "application/xml+atom", :atom
