# frozen_string_literal: true

require_relative './spec_helper.rb'

describe 'StoreWeatherForecast service' do
  before do
    @fake_forecast = Minitest::Mock.new
    REFINED_FORECAST['daily'].each do |forecast|
      @fake_forecast.expect :save, Object.new, ['daily', forecast]
    end

    REFINED_FORECAST['hourly'].each do |forecast|
      @fake_forecast.expect :save, Object.new, ['hourly', forecast]
    end
  end

  it 'should save all rows of daily and hourly forecasts' do
    StoreWeatherForecast.new(@fake_forecast).call(REFINED_FORECAST)

    _(@fake_forecast.verify).must_equal true
  end
end
