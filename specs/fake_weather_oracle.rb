# frozen_string_literal: true

require 'yaml'

# Fake oracle fixture class
class FakeWeatherOracle
  DARKSKY_API_URL = 'https://api.darksky.net/forecast'.freeze

  # Include dry-types types into namespace
  module Types
    include Dry::Types.module
  end

  Location = Types::Hash.symbolized(
    longitude: Types::Coercible::Float,
    latitude: Types::Coercible::Float
  )

  module Error
    class NoConnection < StandardError; end
  end

  def initialize(api_key)
    raise unless api_key
  rescue
    raise Error::NoConnection 'Not enough parameters to establish connection'
  end

  # input the location and get the forecast
  # location_hash: has such as {latitude: '12.21', longitude: '121.21'}
  #                or {'latitude' => 12.21, 'longitude' => 121.21 }
  #  Example:
  #    oracle = WeatherOracle.new(app.settings.config.DARKSKY_API_KEY)
  #    forecast = oracle.get_forecast(app.settings.config.LOCATIONS.first)
  def get_forecast(location_hash)
    raise unless location_hash
    YAML.safe_load(File.read('specs/fixtures/forecast.yml'))
  end
end
