# frozen_string_literal: true

# Service object to get and parse weather information for a given location
class StoreWeatherForecast
  def initialize(repo)
    @repo = repo
  end

  def call(all_forecasts)
    all_forecasts.keys.each do |table|
      all_forecasts[table].each do |forecast|
        @repo.save(table, forecast)
      end
    end
  end
end
