source 'http://rubygems.org'

gem 'rails', '3.1.3'

# gem 'spree',            git: 'git://github.com/spree/spree.git'
gem 'spree', '1.0.0'
gem 'spree_i18n',       git: 'git://github.com/jumski/spree_i18n.git'
gem 'spree_blue_theme', git: 'git://github.com/spree/spree_blue_theme.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'mysql2'
end

gem 'therubyracer'
gem 'jquery-rails'


group :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'awesome_print'
  gem 'rdoc-tags'
  gem 'libnotify'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'guard'
  gem 'guard-rails'
  gem 'guard-bundler'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
