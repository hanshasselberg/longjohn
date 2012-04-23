require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "active_resource/railtie"


if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
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
