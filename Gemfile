source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
ruby '2.6.5'

# config
gem 'rails', '5.2.3'

# middleware
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'

# frontend
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'html2slim'
gem 'bootstrap'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'kaminari'

# backend
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rails-i18n', '~> 5.1'
gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
  gem 'rails-flog', require: 'flog'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
end


