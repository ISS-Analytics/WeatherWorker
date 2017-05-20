# frozen_string_literal: true

require 'http'
require 'dry-types'

# Calling the endpoint to get the data
# Ex:
#  forecaster = WeatherForecast.new(app.settings.config.DARKSKY_API_URL)
#  forecaster.get_forecast(longitude: '121.5439521', latitude: '25.0457906')
class WeatherOracle
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
    @route = [DARKSKY_API_URL, api_key].join('/')
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
    location = Location.call(location_hash)
    loc = [location[:latitude], location[:longitude]].join(',')
    api_endpoint = [@route, loc].join('/')
    JSON.parse(HTTP.get(api_endpoint).body)
  end
end
