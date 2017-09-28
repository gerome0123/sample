source 'https://rubygems.org'

# Supports different databases
group :development, :test do
  gem 'pg'
  gem 'mysql2'
  gem 'sqlite3'
end

group :development, :test do
  gem 'overcommit'

  gem 'guard'
  gem 'guard-spring'
  gem 'guard-rspec', require: false

  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'marginalia'

  gem 'rspec-rails'
  gem 'rspec-activejob'
  gem 'spring-commands-rspec'
  gem 'fuubar'

  gem 'codeclimate-test-reporter', require: false
  gem 'simplecov', require: false

  gem 'rubocop', require: false
  gem 'inch', require: false
  gem 'scss_lint', require: false
  gem 'slim_lint', require: false
  gem 'coffeelint', require: false
  gem 'guard-rubocop', require: false

  gem 'knapsack_pro'
  gem 'faker'
  gem 'ffaker'

  gem 'letter_opener'
  gem 'letter_opener_web'
end

group :test do
  gem 'rails-controller-testing'
  gem 'database_cleaner'

  gem 'factory_girl_rails'
  gem 'mocha'
  gem 'assert_difference'
  gem 'json-schema'

  gem 'shoulda-matchers', '~> 3.0'
  gem 'shoulda-callback-matchers'

  # Assets test
  gem 'teaspoon-mocha'
  gem 'selenium-webdriver'
  gem 'magic_lamp'
  source 'https://rails-assets.org' do
    gem 'rails-assets-chai'
    gem 'rails-assets-chai-jquery'
  end
end
