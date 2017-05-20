# frozen_string_literal: true

# Service object to get and parse weather information for a given location
class GetWeatherForecast
  DARKSKY_API_URL = 'https://api.darksky.net/forecast'

  def initialize(config, oracle = nil)
    oracle ||= WeatherOracle
    @oracle = oracle.new(config.DARKSKY_API_KEY)
  end

  # Return processed forecast given a location
  # Parameter:
  #   location_hash: Hash of lat/long information
  #                  {latitude: '12.21', longitude: '121.21'}
  #                  {'latitude' => 12.21, 'longitude' => 121.21 }
  # Example:
  #   GetWeatherForecast.new(app.settings.config)
  #                     .call(app.settings.config.LOCATIONS.first)
  def call(location_hash)
    forecasts = @oracle.get_forecast(location_hash)
    process_forecasts(forecasts)
  end

  private

  def process_forecasts(forecasts)
    daily_hourly = only_report(forecasts, %w[daily hourly])

    daily_hourly.each do |_, time_forecast|
      time_forecast['data'].each.with_index do |forecast, index|
        forecast['ahead'] = index
        copy_over(forecasts, forecast, %w[latitude longitude timezone offset])
        time_keys = forecast.keys.select { |key| key.match?(/[Tt]ime$/) }
        time_keys.each do |time_key|
          forecast[time_key] = Time.at(forecast[time_key].to_i).to_s
        end
      end
    end

    only_data(daily_hourly)
  end

  def only_report(hash, keys)
    keys.map { |k| [k, hash[k]] }.to_h
  end

  def only_data(hash)
    hash.map do |k, v|
      [k, v['data']]
    end.to_h
  end

  def copy_over(from, to, keys)
    keys.each do |key|
      to[key] = from[key]
    end
  end
end
