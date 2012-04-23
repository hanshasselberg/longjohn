require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "active_resource/railtie"
require "sprockets/railtie" # Uncomment this line for Rails 3.1+


if defined?(Bundler)
  Bundler.require *Rails.groups(:assets => %w(development test))
end

module Longjohn
  class Application < Rails::Application
    config.time_zone = 'Berlin'
    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
