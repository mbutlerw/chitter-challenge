ENV["RACK_ENV"] = "test"

require 'coveralls'
require 'simplecov'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
Coveralls.wear!

require './app/models/post'
require './app/models/user'
require 'capybara/rspec'
require './app/app'
require 'database_cleaner'
require_relative './web_helpers'

require_relative 'helpers/session'

Capybara.app = Chitter

RSpec.configure do |config|

  config.include Capybara::DSL
  config.include SessionHelpers

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end


  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end


  config.after(:each) do
    DatabaseCleaner.clean
  end


end
