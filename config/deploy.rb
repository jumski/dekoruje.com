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
set :branch, 'master'
set :scm_verbose, true
set :deploy_via, :remote_cache

# default deploy is on staging
role :app, application
role :web, application
role :db, application, :primary => true
set :user, 'deploy'
set :deploy_to,  "/home/deploy/#{application}"
set :use_sudo, false

before 'bundle:install', 'deploy:symlink_log'
before 'bundle:install', 'deploy:symlink_spree'
after 'deploy', 'nginx:restart'

namespace :nginx do
  desc "Restarts apache webserver"
  task :restart, :roles => :web do
    run "sudo killall nginx && sudo /opt/nginx/sbin/nginx"
  end
end

namespace :deploy do
  desc "Symlinks log/ folder"
  task :symlink_log, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/log #{release_path}/log"
  end

  desc "Symlinks public/spree/ folder"
  task :symlink_spree, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/spree #{release_path}/public/spree"
  end

  desc 'Seeds production database with initial data'
  task :seed_production_database, :roles => :app do
    puts "\n\e[0;31mSeeding production database will ERASE all Page data"
    puts "\n\e[0;31mDo you really want to continue? [y/N]"
    proceed = STDIN.gets[0..0] rescue nil
    exit(1) unless proceed == 'y' || proceed == 'Y'

    run "bundle exec rake db:seed RAILS_ENV=#{rails_env} "
  end
end
