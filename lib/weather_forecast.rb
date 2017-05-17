require 'http'
  # Calling the endpoint to get the data
class WeatherForecast
  DARKSKY_API_URL = 'https://api.darksky.net/forecast'
  def initialize(api_key)
    @route = [DARKSKY_API_URL, api_key].join('/')
  end

  # input the location and get the forecast
  # Input format: location = {latitude: '', longitude: ''}
  def get_forecast(location)
    loc = [location[:latitude], location[:longitude]].join(',')
    api_endpoint = [@route, loc].join('/')
    response = JSON.parse(HTTP.get(api_endpoint).body)
    {'daily' => response['daily'], 'hourly' => response['hourly'] }
  end
end
