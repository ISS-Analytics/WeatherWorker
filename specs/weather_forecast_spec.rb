# frozen_string_literal: true

require_relative './spec_helper.rb'
describe 'WeatherForecast specifications' do
  LOCATION = {latitude: '24.7867056', longitude: '120.9859494'}
  before do
    extend Econfig::Shortcut
    @forecast_request = WeatherForecast.new(config.API_KEY)
  end

  it 'should be able new a WeatherForecast object' do
    @forecast_request.must_be_instance_of WeatherForecast
  end
  it 'should be able to get right content when parse response' do
    response = @forecast_request.get_forecast(LOCATION)
    response['daily'].wont_be_nil
    response['hourly'].wont_be_nil
  end
end
