source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'sqlite3'

# Template engine.
gem 'haml'

# Simplify the creation of forms.
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'

# Add sugar to ActiveRecord API.
gem 'squeel'

# Define default values for models.
gem 'default_value_for'

# Get only few properties from models without instantiate them.
gem 'valium'

# Handle background and delayed jobs.
gem 'resque'
gem 'resque-scheduler'
gem 'resque-jobs-per-fork'

# Needed to use 'has_secure_password'
gem 'bcrypt-ruby', '~> 3.0.0'

# Push server.
gem 'juggernaut'

# Build JSON views.
gem 'rabl'
gem 'yajl-ruby'

# Integrate Backbone.
gem 'backbone-on-rails'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'handlebars_assets'
  gem 'jquery-rails'
  gem 'anjlab-bootstrap-rails', require: 'bootstrap-rails'
end

group :development, :test do
  gem 'foreman'
  gem 'awesome_print'
end

group :test do
  gem 'watchr'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'spork', '~> 0.9.0.rc'
end
