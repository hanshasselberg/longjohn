require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  config.mock_with :mocha

  config.include(Spec::Support::DefaultParams, :type => :controller)

  config.before(:each) do
    Mongoid.purge!
  end
end
