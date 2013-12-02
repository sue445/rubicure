$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rubicure'
require 'rspec'
require 'rspec-parameterized'
require 'delorean'

RSpec.configure do |config|
  config.include Delorean

  config.after(:each) do
    back_to_the_present
  end
end
