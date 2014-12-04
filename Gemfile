source 'https://rubygems.org'
ruby '2.1.3'

gem 'pg', group: [:production]

gem 'thin'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: [:development]

group :assets, :development do
  gem 'sass-rails', '~> 4.0.0' # Use SCSS for stylesheets
  gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
  gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
  gem 'therubyracer', platforms: :ruby # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'jquery-rails'  # Use jquery as the JavaScript library
  gem 'bootstrap-sass'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use debugger
gem 'byebug', group: [:development, :test]

gem 'stripe'

gem 'mocha', group: [:test], require: false

gem 'omniauth'
gem 'omniauth-google-apps'
