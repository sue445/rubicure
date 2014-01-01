require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rubicure'
require 'rspec'
require 'rspec-parameterized'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'delorean'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include Delorean

  config.after(:each) do
    back_to_the_present
  end
end
