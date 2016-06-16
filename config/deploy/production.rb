#This is the SSH port
set :port, 8080

# This is the user to deploy as
set :user, 'jenkins'

# This is the branch to be deployed(develop, release, or master)
set :branch, 'master'

set :deploy_via, :remote_cache
set :use_sudo, false

# This is the server to deploy to
server '159.203.114.28',
       roles: %w(web app db),
       port: fetch(:port),
       user: fetch(:user),
       primary: true

# This is the path the application is to be deployed to. If the server is
# to contain multiple environment deployments, put the application in respective
# environment folders (eg. apps/development/.., apps/test/..)
set :deploy_to, "/home/\#{fetch(:user)}/apps/production/\#{fetch(:application)}"

set :ssh_options, forward_agent: true,
                  auth_methods: %w(publickey),
                  user: 'jenkins'

# The rails environment to use (development, test, production)
set :rails_env, :production
set :conditionally_migrate, true
