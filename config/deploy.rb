# config valid only for current version of Capistrano
lock '3.4.0'

set :application, ENV["GENESIS_PROJECT_NAME"]
set :repo_url, ENV["PROJECT_REPO"]
set :use_sudo, false
set :bundle_binstubs, nil
set :assets_roles, %w(web app)
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
