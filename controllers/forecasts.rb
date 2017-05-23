# frozen_string_literal: true

require 'sinatra'

# Web API endpoint to retrieve and store weather forecasts
class WeatherWeaverAPI < Sinatra::Base
  post '/api/forecasts' do
    content_type 'application/json'

    settings.config.LOCATIONS.each do |location|
      forecasts = GetWeatherForecast.new(@oracle).call(location)
      StoreWeatherForecast.new(@repo).call(forecasts) do |table, forecast, result|
        puts "#{location}: #{table}"
      end
    end

    { message: 'forecasts successully retrieved and stored' }.to_json
  end

  get '/api/forecasts' do
    content_type 'application/json'

    location = settings.config.LOCATIONS.first
    forecasts = GetWeatherForecast.new(@oracle).call(location)

    { data: forecasts }.to_json
  end
end
