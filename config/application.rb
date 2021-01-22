require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MeMixRestart
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    RSpotify::authenticate(Rails.application.credentials.spotify[:SPOTIFY_API_KEY], Rails.application.credentials.spotify[:SPOTIFY_API_SECRET])
    # Configuration for the application, engines, and railties goes here.
    config.autoload_paths += Dir[Rails.root.join('app', 'models', 'apis')]
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
