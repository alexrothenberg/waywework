load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do
  task :restart do
    # no-op since we're using passenger 
  end
end

after "deploy:finalize_update" do
  run <<-CMD
    ln -sf #{shared_path}/config/database.yml #{latest_release}/config &&
    ln -s #{shared_path}/config/password.yml #{latest_release}/config 
  CMD
end
