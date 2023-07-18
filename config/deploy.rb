# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

# server settings
set :application,     "railcar"
set :repo_url,        "git@github.com:shey/railcar.git"
set :user,            'rails'
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :ssh_options,     { :forward_agent => true }

# rbenv settings
set :rbenv_type,      :user
set :rbenv_ruby,      '3.1.2'
set :rbenv_roles,     [:app, :db]

# Bundler settings
set :bundle_jobs,     '2'
set :bundle_roles,    [:app, :db]

# output
set :format,          :airbrussh
set :log_level,       :info

# multistage
set :default_staging, "production"

set :linked_files,    %w{.env}
set :linked_dirs,     fetch(:linked_dirs, []).push(*%w{log pids bundle})

set :assets_roles,    [:web, :app]
set :branch,          ENV['BRANCH'] || 'main'


namespace :deploy do
  desc 'Setup shared deploy directories'
  task :setup do
    invoke "git:check"
    invoke 'deploy:check:directories'
    invoke 'deploy:check:linked_dirs'
    invoke 'deploy:check:make_linked_dirs'
  end

  desc 'Stop everything!'
  task :stop do
    invoke 'unicorn:stop'
  end

  desc 'Start everything'
  task :start do
    invoke 'unicorn:start'
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
end
