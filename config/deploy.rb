$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano_colors'

# rvm opts
set :rvm_ruby_string, 'ruby-1.9.3-p0'
set :rvm_type, :user # use per-user rvm

set :application, "dekoruje.com"
ssh_options[:forward_agent] = true

# SCM opts
set :scm, :git
set :repository, "git://github.com/jumski/dekoruje.com.git"
set :branch, 'production'
set :scm_verbose, true

# default deploy is on staging
server application, :web, :db, :app
set :user, 'deploy'
set :deploy_to,  "/home/deploy/#{application}"

before 'bundle:install', 'deploy:symlink_log'
after 'deploy', 'nginx:restart'

namespace :deploy do
  desc "Deploy the MFer"
  task :default do
    update
    restart
    cleanup
  end

  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    run "git clone #{repository} #{current_path}"
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
  end

  desc "Rollback a single commit."
  task :rollback, :except => { :no_release => true } do
    set :branch, "HEAD^"
    default
  end
end

namespace :nginx do
  desc "Restarts apache webserver"
  task :restart, :roles => :web do
    run "sudo killall nginx && sudo /etc/init.d/nginx start"
  end
end

namespace :deploy do
  desc "Symlinks log/ folder"
  task :symlink_log, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/log #{release_path}/log"
  end

  desc 'Seeds production database with initial data'
  task :seed_production_database, :roles => :app do
    puts "\n\e[0;31mSeeding production database will ERASE all Page data"
    puts "\n\e[0;31mDo you really want to continue? [y/N]"
    proceed = STDIN.gets[0..0] rescue nil
    exit(1) unless proceed == 'y' || proceed == 'Y'

    run "cd #{current_path} && FIRST_PRODUCTION_DEPLOY=true RAILS_ENV=production bundle exec rake db:seed"
  end
end
