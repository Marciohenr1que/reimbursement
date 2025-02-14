# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.1"

gem "rails", "~> 7.1.5", ">= 7.1.5.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jbuilder"
gem "active_storage_validations"
gem "devise"
gem "devise-jwt"
gem "dotenv-rails"
gem "enumerate_it"
gem "rack-cors"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "kaminari"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker", "~> 2.18"
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :test do
  gem "database_cleaner"
end

gem "standard", "~> 1.45"
