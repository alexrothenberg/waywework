set :application, "waywework"
set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "~/apps/#{application}.patshaughnessy.net"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :user, 'patshau'

role :app, "patshaughnessy.net"
role :web, "patshaughnessy.net"
role :db,  "patshaughnessy.net", :primary => true