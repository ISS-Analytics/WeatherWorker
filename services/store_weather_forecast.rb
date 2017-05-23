# frozen_string_literal: true

# Service object to get and parse weather information for a given location
class StoreWeatherForecast
  def initialize(repo)
    @repo = repo
  end

  # Setup Service
  # example:
  #   repo = WeatherRepo.new(config: app.settings.config)
  #   forecast = StoreWeatherForecast.new(repo).call(forecasts)
  def call(all_forecasts)
    all_forecasts.keys.each do |table|
      @repo.use_table(table)
      result = @repo.save(all_forecasts[table])
      yield(table, all_forecasts, result) if block_given?
      # all_forecasts[table].each do |forecast|
      #   result = @repo.save(forecast)
      #   yield(table, forecast, result) if block_given?
      # end
    end
  end
end
