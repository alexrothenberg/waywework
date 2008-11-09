set :application, "waywework"
set :repository,  "git://github.com/alexrothenberg/waywework.git"

set :deploy_via, :remote_cache 

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "~/apps/#{application}.it"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

set :user, 'patshau'
set :use_sudo, false


role :app, "patshaughnessy.net"
role :web, "patshaughnessy.net"
role :db,  "patshaughnessy.net", :primary => true